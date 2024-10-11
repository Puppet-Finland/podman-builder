#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/azure-metrics-exporter"
BIN_DIR="${FPM_TARGET_DIR}/usr/local/bin"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

cd $BASEDIR
git clone https://github.com/webdevops/azure-metrics-exporter.git
cd azure-metrics-exporter
git checkout $REF
make build

mkdir -p $OUTPUT

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $BIN_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp ./azure-metrics-exporter $BIN_DIR/
#cp -v "${BASEDIR}/prometheus.service" "${SYSTEMD_UNIT_DIR}/"
#cp -v "${BASEDIR}/prometheus.yaml" "${PROMETHEUS_CONFIG_DIR}/"
#wget -q -O- "${DOWNLOAD_URL}/v${REF}/prometheus-${REF}.linux-amd64.tar.gz"|tar -zx --strip-components=1 -C "${PROMETHEUS_INSTALL_DIR}"

"${BASEDIR}/package.sh"
