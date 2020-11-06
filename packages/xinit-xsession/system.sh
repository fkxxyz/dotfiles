#!/bin/bash
set -e

[ -f "/usr/share/xsessions/xinitrc.desktop" ] || exit 0
echo "$*"

[ -f "/etc/skel/.xinitrc" ] || \
    cp "$(dirname "$(readlink -f "$0")")/.xinitrc" "/etc/skel/.xinitrc"

