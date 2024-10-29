#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/azure-metrics-exporter/target"
BIN_DIR="${FPM_TARGET_DIR}/usr/local/bin"
ETC_DIR="${FPM_TARGET_DIR}/etc/azure-metrics-exporter"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

cd $BASEDIR
git clone https://github.com/webdevops/azure-metrics-exporter.git
cd azure-metrics-exporter
git checkout $REF
make build

mkdir -p $OUTPUT

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $ETC_DIR
mkdir -p $BIN_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp -v ./azure-metrics-exporter $BIN_DIR/
cp -v "${BASEDIR}/azure_metrics_exporter.service" $SYSTEMD_UNIT_DIR/
cp -v "${BASEDIR}/azure-metrics-exporter.env" $ETC_DIR/

"${BASEDIR}/package.sh"
