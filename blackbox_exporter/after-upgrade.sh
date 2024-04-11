#!/bin/sh
systemctl daemon-reload
systemctl is-active blackbox_exporter > /dev/null 2>&1 && systemctl restart blackbox_exporter
