#!/bin/sh
systemctl daemon-reload
systemctl is-active prometheus > /dev/null 2>&1 && systemctl restart prometheus

