#!/bin/bash

# 禁用 mouse 模式
cat > ~/.vimrc << EOF
if has( 'mouse' )
    set mouse-=a
endif

EOF

