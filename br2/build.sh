#!/bin/bash

set -e
set -x

# build
echo "***** build start *****"
cd ${BUILD_DIR}/buildroot
make raspberrypi3_64_defconfig
make
echo "***** build end *****"
