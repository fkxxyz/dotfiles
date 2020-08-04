#!/bin/bash
set -e

# 默认设为 gentoo 的配色方案
cp "$(dirname "$(readlink -f "$0")")/gentoo-bashrc-2016.0" /etc/skel/.bashrc

