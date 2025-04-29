#!/bin/sh
#
# Package jwt-cpp
cd $BASEDIR

git clone $GIT_URL
cd jwt-cpp
git checkout $REF
patch -p1 < /home/ubuntu/picojson.patch
TARGETDIR="${OUTPUT}/jwt-cpp/usr/local"

mkdir -p $TARGETDIR
cp -r include $TARGETDIR/

cd $OUTPUT/jwt-cpp

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
