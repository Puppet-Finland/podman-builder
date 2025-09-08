#!/bin/sh
systemctl daemon-reload
systemctl is-active promtotwilio > /dev/null 2>&1 && systemctl restart promtotwilio
