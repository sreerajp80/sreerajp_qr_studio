# R8 / ProGuard rules for SreerajP QR Studio release builds
# (docs/release_process.md §6.2, docs/security.md §8.2).
#
# R8 full mode is on by default (AGP 9). Flutter's Gradle plugin adds the rules
# for the Flutter engine, and every plugin used here (camera, local_auth,
# flutter_secure_storage, sqflite, permission_handler, ...) ships its own
# consumer rules inside its AAR, so they are not repeated here.
#
# Barcode decoding goes through dart:ffi into libsreeraj_barcode.so. FFI does
# not use JNI or Java reflection, so no keep rules are needed for it.
#
# After adding a dependency, test the release build end to end: R8 problems
# show up only in release builds (ClassNotFoundException, NoSuchMethodException).

# This app's own Android components. Android creates them by name from the
# manifest (activities, services, tile services, boot receiver); aapt already
# keeps them, and this rule makes that explicit so a rename in the manifest and
# the code cannot be broken by shrinking.
-keep class in.sreerajp.qr_studio.** extends android.app.Activity { <init>(); }
-keep class in.sreerajp.qr_studio.** extends android.app.Service { <init>(); }
-keep class in.sreerajp.qr_studio.** extends android.content.BroadcastReceiver { <init>(); }
