#!/bin/sh
#
# Package jwt-cpp
cd $BASEDIR

git clone --branch $REF https://github.com/Thalhammer/jwt-cpp.git
cd jwt-cpp

TARGETDIR="${OUTPUT}/jwt-cpp/usr/local"

mkdir -p $TARGETDIR
cp -r include $TARGETDIR/

cd $OUTPUT/jwt-cpp

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
