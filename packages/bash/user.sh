#!/bin/bash
set -e

type bash > /dev/null 2>&1 || exit 0
echo "$*"

# 设为 gentoo 的配色方案
[ -f ~/.bashrc ] || \
  cp "$(dirname "$(readlink -f "$0")")/gentoo-bashrc-2016.0" ~/.bashrc

