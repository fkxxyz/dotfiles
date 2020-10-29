#!/bin/bash
set -e

type git > /dev/null 2>&1 || exit 0
echo "$*"

if [ -f ~/.gitconfig ]; then
  # 默认合并仓库
  git config --global pull.rebase false

  # 帐号信息
  git config --global user.email "fkxxyz@163.com"
  git config --global user.name "fkxxyz"

  # 免密码
  git config --global credential.helper store
fi
