#!/bin/bash

# 默认禁用 mouse 模式
cat > /etc/skel/.vimrc << EOF
if has( 'mouse' )
    set mouse-=a
endif

EOF
