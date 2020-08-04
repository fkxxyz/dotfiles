#!/bin/bash
set -e

# 禁用响铃
if [ "$DOT_disable_beep" ]; then
cat > /etc/modprobe.d/nobeep.conf << EOF
blacklist pcspkr
EOF
fi

# 禁用n显卡开源驱动（此驱动bug过多，可能导致死机）
if [ "$DOT_disable_nouveau" ]; then
cat > /etc/modprobe.d/no-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF
fi

# 禁用蓝牙（可选，长期不用禁了省电）
if [ "$DOT_disable_bluetooth" ]; then
find /lib/modules/*/kernel -name bluetooth | \
	xargs find | grep '\.xz$' | \
	awk -F'/' '{print $NF}' | awk -F'.' '{print "blacklist " $1}' \
	>> /etc/modprobe.d/no-bluetooth.conf
fi

# 解除 rf 锁
if [ "$DOT_rfkill_unblock_all" ]; then
rfkill unblock all
fi


