#!/bin/sh
#
# Build cloudwatch-exporter
cd $BASEDIR

git clone --branch $REF https://github.com/prometheus/cloudwatch_exporter.git
cd cloudwatch_exporter

mvn package

FPM_TARGET_DIR="${OUTPUT}/cloudwatch_exporter"
BIN_DIR="${FPM_TARGET_DIR}/opt/cloudwatch_exporter"
UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

mkdir -p "${BIN_DIR}"
mkdir -p "${UNIT_DIR}"

cp "${BASEDIR}/cloudwatch-exporter.service" "${UNIT_DIR}/"
cp "${BASEDIR}/cloudwatch_exporter/target/cloudwatch_exporter-${FPM_VERSION}-jar-with-dependencies.jar" "${BIN_DIR}/cloudwatch_exporter-${FPM_VERSION}.jar"

cd $FPM_TARGET_DIR

fpm -t deb --force --name "${FPM_NAME}" --description "${FPM_DESCRIPTION}" --license "${FPM_LICENSE}" --vendor "${FPM_VENDOR}" --maintainer "${FPM_MAINTAINER}" --url "${FPM_URL}" --version "${FPM_VERSION}" --iteration "${FPM_ITERATION}" --after-install "${BASEDIR}/after-install.sh" -d "default-jre" -s dir .
