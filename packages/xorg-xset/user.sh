#!/bin/bash
set -e

mkdir -p ~/.config/autostart

# 用 LXInput 中已有的设置配置键盘和鼠标
cat > ~/.config/autostart/LXinput-setup.desktop << EOF
[Desktop Entry]
Type=Application
Name=LXInput 自动启动
Comment=用 LXInput 中已有的设置配置键盘和鼠标
NoDisplay=true
Exec=sh -c 'xset m 20/10 10 r rate 232 42 b on'
NotShowIn=GNOME;KDE;XFCE;
EOF
chmod 755 ~/.config/autostart/LXinput-setup.desktop
