#!/bin/bash

## 设置本地语言（只保留 en_US.UTF-8 和 zh_CN.UTF-8）
sed -Ei -e 's/(^[^#])(.*)$/#\1\2/g' \
	-e '23,$s/^[#[:space:]]*(en_US.UTF-8|zh_CN.UTF-8)([[:space:]]*UTF-8[[:space:]]*)$/\1\2/g' /etc/locale.gen

# 生成语言二进制（/lib/locale/locale-archive）
locale-gen

# 设置 tty 默认语言
echo LANG=en_US.UTF-8 > /etc/locale.conf
