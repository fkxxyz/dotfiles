#!/bin/bash
set -e

[ -f "/usr/share/xsessions/xinitrc.desktop" ] || exit 0
echo "$*"

cp "$(dirname "$(readlink -f "$0")")/.xinitrc" "/etc/skel/.xinitrc"

