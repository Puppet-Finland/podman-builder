#!/bin/sh
#
FPM_TARGET_DIR="${OUTPUT}/updates-exporter/target"

cd $FPM_TARGET_DIR

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" --after-install "${BASEDIR}/after-install.sh" --after-upgrade "${BASEDIR}/after-upgrade.sh" -s dir .

mv *.deb ..
