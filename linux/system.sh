#!/bin/bash

# 禁用响铃
cat > /etc/modprobe.d/nobeep.conf << EOF
blacklist pcspkr
EOF

# 禁用n显卡开源驱动（此驱动bug过多，可能导致死机）
cat > /etc/modprobe.d/no-nouveau.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF

# 禁用蓝牙（可选，长期不用禁了省电）
find /lib/modules/`uname -r`/kernel -name bluetooth | \
	xargs find | grep '\.xz$' | \
	awk -F'/' '{print $NF}' | awk -F'.' '{print "blacklist " $1}' \
	>> /etc/modprobe.d/no-bluetooth.conf

# 解除 rf 锁
rfkill unblock all

