#!/bin/sh

# Create azure-metrics-exporter user and group
getent group azure-metrics-exporter > /dev/null 2>&1 || groupadd azure-metrics-exporter -r
id -u azure-metrics-exporter > /dev/null 2>&1 || useradd azure-metrics-exporter -g azure-metrics-exporter -r -s /usr/sbin/nologin -b /home

systemctl daemon-reload
