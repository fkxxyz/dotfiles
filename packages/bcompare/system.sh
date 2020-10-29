#!/bin/bash
set -e

type bcompare > /dev/null 2>&1 || exit 0
echo "$*"

[ -f /etc/pacman.d/hooks/bcompare-crack-patch.hook ] || \
    install -Dm644 "$(dirname "$(readlink -f "$0")")/bcompare-crack-patch.hook" \
    /etc/pacman.d/hooks/bcompare-crack-patch.hook

grep -q 'rm -f ~/.config/bcompare/registry.dat' /usr/bin/bcompare || \
    sed -i '1arm -f ~/.config/bcompare/registry.dat' /usr/bin/bcompare


