#!/bin/sh
cd $BASEDIR
git clone -b multiple_receivers https://github.com/Puppet-Finland/promtotwilio.git
cd promtotwilio
go build

mkdir -p $OUTPUT
cp ./promtotwilio $OUTPUT/
sleep 120
