// SreerajP QR Studio — native barcode bridge.
//
// A tiny, stable C interface over the vendored zxing-cpp reader, designed for
// dart:ffi. All memory returned by srb_read() is owned by the caller and must be
// released with srb_free(). No function in this file ever throws or aborts:
// every failure is reported through SrbResult.error.

#ifndef SREERAJ_BARCODE_H
#define SREERAJ_BARCODE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#if defined(_WIN32)
#define SRB_API __declspec(dllexport)
#else
#define SRB_API __attribute__((visibility("default"))) __attribute__((used))
#endif

// Format bits. Keep in sync with CodeFormat in lib/models/code_format.dart.
enum {
	SRB_FMT_QR_CODE = 1u << 0,
	SRB_FMT_MICRO_QR_CODE = 1u << 1,
	SRB_FMT_RMQR_CODE = 1u << 2,
	SRB_FMT_DATA_MATRIX = 1u << 3,
	SRB_FMT_AZTEC = 1u << 4,
	SRB_FMT_PDF417 = 1u << 5,
	SRB_FMT_MAXICODE = 1u << 6,
	SRB_FMT_CODE_128 = 1u << 7,
	SRB_FMT_CODE_39 = 1u << 8,
	SRB_FMT_CODE_93 = 1u << 9,
	SRB_FMT_CODABAR = 1u << 10,
	SRB_FMT_EAN_8 = 1u << 11,
	SRB_FMT_EAN_13 = 1u << 12,
	SRB_FMT_UPC_A = 1u << 13,
	SRB_FMT_UPC_E = 1u << 14,
	SRB_FMT_ITF = 1u << 15,
	SRB_FMT_DATABAR = 1u << 16,
};

// Image pixel layouts accepted by srb_read().
enum {
	SRB_IMG_LUM = 0,  // 1 byte per pixel (e.g. the Y plane of a YUV camera frame)
	SRB_IMG_RGBA = 1, // 4 bytes per pixel
	SRB_IMG_BGRA = 2, // 4 bytes per pixel
};

// Reader option bits.
enum {
	SRB_OPT_TRY_HARDER = 1u << 0,
	SRB_OPT_TRY_ROTATE = 1u << 1,
	SRB_OPT_TRY_INVERT = 1u << 2,
	SRB_OPT_TRY_DOWNSCALE = 1u << 3,
	SRB_OPT_IS_PURE = 1u << 4,
};

// Content type as reported by the decoder (not the semantic payload type).
enum {
	SRB_CONTENT_TEXT = 0,
	SRB_CONTENT_BINARY = 1,
	SRB_CONTENT_MIXED = 2,
	SRB_CONTENT_GS1 = 3,
	SRB_CONTENT_ISO15434 = 4,
	SRB_CONTENT_UNKNOWN_ECI = 5,
};

// Result flag bits.
enum {
	SRB_FLAG_MIRRORED = 1u << 0,
	SRB_FLAG_INVERTED = 1u << 1,
	SRB_FLAG_HAS_ECI = 1u << 2,
};

// Error codes.
enum {
	SRB_OK = 0,
	SRB_ERR_BAD_ARGUMENT = 1,
	SRB_ERR_OUT_OF_MEMORY = 2,
	SRB_ERR_INTERNAL = 3,
};

typedef struct SrbCode {
	uint32_t format;       // one SRB_FMT_* bit
	int32_t content_type;  // SRB_CONTENT_*
	int32_t text_length;   // bytes in text, without the trailing NUL
	char* text;            // UTF-8, NUL-terminated
	int32_t bytes_length;
	uint8_t* bytes;        // raw decoded bytes
	int32_t corners[8];    // x,y of top-left, top-right, bottom-right, bottom-left (upright image pixels)
	int32_t orientation;   // degrees
	uint32_t flags;        // SRB_FLAG_*
	int32_t sequence_index; // structured append, -1 when not used
	int32_t sequence_size;  // structured append, -1 when not used
} SrbCode;

typedef struct SrbResult {
	int32_t error; // SRB_OK or SRB_ERR_*
	int32_t count;
	SrbCode* codes;
} SrbResult;

// Decodes every barcode found in the image. Never returns NULL.
// data_length is the size of the buffer at data; it is checked against width, height and
// row_stride so a short buffer can never be over-read.
// rotation_degrees (0, 90, 180, 270, clockwise) turns the image upright before decoding
// without copying it; returned corners are in the rotated (upright) coordinate space.
SRB_API SrbResult* srb_read(const uint8_t* data, int32_t data_length, int32_t width, int32_t height, int32_t row_stride,
							int32_t image_format, int32_t rotation_degrees, uint32_t format_mask, uint32_t options,
							int32_t max_symbols);

// Releases a result returned by srb_read(). Accepts NULL.
SRB_API void srb_free(SrbResult* result);

// Version string of the bridge and the vendored decoder, e.g. "1.0.0/zxing-cpp 3.1.1".
SRB_API const char* srb_version(void);

#ifdef __cplusplus
}
#endif

#endif // SREERAJ_BARCODE_H
