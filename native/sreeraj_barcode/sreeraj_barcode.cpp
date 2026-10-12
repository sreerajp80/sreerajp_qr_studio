// SreerajP QR Studio — native barcode bridge (see sreeraj_barcode.h).

#include "sreeraj_barcode.h"

#include "ReadBarcode.h"

#include <cstdlib>
#include <cstring>
#include <new>
#include <vector>

using namespace ZXing;

namespace {

constexpr const char* kVersion = "1.0.0/zxing-cpp 3.1.1";

// Guard rails against hostile or corrupt inputs.
constexpr int32_t kMaxDimension = 16384;
constexpr int32_t kMaxSymbols = 32;

struct FormatMapping {
	uint32_t bit;
	BarcodeFormat format;
};

// Formats requested from zxing-cpp for each of our bits.
const FormatMapping kRequestMap[] = {
	{SRB_FMT_QR_CODE, BarcodeFormat::QRCodeModel1},
	{SRB_FMT_QR_CODE, BarcodeFormat::QRCodeModel2},
	{SRB_FMT_MICRO_QR_CODE, BarcodeFormat::MicroQRCode},
	{SRB_FMT_RMQR_CODE, BarcodeFormat::RMQRCode},
	{SRB_FMT_DATA_MATRIX, BarcodeFormat::DataMatrix},
	{SRB_FMT_AZTEC, BarcodeFormat::Aztec},
	{SRB_FMT_PDF417, BarcodeFormat::PDF417},
	{SRB_FMT_MAXICODE, BarcodeFormat::MaxiCode},
	{SRB_FMT_CODE_128, BarcodeFormat::Code128},
	{SRB_FMT_CODE_39, BarcodeFormat::Code39},
	{SRB_FMT_CODE_93, BarcodeFormat::Code93},
	{SRB_FMT_CODABAR, BarcodeFormat::Codabar},
	{SRB_FMT_EAN_8, BarcodeFormat::EAN8},
	{SRB_FMT_EAN_13, BarcodeFormat::EAN13},
	{SRB_FMT_EAN_13, BarcodeFormat::ISBN},
	{SRB_FMT_UPC_A, BarcodeFormat::UPCA},
	{SRB_FMT_UPC_E, BarcodeFormat::UPCE},
	{SRB_FMT_ITF, BarcodeFormat::ITF},
	{SRB_FMT_DATABAR, BarcodeFormat::DataBar},
};

uint32_t ToBit(BarcodeFormat format)
{
	// Specific variants first, then fall back to the base symbology.
	switch (format) {
	case BarcodeFormat::MicroQRCode: return SRB_FMT_MICRO_QR_CODE;
	case BarcodeFormat::RMQRCode: return SRB_FMT_RMQR_CODE;
	case BarcodeFormat::EAN8: return SRB_FMT_EAN_8;
	case BarcodeFormat::EAN13: return SRB_FMT_EAN_13;
	case BarcodeFormat::ISBN: return SRB_FMT_EAN_13;
	case BarcodeFormat::UPCA: return SRB_FMT_UPC_A;
	case BarcodeFormat::UPCE: return SRB_FMT_UPC_E;
	default: break;
	}
	switch (Symbology(format)) {
	case BarcodeFormat::QRCode: return SRB_FMT_QR_CODE;
	case BarcodeFormat::DataMatrix: return SRB_FMT_DATA_MATRIX;
	case BarcodeFormat::Aztec: return SRB_FMT_AZTEC;
	case BarcodeFormat::PDF417: return SRB_FMT_PDF417;
	case BarcodeFormat::MaxiCode: return SRB_FMT_MAXICODE;
	case BarcodeFormat::Code128: return SRB_FMT_CODE_128;
	case BarcodeFormat::Code39: return SRB_FMT_CODE_39;
	case BarcodeFormat::Code93: return SRB_FMT_CODE_93;
	case BarcodeFormat::Codabar: return SRB_FMT_CODABAR;
	case BarcodeFormat::ITF: return SRB_FMT_ITF;
	case BarcodeFormat::DataBar: return SRB_FMT_DATABAR;
	default: return 0;
	}
}

int32_t ToContentType(ContentType type)
{
	switch (type) {
	case ContentType::Text: return SRB_CONTENT_TEXT;
	case ContentType::Binary: return SRB_CONTENT_BINARY;
	case ContentType::Mixed: return SRB_CONTENT_MIXED;
	case ContentType::GS1: return SRB_CONTENT_GS1;
	case ContentType::ISO15434: return SRB_CONTENT_ISO15434;
	case ContentType::UnknownECI: return SRB_CONTENT_UNKNOWN_ECI;
	}
	return SRB_CONTENT_BINARY;
}

SrbResult* NewResult(int32_t error)
{
	auto* result = static_cast<SrbResult*>(std::calloc(1, sizeof(SrbResult)));
	if (result)
		result->error = error;
	return result;
}

// A static result used only when even the result struct cannot be allocated.
SrbResult gOutOfMemory = {SRB_ERR_OUT_OF_MEMORY, 0, nullptr};

SrbResult* Fail(int32_t error)
{
	SrbResult* result = NewResult(error);
	return result ? result : &gOutOfMemory;
}

// zxing-cpp 3.x reports UPC-A and UPC-E in their 13-digit EAN-13 form (ISO/IEC 15420).
// The app (and its saved history) has always used the short UPC forms, so map
// them back here: UPC-E -> original 8 digits, UPC-A (EAN-13 with a leading 0) ->
// 12 digits. Returns true when the text was changed.
bool NormalizeUpc(const Barcode& barcode, uint32_t formatMask, uint32_t& bit, std::string& text)
{
	if (bit == SRB_FMT_UPC_E) {
		const std::string upce = barcode.extra(BarcodeExtra::UPCE);
		if (!upce.empty()) {
			text = upce;
			return true;
		}
		return false;
	}
	if (bit == SRB_FMT_EAN_13 && (formatMask & SRB_FMT_UPC_A) && barcode.format() == BarcodeFormat::EAN13
		&& text.size() == 13 && text.front() == '0') {
		bit = SRB_FMT_UPC_A;
		text.erase(0, 1);
		return true;
	}
	return false;
}

bool CopyCode(const Barcode& barcode, uint32_t formatMask, uint32_t bit, SrbCode& out)
{
	std::memset(&out, 0, sizeof(SrbCode));
	out.content_type = ToContentType(barcode.contentType());

	std::string text = barcode.text();
	const bool normalized = NormalizeUpc(barcode, formatMask, bit, text);
	out.format = bit;
	out.text = static_cast<char*>(std::malloc(text.size() + 1));
	if (!out.text)
		return false;
	std::memcpy(out.text, text.data(), text.size());
	out.text[text.size()] = '\0';
	out.text_length = static_cast<int32_t>(text.size());

	const auto& bytes = normalized ? std::vector<uint8_t>(text.begin(), text.end()) : barcode.bytes();
	if (!bytes.empty()) {
		out.bytes = static_cast<uint8_t*>(std::malloc(bytes.size()));
		if (!out.bytes)
			return false;
		std::memcpy(out.bytes, bytes.data(), bytes.size());
		out.bytes_length = static_cast<int32_t>(bytes.size());
	}

	const auto& position = barcode.position();
	for (int i = 0; i < 4; ++i) {
		out.corners[i * 2] = position[i].x;
		out.corners[i * 2 + 1] = position[i].y;
	}
	out.orientation = barcode.orientation();
	out.flags = (barcode.isMirrored() ? SRB_FLAG_MIRRORED : 0u) | (barcode.isInverted() ? SRB_FLAG_INVERTED : 0u)
				| (barcode.hasECI() ? SRB_FLAG_HAS_ECI : 0u);
	out.sequence_index = barcode.sequenceIndex();
	out.sequence_size = barcode.sequenceSize();
	return true;
}

void FreeCodes(SrbCode* codes, int32_t count)
{
	if (!codes)
		return;
	for (int32_t i = 0; i < count; ++i) {
		std::free(codes[i].text);
		std::free(codes[i].bytes);
	}
	std::free(codes);
}

} // namespace

