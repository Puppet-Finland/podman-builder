#!/bin/sh
#
# Package kafka-ic
cd "${BASEDIR}"

tar -zxf kafka-ic.tar.gz
cd "${BUILD_DIR}"

TARGET_DIR="${OUTPUT}/kafka-ic/usr/local/kafka-ic"
mkdir -p "${TARGET_DIR}"
cp -r * "${TARGET_DIR}/"
test -d "${TARGET_DIR}/.git" && rm -rf "${TARGET_DIR}/.git"

cd "${OUTPUT}/kafka-ic"

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" -s dir .
