#!/bin/sh
cd $BASEDIR
git clone $GIT_URL
cd updates-exporter
git checkout $GIT_REF
go build

FPM_TARGET_DIR="${OUTPUT}/updates-exporter/target"
rm -rf "$FPM_TARGET_DIR"
mkdir -p $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR/usr/local/bin
mkdir -p $FPM_TARGET_DIR/etc/systemd/system

cp -v updates-exporter $FPM_TARGET_DIR/usr/local/bin/
cp -v $BASEDIR/updates-exporter.service $FPM_TARGET_DIR/etc/systemd/system/

"${BASEDIR}/package.sh"
