import 'dart:ffi';
import 'dart:io';

/// Hand-written dart:ffi bindings for `native/sreeraj_barcode/sreeraj_barcode.h`.
///
/// Keep the struct layouts and constants in step with that header.

/// Pixel layouts accepted by `srb_read` (`SRB_IMG_*`).
abstract final class SrbImageFormat {
  static const int lum = 0;
  static const int rgba = 1;
  static const int bgra = 2;
}

/// Reader option bits (`SRB_OPT_*`).
abstract final class SrbOption {
  static const int tryHarder = 1 << 0;
  static const int tryRotate = 1 << 1;
  static const int tryInvert = 1 << 2;
  static const int tryDownscale = 1 << 3;
  static const int isPure = 1 << 4;
}

/// Error codes (`SRB_ERR_*`).
abstract final class SrbError {
  static const int ok = 0;
  static const int badArgument = 1;
  static const int outOfMemory = 2;
  static const int internal = 3;
}

final class SrbCode extends Struct {
  @Uint32()
  external int format;

  @Int32()
  external int contentType;

  @Int32()
  external int textLength;

  external Pointer<Uint8> text;

  @Int32()
  external int bytesLength;

  external Pointer<Uint8> bytes;

  @Array(8)
  external Array<Int32> corners;

  @Int32()
  external int orientation;

  @Uint32()
  external int flags;

  @Int32()
  external int sequenceIndex;

  @Int32()
  external int sequenceSize;
}

final class SrbResult extends Struct {
  @Int32()
  external int error;

  @Int32()
  external int count;

  external Pointer<SrbCode> codes;
}

typedef _SrbReadNative = Pointer<SrbResult> Function(
  Pointer<Uint8> data,
  Int32 dataLength,
  Int32 width,
  Int32 height,
  Int32 rowStride,
  Int32 imageFormat,
  Int32 rotationDegrees,
  Uint32 formatMask,
  Uint32 options,
  Int32 maxSymbols,
);
typedef SrbReadDart = Pointer<SrbResult> Function(
  Pointer<Uint8> data,
  int dataLength,
  int width,
  int height,
  int rowStride,
  int imageFormat,
  int rotationDegrees,
  int formatMask,
  int options,
  int maxSymbols,
);

typedef _SrbFreeNative = Void Function(Pointer<SrbResult> result);
typedef SrbFreeDart = void Function(Pointer<SrbResult> result);

typedef _SrbVersionNative = Pointer<Uint8> Function();
typedef SrbVersionDart = Pointer<Uint8> Function();

/// Loaded native entry points.
class BarcodeFfiBindings {
  final SrbReadDart read;
  final SrbFreeDart free;
  final SrbVersionDart version;

  BarcodeFfiBindings._(DynamicLibrary library)
    : read = library.lookupFunction<_SrbReadNative, SrbReadDart>('srb_read'),
      free = library.lookupFunction<_SrbFreeNative, SrbFreeDart>('srb_free'),
      version = library.lookupFunction<_SrbVersionNative, SrbVersionDart>(
        'srb_version',
      );

  /// Name of the shared library built by `native/CMakeLists.txt`.
  static const String libraryName = 'libsreeraj_barcode.so';

  /// Opens the native library. Throws if it is not available on this
  /// platform (for example in host unit tests).
  factory BarcodeFfiBindings.open() {
    if (!Platform.isAndroid) {
      throw UnsupportedError('Native barcode decoder is Android-only.');
    }
    return BarcodeFfiBindings._(DynamicLibrary.open(libraryName));
  }
}
