#!/bin/bash
set -e

type xwallpaper > /dev/null 2>&1 || exit 0
echo "$*"

SCRIPT_FOLDER="$(dirname "$(readlink -f "$0")")"

mkdir -p ~/.local/bin

[ -f ~/.local/bin/folders_files_switcher ] || \
ln -sf "$SCRIPT_FOLDER/folders_files_switcher" ~/.local/bin/folders_files_switcher
[ -f ~/.local/bin/wallpaper ] || \
ln -sf "$SCRIPT_FOLDER/wallpaper" ~/.local/bin/wallpaper

[ -f ~/.config/wallpaper.conf ] || \
install -Dm644 "$SCRIPT_FOLDER/wallpaper.conf" ~/.config/wallpaper.conf

