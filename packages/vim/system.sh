#!/bin/bash
set -e

type vim > /dev/null 2>&1 || exit 0
echo "$*"

[ -f "/etc/skel/.vimrc" ] || \
  install -Dm644 "$(dirname "$(readlink -f "$0")")/vimrc" "/etc/skel/.vimrc"


