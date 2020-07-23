#!/bin/bash

# 复制 oh-my-zsh 的配置
cp /usr/share/oh-my-zsh/zshrc /etc/skel/.zshrc

# 设置默认主题
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(ZSH_THEME=).*$/\1"ys"/g' /etc/skel/.zshrc

# 修改默认 shell
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(SHELL=).*$/\1\/bin\/zsh/g' /etc/default/useradd
