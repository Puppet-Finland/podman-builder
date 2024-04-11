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

"${BASEDIR}/package.sh"
