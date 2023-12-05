#!/bin/sh
#
# Build cppcms
cd $BASEDIR

git clone --branch $REF https://github.com/artyom-beilis/cppcms.git
cd cppcms

cmake . -DCMAKE_INSTALL_PREFIX=$OUTPUT/cppcms/usr/local
make
make install

cd $OUTPUT/cppcms

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
