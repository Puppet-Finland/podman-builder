#!/bin/sh
#
FPM_TARGET_DIR="${OUTPUT}/cloudwatch-exporter/target"

cd $FPM_TARGET_DIR

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" --after-install "${BASEDIR}/after-install.sh" --before-remove "${BASEDIR}/before-remove.sh" --after-remove "${BASEDIR}/after-remove.sh" --after-upgrade "${BASEDIR}/after-upgrade.sh" -d "openjdk-21-jre" --config-files etc/cloudwatch-exporter -s dir .
