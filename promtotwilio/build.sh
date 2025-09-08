#!/bin/sh
cd $BASEDIR
git clone $GIT_URL
cd promtotwilio
git checkout $GIT_REF
go build

FPM_TARGET_DIR="${OUTPUT}/promtotwilio/target"
rm -rf "$FPM_TARGET_DIR"
mkdir -p $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR/usr/local/bin
mkdir -p $FPM_TARGET_DIR/etc/systemd/system

cp -v promtotwilio $FPM_TARGET_DIR/usr/local/bin/
cp -v $BASEDIR/promtotwilio.conf $FPM_TARGET_DIR/etc/
cp -v $BASEDIR/promtotwilio.service $FPM_TARGET_DIR/etc/systemd/system/

"${BASEDIR}/package.sh"
