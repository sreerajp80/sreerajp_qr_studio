/// How hard the decoder should try on an image. Harder means slower.
enum DecodeProfile {
  /// Quick pass, no extra passes. For AirQR high frame-rate transfer, and for
  /// most frames of a live camera scan.
  fast,

  /// Live camera frames: tries rotated 1D barcodes, one binarizer pass. The
  /// camera uses it on every few frames, with [fast] on the frames between.
  live,

  /// Still images (gallery, PDF, share sheet): every extra pass enabled.
  thorough,
}
