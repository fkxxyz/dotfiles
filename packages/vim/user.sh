#!/bin/bash
set -e

type vim > /dev/null 2>&1 || exit 0
echo "$*"

# 禁用 mouse 模式
cat > ~/.vimrc << EOF
if has( 'mouse' )
    set mouse-=a
endif

EOF

