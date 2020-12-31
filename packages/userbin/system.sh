#!/bin/bash
set -e

[ -d "/etc/profile.d" ] || exit 0
echo "$*"

[ -f /etc/profile.d/userbin.sh ] || \
    printf '
export PATH=$HOME/.local/bin:$PATH
' | install -Dm644 /dev/stdin /etc/profile.d/userbin.sh

