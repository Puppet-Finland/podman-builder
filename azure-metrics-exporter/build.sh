#!/bin/sh
cd $BASEDIR
git clone https://github.com/webdevops/azure-metrics-exporter.git
cd azure-metrics-exporter
make build

mkdir -p $OUTPUT
cp ./azure-metrics-exporter $OUTPUT/
