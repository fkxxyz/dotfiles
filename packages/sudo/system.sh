#!/bin/bash
set -e

type sudo > /dev/null 2>&1 || exit 0
echo "$*"

cfg="$(cat /etc/sudoers)"

sed_scripts=()

# 允许提权
echo "$cfg" | grep -q '^root[[:space:]]\+ALL=(ALL) ALL' || \
  sed_scripts+=(-e 's/^[[:space:]]*#*[[:space:]]*\(root[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g')

# 允许 wheel 组成员执行任何命令
echo "$cfg" | grep -q '^%wheel[[:space:]]\+ALL=(ALL) ALL' || \
  sed_scripts+=(-e 's/^[[:space:]]*#*[[:space:]]*\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g')

# 允许 wheel 组成员无密码执行任何命令（否）
echo "$cfg" | grep -q '^# %wheel[[:space:]]\+ALL=(ALL) NOPASSWD: ALL' || \
  sed_scripts+=(-e 's/^[[:space:]]*#*[[:space:]]*\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/# \1/g')
# 允许 sudo 组成员执行任何命令
echo "$cfg" | grep -q '^%sudo[[:space:]]\+ALL=(ALL) ALL' || \
  sed_scripts+=(-e 's/^[[:space:]]*#*[[:space:]]*\(%sudo[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g')

# 允许 admin 组成员执行任何命令
echo "$cfg" | grep -q '^%admin[[:space:]]\+ALL=(ALL) ALL' || \
  sed_scripts+=(-e 's/^[[:space:]]*#*[[:space:]]*\(%admin[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g')

sed -i -e '' "${sed_scripts[@]}" /etc/sudoers


