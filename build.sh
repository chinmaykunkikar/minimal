#!/bin/bash
# ccache
export USE_CCACHE=1
export CCACHE_NLEVELS=4
export CCACHE_DIR=/home/darkfalcon/ccache/minos
# Build
. build/envsetup.sh
export KBUILD_BUILD_USER=darkfalcon
export KBUILD_BUILD_HOST=omen
lunch minimal_pepper-userdebug
export USE_PREBUILT_CHROMIUM=1
make clean && make clobber
#export CHANGELOG=true
make -j8
