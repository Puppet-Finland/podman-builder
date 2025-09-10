#!/bin/sh
systemctl daemon-reload
systemctl is-active updates-exporter > /dev/null 2>&1 && systemctl restart updates-exporter
