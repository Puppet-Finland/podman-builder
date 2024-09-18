#!/bin/sh
#
FPM_TARGET_DIR="${OUTPUT}/cloudwatch_exporter/target"
BIN_DIR="${FPM_TARGET_DIR}/opt/cloudwatch_exporter"
UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

# Clean up traces of the old build
rm -rf "${FPM_TARGET_DIR}"
mkdir -p "${BIN_DIR}"
mkdir -p "${UNIT_DIR}"

# Build cloudwatch-exporter
cd $BASEDIR

git clone --branch $REF https://github.com/prometheus/cloudwatch_exporter.git
cd cloudwatch_exporter

mvn package

cp "${BASEDIR}/cloudwatch-exporter.service" "${UNIT_DIR}/"
cp "${BASEDIR}/cloudwatch_exporter/target/cloudwatch_exporter-${FPM_VERSION}-jar-with-dependencies.jar" "${BIN_DIR}/cloudwatch_exporter-${FPM_VERSION}.jar"

"${BASEDIR}/package.sh"

cp -v $FPM_TARGET_DIR/*.deb $FPM_TARGET_DIR/*.rpm $OUTPUT/cloudwatch_exporter 2> /dev/null
