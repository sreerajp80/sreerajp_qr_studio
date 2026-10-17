#!/usr/bin/env bash
# Build a hardened prod release APK/AAB with the current date injected as BUILD_DATE.
# Every release uses --obfuscate and --split-debug-info (guideline.md §2.4,
# engineering standard §15.1). Symbols go to build/symbols/android-prod-<version>/
# (engineering standard §19.3) — archive that folder with the release.
# Usage:
#   ./tool/build_release.sh apk
#   ./tool/build_release.sh appbundle

set -euo pipefail

BUILD_DATE=$(date +%Y-%m-%d)
TARGET=${1:-apk}
VERSION=$(grep -E '^version:' pubspec.yaml | awk '{print $2}')
SYMBOLS_DIR="build/symbols/android-prod-${VERSION}/"

EXTRA_ARGS=()
if [ "$TARGET" = "apk" ]; then
  # No universal release APK (engineering standard §5.6).
  EXTRA_ARGS+=(--split-per-abi)
fi

echo "Building prod $TARGET $VERSION with BUILD_DATE=$BUILD_DATE"
flutter build "$TARGET" --flavor prod --release \
  --obfuscate --split-debug-info="$SYMBOLS_DIR" \
  --dart-define=BUILD_DATE="$BUILD_DATE" \
  ${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}

echo "Debug symbols written to $SYMBOLS_DIR — archive them securely with this release."
