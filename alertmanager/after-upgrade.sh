#!/bin/sh
systemctl daemon-reload
systemctl is-active alertmanager > /dev/null 2>&1 && systemctl restart alertmanager

