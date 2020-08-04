#!/bin/bash
set -e

ln -sf "$(dirname "$(readlink -f "$0")")/.xinitrc" ~/.xinitrc

