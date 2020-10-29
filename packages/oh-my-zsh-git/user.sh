#!/bin/bash
set -e

[ -f "/usr/share/oh-my-zsh/zshrc" ] || exit 0
echo "$*"

if [ -f ~/.zshrc ]; then
  # 复制 oh-my-zsh 的配置
  cp /usr/share/oh-my-zsh/zshrc ~/.zshrc

  # 设置主题
  sed -Ei 's/^[[:space:]]*#?[[:space:]]*(ZSH_THEME=).*$/\1"ys"/g' ~/.zshrc

  # 修改 shell
  #chsh -s /bin/zsh
fi
