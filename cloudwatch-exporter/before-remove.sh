#!/bin/sh
#
systemctl is-active cloudwatch-exporter && systemctl stop cloudwatch-exporter || true
