#!/bin/sh
FPM_TARGET_DIR="${OUTPUT}/alertmanager"
ALERTMANAGER_INSTALL_DIR="${FPM_TARGET_DIR}/opt/alertmanager"
ALERTMANAGER_CONFIG_DIR="${FPM_TARGET_DIR}/etc/alertmanager"
SYSTEMD_UNIT_DIR="${FPM_TARGET_DIR}/etc/systemd/system"

rm -rf $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR
mkdir -p $ALERTMANAGER_INSTALL_DIR
mkdir -p $ALERTMANAGER_CONFIG_DIR
mkdir -p $SYSTEMD_UNIT_DIR

cp -v "${BASEDIR}/alertmanager.service" "${SYSTEMD_UNIT_DIR}/"
cp -v "${BASEDIR}/alertmanager.yaml" "${ALERTMANAGER_CONFIG_DIR}/"
wget -q -O- "${DOWNLOAD_URL}/v${REF}/alertmanager-${REF}.linux-amd64.tar.gz"|tar -zx --strip-components=1 -C "${ALERTMANAGER_INSTALL_DIR}"
"${BASEDIR}/package.sh"
