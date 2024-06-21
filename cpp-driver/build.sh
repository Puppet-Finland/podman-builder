#!/bin/sh
#
# Build cpp-driver
cd $BASEDIR

git clone --branch $REF $GIT_URL
cd cpp-driver
cmake . -DCMAKE_INSTALL_PREFIX=$OUTPUT/cpp-driver/usr/local
make
make install

cd $OUTPUT/cpp-driver

fpm \
  -t deb \
  --force \
  --name "${FPM_NAME}" \
  --description "${FPM_DESCRIPTION}" \
  --license "${FPM_LICENSE}" \
  --vendor "${FPM_VENDOR}" \
  --maintainer "${FPM_MAINTAINER}" \
  --url "${FPM_URL}" \
  --version "${FPM_VERSION}" \
  --iteration "${FPM_ITERATION}" \
  -d 'libkrb5-3 >= 1.20.0' \
  -d 'libssl3 >= 3.0.0 '\
  -d 'libuv1t64 >= 1.48.0' \
  -d 'zlib1g >= 1.0' \
  -s dir .
