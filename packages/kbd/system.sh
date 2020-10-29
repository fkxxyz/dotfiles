#!/bin/bash
set -e

type localedef > /dev/null 2>&1 || exit 0
echo "$*"

# 设置默认为英文键盘布局
cat > /etc/vconsole.conf << EOF
KEYMAP=$DOT_keymap
EOF

