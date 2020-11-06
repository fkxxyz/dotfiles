#!/bin/bash
set -e

type vim > /dev/null 2>&1 || exit 0
echo "$*"

# 禁用 mouse 模式
[ -f "$HOME/.vimrc" ] || \
cat > ~/.vimrc << EOF
if has( 'mouse' )
    set mouse-=a
endif

EOF

