#!/bin/sh

# Create updates-exporter user and group
getent group updates-exporter > /dev/null 2>&1 || groupadd updates-exporter -r
id -u updates-exporter > /dev/null 2>&1 || useradd updates-exporter -g updates-exporter -r -s /usr/sbin/nologin -b /home

systemctl daemon-reload
