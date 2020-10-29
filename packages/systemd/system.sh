#!/bin/bash
set -e

type /lib/systemd/systemd > /dev/null 2>&1 || exit 0
echo "$*"

# 启用 ntp 服务，获取网络时间并设置为当前系统时间
if [ "$DOT_enable_ntp" ]; then
  #timedatectl set-ntp true || true
else
  #timedatectl set-ntp false || true
fi




