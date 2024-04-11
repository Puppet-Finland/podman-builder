#!/bin/sh

# Create node-exporter user and group
getent group node-exporter > /dev/null 2>&1 || groupadd node-exporter -r
id -u node-exporter > /dev/null 2>&1 || useradd node-exporter -g node-exporter -r -s /usr/sbin/nologin -b /home

systemctl daemon-reload


