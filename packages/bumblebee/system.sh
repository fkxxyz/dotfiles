#!/bin/bash
set -e

type optirun > /dev/null 2>&1 || exit 0
echo "$*"

# 修改驱动为 nvidia
sed -Ei '/^[[:space:]]*\[bumblebeed\]/,/^[[:space:]]*\[.*\]/s/^([[:space:]]*Driver[[:space:]]*=[[:space:]]*).*/\1nvidia/g' /etc/bumblebee/bumblebee.conf

# 修改电源模式为 bbswitch
sed -Ei '/^[[:space:]]*\[driver-nvidia\]/,/^[[:space:]]*\[.*\]/s/^([[:space:]]*PMMethod[[:space:]]*=[[:space:]]*).*/\1bbswitch/g' /etc/bumblebee/bumblebee.conf

# 设置为自动启动
[ -f /etc/systemd/system/graphical.target.wants/bumblebeed.service ] || \
    systemctl enable bumblebeed
