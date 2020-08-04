#!/bin/bash
set -e

install -Dm644 "$(dirname "$(readlink -f "$0")")/bcompare-crack-patch.hook" \
	/etc/pacman.d/hooks/bcompare-crack-patch.hook

grep 'rm -f ~/.config/bcompare/registry.dat' /usr/bin/bcompare > /dev/null || \
	sed -i '1arm -f ~/.config/bcompare/registry.dat' /usr/bin/bcompare


