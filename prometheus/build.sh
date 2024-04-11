#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/prometheus"
PROMETHEUS_INSTALL_DIR="${FPM_TARGET_DIR}/opt/prometheus"
PROMETHEUS_CONFIG_DIR="${FPM_TARGET_DIR}/etc/prometheus"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $PROMETHEUS_INSTALL_DIR
mkdir -p $PROMETHEUS_CONFIG_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp -v "${BASEDIR}/prometheus.service" "${SYSTEMD_UNIT_DIR}/"
cp -v "${BASEDIR}/prometheus.yaml" "${PROMETHEUS_CONFIG_DIR}/"
wget -q -O- "${DOWNLOAD_URL}/v${REF}/prometheus-${REF}.linux-amd64.tar.gz"|tar -zx --strip-components=1 -C "${PROMETHEUS_INSTALL_DIR}"

"${BASEDIR}/package.sh"
