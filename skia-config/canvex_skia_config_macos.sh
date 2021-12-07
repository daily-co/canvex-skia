# This is the build setup for the Skia static lib used in canvex.
# Follow the instructions at https://skia.org/docs/user/build/
# This script is specifically the "gn gen" step.
#
# NOTE: uses homebrew.
# To install dependencies:
#  brew install libpng giflib libjpeg-turbo webp icu4c
#  

set -e # exit on error

echo "This is the build setup for Skia on macOS. Only tested on ARM (M1)."
echo "You must execute this script in the skia checkout dir."
echo "See: https://skia.org/docs/user/build/"

bin/gn gen ../gn_out/Static --args='is_official_build=true skia_enable_pdf=false skia_enable_gpu=false skia_enable_svg=false skia_use_libwebp_decode=false skia_use_libwebp_encode=false skia_use_dng_sdk=false skia_use_system_icu=false skia_use_system_libpng=false skia_use_libjpeg_turbo=false extra_cflags_cc=["-I/opt/homebrew/include/harfbuzz", "-I/opt/homebrew/include"] extra_ldflags=["-L/opt/homebrew/lib"]'

# -- alternative version that uses libjpeg-turbo from homebrew:
# bin/gn gen ../gn_out/Static --args='is_official_build=true skia_enable_pdf=false skia_enable_gpu=false skia_enable_svg=false skia_use_libwebp_decode=false skia_use_libwebp_encode=false skia_use_dng_sdk=false skia_use_system_icu=false extra_cflags_cc=["-I/opt/homebrew/opt/jpeg-turbo/include", "-I/opt/homebrew/include/harfbuzz", "-I/opt/homebrew/include"] extra_ldflags=["-L/opt/homebrew/opt/jpeg-turbo/lib", "-L/opt/homebrew/lib"]'

echo "Your build is ready. Now run: "
echo "  ninja -C ../gn_out/Static"
echo
echo "When the build completes, copy the new libskia.a into canvex/skia/lib-static/mac-arm64"
