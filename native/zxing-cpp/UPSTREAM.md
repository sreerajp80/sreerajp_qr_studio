# Vendored zxing-cpp

This folder holds a copy of the **reader (decoder) part** of zxing-cpp. It is built
into the app's own native library by `native/CMakeLists.txt`. It is not downloaded at
build time.

| Field | Value |
| --- | --- |
| Upstream | https://github.com/zxing-cpp/zxing-cpp |
| Tag | `v3.1.1` |
| Commit | `287c85df6f961c8efbfb5ffd736cd9457b8b890e` |
| Copied on | 2026-09-28 |
| Licence | Apache-2.0 (`LICENSE`). `core/src/libzueci/` is BSD-3-Clause (see the file headers). |

## What was copied

- `LICENSE`, `README.md`
- `core/` (CMake files and `src/`)

## What was left out

Only code that is never compiled when `ZXING_WRITERS=OFF`:

- `core/src/libzint/` and the top-level `zint/` (barcode writer, BSD-3-Clause)
- `core/src/TextEncoder.*`, `core/src/MultiFormatWriter.cpp` (the header is kept because
  `CreateBarcode.cpp` includes it)
- Old writer files: `aztec/AZEncoder*`, `AZEncodingState.h`, `AZHighLevelEncoder*`, `AZToken*`,
  `AZWriter*`; `datamatrix/DMECEncoder*`, `DMEncoderContext.h`, `DMHighLevelEncoder*`,
  `DMSymbolInfo*`, `DMSymbolShape.h`, `DMWriter*`; `oned/OD*Writer*`, `ODWriterHelper*`;
  `pdf417/PDFCompaction.h`, `PDFEncoder*`, `PDFHighLevelEncoder*`, `PDFWriter*`;
  `qrcode/QREncoder*`, `QREncodeResult.h`, `QRMaskUtil*`, `QRMatrixUtil*`, `QRWriter*`
- `test/`, `example/`, `wrappers/`, `docs/`, CI files

## Local changes

None. No upstream file has been edited. All of our own code lives in
`native/sreeraj_barcode/` and `lib/services/barcode_decoder/`.

If an upstream file ever must be patched, add a line at the top of that file:
`// Modified by SreerajP QR Reader: <reason>` and list it here.

## How to update

1. Check the upstream release notes, especially for security fixes.
2. Replace `core/` with the new tag's `core/`, then remove the files listed above.
3. Update the tag, commit and date in this file and `kVersion` in
   `native/sreeraj_barcode/sreeraj_barcode.cpp`.
4. Run the on-device decoder tests (`integration_test/barcode_decoder_test.dart`).
