#!/bin/sh

# Create promtotwilio user and group
getent group promtotwilio > /dev/null 2>&1 || groupadd promtotwilio -r
id -u promtotwilio > /dev/null 2>&1 || useradd promtotwilio -g promtotwilio -r -s /usr/sbin/nologin -b /home

systemctl daemon-reload
