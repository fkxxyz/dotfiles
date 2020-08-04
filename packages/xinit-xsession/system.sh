#!/bin/bash
set -e

cp "$(dirname "$(readlink -f "$0")")/.xinitrc" "/etc/skel/.xinitrc"

