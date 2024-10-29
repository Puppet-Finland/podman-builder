#!/bin/sh
systemctl daemon-reload
systemctl is-active azure_metrics_exporter > /dev/null 2>&1 && systemctl restart azure_metrics_exporter
