/// How hard the decoder should try on an image. Harder means slower.
enum DecodeProfile {
  /// Single QR code, no extra passes. For AirQR high frame-rate transfer.
  fast,

  /// Live camera frames: tries rotated 1D barcodes, one binarizer pass.
  live,

  /// Still images (gallery, PDF, share sheet): every extra pass enabled.
  thorough,
}
