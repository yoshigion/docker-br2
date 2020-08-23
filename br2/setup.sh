#!/bin/bash

set -e
set -x

# setup ccache
sudo chmod 777 /br2-ccache
ln -s /br2-ccache ~/.buildroot-ccache

# setup download
sudo chmod 777 /br2-dl
(cd ${BUILD_DIR_BR2}/buildroot && ln -s /br2-dl dl)

# git setting
git config --global user.email "docker@docker"
git config --global user.name "docker"
git config --global color.ui false

# apply patch of board defconfig
(cd ${BUILD_DIR_BR2}/buildroot && patch -p0 < ../config.patch)
