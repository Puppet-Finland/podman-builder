#!/bin/sh

# Ubuntu 20.04 (64-bit)
podman container rm azure-metrics-exporter-build-ubuntu-20.04; podman build azure-metrics-exporter/ -t azure-metrics-exporter-build && podman run --name azure-metrics-exporter-build-ubuntu-20.04 -v podman-builds:/home/ubuntu/output azure-metrics-exporter-build:latest
