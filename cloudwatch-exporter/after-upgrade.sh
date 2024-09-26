#!/bin/sh
#
systemctl daemon-reload
systemctl restart cloudwatch-exporter || true
