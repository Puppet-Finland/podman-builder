#!/bin/sh
#
FPM_TARGET_DIR="${OUTPUT}/cloudwatch_exporter/target"

cd $FPM_TARGET_DIR

fpm -t rpm --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" --after-install "${BASEDIR}/after-install.sh" -d "java-11-openjdk" -s dir .
