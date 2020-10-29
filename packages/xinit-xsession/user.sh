#!/bin/bash
set -e

[ -f "/usr/share/xsessions/xinitrc.desktop" ] || exit 0
echo "$*"

ln -sf "$(dirname "$(readlink -f "$0")")/.xinitrc" ~/.xinitrc

