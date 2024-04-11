#!/bin/sh

# Create prometheus user and group
getent group prometheus > /dev/null 2>&1 || groupadd prometheus -r
id -u prometheus > /dev/null 2>&1 || useradd prometheus -g prometheus -r -s /usr/sbin/nologin -b /home

mkdir -p /var/lib/prometheus
chown prometheus:prometheus /var/lib/prometheus/

systemctl daemon-reload


