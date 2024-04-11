#!/bin/sh

# Create alertmanager user and group
getent group alertmanager > /dev/null 2>&1 || groupadd alertmanager -r
id -u alertmanager > /dev/null 2>&1 || useradd alertmanager -g alertmanager -r -s /usr/sbin/nologin -b /home

mkdir -p /var/lib/alertmanager
chown alertmanager:alertmanager /var/lib/alertmanager/

systemctl daemon-reload


