#!/bin/bash
set -e

type vim > /dev/null 2>&1 || exit 0
echo "$*"

[ -f ~/.vimrc ] || \
  install -Dm644 "$(dirname "$(readlink -f "$0")")/vimrc" ~/.vimrc


