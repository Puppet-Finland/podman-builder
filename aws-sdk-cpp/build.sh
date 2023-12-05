#!/bin/sh
#
# Build cppcms
cd $BASEDIR

git clone --recurse-submodules --branch $REF https://github.com/aws/aws-sdk-cpp.git 
cd aws-sdk-cpp

cmake . -DBUILD_ONLY="core;email;s3" -DCMAKE_INSTALL_PREFIX=/home/ubuntu/output/ubuntu-23.10/aws-sdk-cpp/usr/local -DENABLE_TESTING=OFF
make
make install

cd $OUTPUT/aws-sdk-cpp

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${REF}" --iteration "${FPM_ITERATION}" -s dir .
