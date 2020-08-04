#!/bin/bash
set -e

# 允许提权
sed -i 's/^[[:space:]]*#*[[:space:]]*\(root[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g' /etc/sudoers

# 允许 wheel 组成员执行任何命令
sed -i 's/^[[:space:]]*#*[[:space:]]*\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g' /etc/sudoers

# 允许 wheel 组成员无密码执行任何命令（否）
sed -i 's/^[[:space:]]*#*[[:space:]]*\(%wheel[[:space:]]*ALL=(ALL)[[:space:]]*NOPASSWD:[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/# \1/g' /etc/sudoers

# 允许 sudo 组成员执行任何命令
sed -i 's/^[[:space:]]*#*[[:space:]]*\(%sudo[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g' /etc/sudoers

# 允许 admin 组成员执行任何命令
sed -i 's/^[[:space:]]*#*[[:space:]]*\(%admin[[:space:]]*ALL=(ALL)[[:space:]]*ALL[[:space:]]*\(#.*\)\?\)$/\1/g' /etc/sudoers


