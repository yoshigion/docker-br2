#!/bin/bash

set -e
set -x

# build
cd ${BUILD_DIR_BR2}/buildroot
make ${DEFCONFIG_BR2}
make
cp -p ${BUILD_DIR_BR2}/buildroot/output/images/sdcard.img ${IMAGE_DIR_BR2}
