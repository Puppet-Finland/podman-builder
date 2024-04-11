#!/bin/sh
systemctl daemon-reload
systemctl is-active node_exporter > /dev/null 2>&1 && systemctl restart node_exporter

