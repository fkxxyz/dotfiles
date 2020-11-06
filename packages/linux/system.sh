#!/bin/bash
set -e

pacman -Q linux > /dev/null 2>&1 || exit 0
echo "$*"

# 禁用响铃
if [ "$DOT_disable_beep" ]; then
  [ -f /etc/modprobe.d/nobeep.conf ] || \
      printf 'blacklist pcspkr
' | install -Dm644 /dev/stdin /etc/modprobe.d/nobeep.conf
fi

# 禁用n显卡开源驱动（此驱动bug过多，可能导致死机）
if [ "$DOT_disable_nouveau" ]; then
  [ -f /etc/modprobe.d/no-nouveau.conf ] || \
      printf 'blacklist nouveau
options nouveau modeset=0
' | install -Dm644 /dev/stdin /etc/modprobe.d/no-nouveau.conf
fi

# 禁用蓝牙（可选，长期不用禁了省电）
if [ "$DOT_disable_bluetooth" ]; then
  [ -f /etc/modprobe.d/no-bluetooth.conf ] || \
      find /lib/modules/*/kernel -name bluetooth | \
	  xargs find | grep '\.xz$' | \
	  awk -F'/' '{print $NF}' | awk -F'.' '{print "blacklist " $1}' \
	  > /etc/modprobe.d/no-bluetooth.conf
fi

# 解除 rf 锁
if [ "$DOT_rfkill_unblock_all" ]; then
  if [ "$DOT_initialization" ]; then
    rfkill unblock all
  fi
fi


