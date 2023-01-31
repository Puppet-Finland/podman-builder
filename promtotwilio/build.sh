#!/bin/sh
cd $BASEDIR
git clone https://github.com/Swatto/promtotwilio.git
cd promtotwilio
go build

mkdir -p $OUTPUT
cp ./promtotwilio $OUTPUT/
