#!/bin/sh
#
# Build cloudwatch-exporter
cd $BASEDIR

git clone --branch $REF $GIT_URL
cd date

g++ -std=c++14 -Wall  -fPIC -O2 -DUSE_OS_TZDB src/*.cpp -c -I include
g++ -std=c++14 -shared -o libdate.so *.o

FPM_TARGET_DIR="${OUTPUT}/date"
LIB_DIR="${FPM_TARGET_DIR}/usr/local/lib"
INCLUDE_DIR="${FPM_TARGET_DIR}/usr/local/include/date"

mkdir -p "${LIB_DIR}"
mkdir -p "${INCLUDE_DIR}"

cp libdate.so "${LIB_DIR}/"
cp include/date/* "${INCLUDE_DIR}/"

cd $FPM_TARGET_DIR

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
