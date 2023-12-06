#!/bin/sh
#
# Package websocketpp
cd $BASEDIR

git clone --branch $REF https://github.com/zaphoyd/websocketpp.git 
cd websocketpp

TARGETDIR="${OUTPUT}/websocketpp/usr/local/include"

mkdir -p $TARGETDIR
cp -r websocketpp $TARGETDIR/

cd $OUTPUT/websocketpp

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
