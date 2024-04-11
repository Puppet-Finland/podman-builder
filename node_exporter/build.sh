#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/node_exporter"
NODE_EXPORTER_INSTALL_DIR="${FPM_TARGET_DIR}/opt/node_exporter"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $NODE_EXPORTER_INSTALL_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp -v "${BASEDIR}/node_exporter.service" "${SYSTEMD_UNIT_DIR}/"
wget -q -O- "${DOWNLOAD_URL}/v${REF}/node_exporter-${REF}.linux-amd64.tar.gz"|tar -zx --strip-components=1 -C "${NODE_EXPORTER_INSTALL_DIR}"

"${BASEDIR}/package.sh"
