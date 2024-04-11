#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/blackbox_exporter"
BLACKBOX_EXPORTER_INSTALL_DIR="${FPM_TARGET_DIR}/opt/blackbox_exporter"
BLACKBOX_EXPORTER_CONFIG_DIR="${FPM_TARGET_DIR}/etc/blackbox_exporter"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $BLACKBOX_EXPORTER_INSTALL_DIR
mkdir -p $BLACKBOX_EXPORTER_CONFIG_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp -v "${BASEDIR}/blackbox_exporter.service" "${SYSTEMD_UNIT_DIR}/"
cp -v "${BASEDIR}/blackbox-exporter.yaml" "${BLACKBOX_EXPORTER_CONFIG_DIR}/"
wget -q -O- "${DOWNLOAD_URL}/v${REF}/blackbox_exporter-${REF}.linux-amd64.tar.gz"|tar -zx --strip-components=1 -C "${BLACKBOX_EXPORTER_INSTALL_DIR}"

"${BASEDIR}/package.sh"
