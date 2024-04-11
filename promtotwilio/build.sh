#!/bin/sh
cd $BASEDIR
git clone -b multiple_receivers $GIT_URL
cd promtotwilio
go build

FPM_TARGET_DIR="${OUTPUT}/promtotwilio"
mkdir -p $FPM_TARGET_DIR
mkdir -p $FPM_TARGET_DIR/usr/bin

cp -v promtotwilio $FPM_TARGET_DIR/usr/bin

"${BASEDIR}/package.sh"
