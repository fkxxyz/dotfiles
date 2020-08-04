#!/bin/bash
set -e

# 设置为 Intel 图形驱动
if lspci | grep VGA | grep Intel > /dev/null; then
	pacman -S --needed xf86-video-intel
	cat > /etc/X11/xorg.conf.d/20-intel.conf << EOF
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
EndSection
EOF
fi

