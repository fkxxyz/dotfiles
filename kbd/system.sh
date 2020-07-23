#!/bin/bash

# 设置为英文键盘布局
loadkeys us

# 设置默认为英文键盘布局
cat > /etc/vconsole.conf << EOF
KEYMAP=us
EOF
