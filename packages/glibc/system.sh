#!/bin/bash
set -e

if [ ! -f "/lib/locale/locale-archive" ]; then
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
  localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
fi

# 设置 tty 默认语言
echo LANG=en_US.UTF-8 > /etc/locale.conf


