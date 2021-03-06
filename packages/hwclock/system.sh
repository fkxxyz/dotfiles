#!/bin/bash
set -e

type hwclock > /dev/null 2>&1 || exit 0
echo "$*"

if [ "$DOT_initialization" ]; then
  # 将硬件时间设置为系统的UTC时间
  if [ "$DOT_hw_is_utc" ]; then
    hwclock -s --utc || true
  else
    hwclock -s --localtime || true
  fi

  # 生成时间偏差（/etc/adjtime）
  hwclock -w || true
fi

