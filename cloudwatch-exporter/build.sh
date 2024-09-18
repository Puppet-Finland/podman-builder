#!/bin/sh
#
FPM_TARGET_DIR="${OUTPUT}/cloudwatch-exporter/target"
BIN_DIR="${FPM_TARGET_DIR}/usr/local/bin"
ETC_DIR="${FPM_TARGET_DIR}/etc/cloudwatch-exporter"
UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

# Clean up traces of the old build
rm -rf "${FPM_TARGET_DIR}"
mkdir -p "${BIN_DIR}"
mkdir -p "${ETC_DIR}"
mkdir -p "${UNIT_DIR}"

# Build cloudwatch-exporter
cd $BASEDIR

git clone --branch $REF https://github.com/prometheus/cloudwatch_exporter.git cloudwatch-exporter
cd cloudwatch-exporter

mvn package

cp "${BASEDIR}/cloudwatch-exporter.service" "${UNIT_DIR}/"
cp "${BASEDIR}/aws_profile" "${ETC_DIR}/"
cp "${BASEDIR}/config.yaml" "${ETC_DIR}/"
cp "${BASEDIR}/cloudwatch-exporter/target/cloudwatch_exporter-${FPM_VERSION}-jar-with-dependencies.jar" "${BIN_DIR}/cloudwatch-exporter.jar"

"${BASEDIR}/package.sh"

mv -v $FPM_TARGET_DIR/*.deb $FPM_TARGET_DIR/*.rpm $OUTPUT/cloudwatch-exporter/ 2> /dev/null