extern "C" SRB_API SrbResult* srb_read(const uint8_t* data, int32_t data_length, int32_t width, int32_t height, int32_t row_stride,
									   int32_t image_format, int32_t rotation_degrees, uint32_t format_mask, uint32_t options,
									   int32_t max_symbols)
{
	SrbResult* result = nullptr;
	try {
		if (!data || width <= 0 || height <= 0 || width > kMaxDimension || height > kMaxDimension || format_mask == 0)
			return Fail(SRB_ERR_BAD_ARGUMENT);

		ImageFormat format;
		int32_t pixelSize;
		switch (image_format) {
		case SRB_IMG_LUM: format = ImageFormat::Lum, pixelSize = 1; break;
		case SRB_IMG_RGBA: format = ImageFormat::RGBA, pixelSize = 4; break;
		case SRB_IMG_BGRA: format = ImageFormat::BGRA, pixelSize = 4; break;
		default: return Fail(SRB_ERR_BAD_ARGUMENT);
		}
		if (row_stride <= 0)
			row_stride = width * pixelSize;
		if (row_stride < width * pixelSize)
			return Fail(SRB_ERR_BAD_ARGUMENT);
		// The last row may be shorter than row_stride (common for camera planes).
		const int64_t needed = int64_t(height - 1) * row_stride + int64_t(width) * pixelSize;
		if (data_length < 0 || int64_t(data_length) < needed)
			return Fail(SRB_ERR_BAD_ARGUMENT);
		if (rotation_degrees != 0 && rotation_degrees != 90 && rotation_degrees != 180 && rotation_degrees != 270)
			return Fail(SRB_ERR_BAD_ARGUMENT);

		std::vector<BarcodeFormat> requested;
		for (const auto& entry : kRequestMap)
			if (format_mask & entry.bit)
				requested.push_back(entry.format);
		if (requested.empty())
			return Fail(SRB_ERR_BAD_ARGUMENT);

		if (max_symbols <= 0 || max_symbols > kMaxSymbols)
			max_symbols = kMaxSymbols;

		ReaderOptions readerOptions;
		readerOptions.setFormats(BarcodeFormats(std::move(requested)));
		readerOptions.setTryHarder(options & SRB_OPT_TRY_HARDER);
		readerOptions.setTryRotate(options & SRB_OPT_TRY_ROTATE);
		readerOptions.setTryInvert(options & SRB_OPT_TRY_INVERT);
		readerOptions.setTryDownscale(options & SRB_OPT_TRY_DOWNSCALE);
		readerOptions.setIsPure(options & SRB_OPT_IS_PURE);
		readerOptions.setMaxNumberOfSymbols(static_cast<uint8_t>(max_symbols));
		readerOptions.setTextMode(TextMode::Plain);
		readerOptions.setReturnErrors(false);

		const ImageView image = ImageView(data, width, height, format, row_stride, pixelSize).rotated(rotation_degrees);
		const Barcodes barcodes = ReadBarcodes(image, readerOptions);

		result = NewResult(SRB_OK);
		if (!result)
			return &gOutOfMemory;
		if (barcodes.empty())
			return result;

		result->codes = static_cast<SrbCode*>(std::calloc(barcodes.size(), sizeof(SrbCode)));
		if (!result->codes) {
			result->error = SRB_ERR_OUT_OF_MEMORY;
			return result;
		}
		for (const auto& barcode : barcodes) {
			if (!barcode.isValid())
				continue;
			const uint32_t bit = ToBit(barcode.format());
			if (!(bit & format_mask))
				continue;
			SrbCode& code = result->codes[result->count];
			if (!CopyCode(barcode, format_mask, bit, code)) {
				std::free(code.text);
				std::free(code.bytes);
				FreeCodes(result->codes, result->count);
				result->codes = nullptr;
				result->count = 0;
				result->error = SRB_ERR_OUT_OF_MEMORY;
				return result;
			}
			++result->count;
		}
		return result;
	} catch (const std::bad_alloc&) {
		srb_free(result);
		return Fail(SRB_ERR_OUT_OF_MEMORY);
	} catch (...) {
		srb_free(result);
		return Fail(SRB_ERR_INTERNAL);
	}
}

extern "C" SRB_API void srb_free(SrbResult* result)
{
	if (!result || result == &gOutOfMemory)
		return;
	FreeCodes(result->codes, result->count);
	std::free(result);
}

extern "C" SRB_API const char* srb_version(void)
{
	return kVersion;
}
