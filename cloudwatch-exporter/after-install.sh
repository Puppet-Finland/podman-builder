#!/bin/sh

id -u cloudwatch > /dev/null 2>&1 || useradd cloudwatch -r -s /bin/false -b /opt/cloudwatch-exporter
systemctl daemon-reload
