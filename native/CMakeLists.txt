# SreerajP QR Studio — native barcode decoder.
#
# Builds libsreeraj_barcode.so: our C bridge (sreeraj_barcode/) statically linked
# with the vendored zxing-cpp reader (zxing-cpp/, readers only, no writers).
# Called from Dart through dart:ffi (lib/services/barcode_decoder/).

cmake_minimum_required(VERSION 3.18)
project(sreeraj_barcode LANGUAGES C CXX)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# zxing-cpp options: decoders only, static, no C API, no precompiled headers.
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(ZXING_READERS ON CACHE BOOL "" FORCE)
set(ZXING_WRITERS OFF CACHE STRING "" FORCE)
set(ZXING_C_API OFF CACHE BOOL "" FORCE)
set(ZXING_DISABLE_PCH ON CACHE BOOL "" FORCE)

add_subdirectory(zxing-cpp/core zxing EXCLUDE_FROM_ALL)

add_library(sreeraj_barcode SHARED sreeraj_barcode/sreeraj_barcode.cpp)
target_link_libraries(sreeraj_barcode PRIVATE ZXing::ZXing)

# Always optimise the decoder for speed, even in debug app builds: it runs on
# every camera frame.
target_compile_options(sreeraj_barcode PRIVATE -O3 -fvisibility=hidden -ffunction-sections -fdata-sections)
target_compile_options(ZXing PRIVATE -O3 -ffunction-sections -fdata-sections)
target_link_options(sreeraj_barcode PRIVATE
    -Wl,--gc-sections
    -Wl,--exclude-libs,ALL
    # Android 15+ 16 KB page size support.
    -Wl,-z,max-page-size=16384
)
