#!/bin/sh

# Create blackbox-exporter user and group
getent group blackbox-exporter > /dev/null 2>&1 || groupadd blackbox-exporter -r
id -u blackbox-exporter > /dev/null 2>&1 || useradd blackbox-exporter -g blackbox-exporter -r -s /usr/sbin/nologin -b /home

systemctl daemon-reload
