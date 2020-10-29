#!/bin/bash
set -e

type bcompare > /dev/null 2>&1 || exit 0
echo "$*"

rm -f ~/.config/bcompare/registry.dat

