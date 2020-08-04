#!/bin/bash
set -e

# 开启颜色支持
sed -Ei 's/^[#[:space:]]*(Color[[:space:]]*)$/\1/g' /etc/pacman.conf

# 将内核相关的包加入忽略升级
if grep -qE '^[#[:space:]]*IgnorePkg[[:space:]]*=(.*[[:space:]]|[[:space:]]*)linux([[:space:]].*|[[:space:]]*$)' /etc/pacman.conf ; then
	:
else
	sed -Ei 's/(^[#[:space:]]*IgnorePkg[[:space:]]*=.*)/\1\nIgnorePkg = '"$(pacman -Qoq /lib/modules/ | xargs)"'/' /etc/pacman.conf
fi

# 设置 archlinuxcn 仓库
if grep -q '\[archlinuxcn\]' /etc/pacman.conf; then
	:
else
	echo "
[archlinuxcn]
Server = $mirror/archlinuxcn/\$arch
" >> /etc/pacman.conf
	pacman -Sy --noconfirm archlinuxcn-keyring
fi

if [ "$(sed -n '/%ARCH%/{n;p}' /var/lib/pacman/local/pacman-$(pacman -Q pacman | cut -d' ' -f2)/desc)" == 'x86_64' ]; then
  # 开启 multilib 仓库（32位仓库）
  sed -Ei '/^[#[:space:]]*(\[multilib\])[[:space:]]*$/{N;s/^[#[:space:]]*(\[multilib\])[[:space:]]*\n[#[:space:]]*(Include[[:space:]]*=[[:space:]]*\/etc\/pacman.d\/mirrorlist[[:space:]]*)$/\1\n\2/g}' /etc/pacman.conf

  # 设置 nickcao 仓库
  if [ "$DOT_enable_nickcao" ]; then
  if grep -q '\[nickcao\]' /etc/pacman.conf; then
	  :
  else
	  echo "
[nickcao]
SigLevel = Never
Server = https://repo.nichi.co/\$arch
" >> /etc/pacman.conf
  fi
  fi
fi





# 默认所有线程编译
sed -Ei 's/^[#[:space:]]*(MAKEFLAGS=).*$/\1"-j'"$(cat /proc/cpuinfo | grep processor | sort -u | wc -l)"'"/g' /etc/makepkg.conf

# 默认压缩格式为 zst
sed -Ei 's/^[#[:space:]]*(PKGEXT=).*$/\1'"'.pkg.tar.zst'"'/g' /etc/makepkg.conf


