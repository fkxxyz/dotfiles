#!/bin/bash
set -e

echo "$*"

# 设置时区
[ -f /etc/localtime ] || \
    ln -sf /usr/share/zoneinfo/$DOT_zoneinfo /etc/localtime


