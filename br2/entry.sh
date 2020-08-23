#!/bin/bash

set -e
set -x

# setup
${WORKING_DIR_BR2}/setup.sh 2>&1 | tee ${LOG_DIR_BR2}/log-setup.txt

# build
${WORKING_DIR_BR2}/build.sh 2>&1 | tee ${LOG_DIR_BR2}/log-build.txt

# exec bash
bash
