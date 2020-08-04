#!/bin/bash
set -e

# 设置为英文键盘布局
loadkeys "$DOT_keymap"

# 设置默认为英文键盘布局
cat > /etc/vconsole.conf << EOF
KEYMAP=$DOT_keymap
EOF

