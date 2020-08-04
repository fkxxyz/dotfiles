#!/bin/bash
set -e

SHELLDIR="$(dirname "$(readlink -f "$0")")"

# 加载全局配置
source "$SHELLDIR/config/global"

# 加载参数的配置
[ "$1" ] && source "$SHELLDIR/config/$1"

# 查询系统的发行版类型
export release_id="$(cat /usr/lib/os-release | grep '^ID=' | cut -d'=' -f2)"
export release_codename="$(cat /usr/lib/os-release | grep '^VERSION_CODENAME=' | cut -d'=' -f2)"

# 读取所有的包名
case "$release_id" in
arch)
  package_list="$(pacman -Qq)"
  ;;
debian|ubuntu)
  package_list="$(dpkg-query -f '${Package}\n' -W)"
  ;;
esac

dot_package(){
  local path pkg
  
  path="$(readlink -f "$1")"
  pkg="$(basename "$(readlink -f "$1")")"
  
  echo "enter $path"
  if echo "$package_list" | grep -q "^$pkg\$"; then
    package_list="$(echo "$package_list" | grep -v "^$pkg\$")"
    if [ "$USER" == "root" ]; then
      if [ -x "$path/system.sh" ]; then
        echo "install $path/system.sh"
        "$path/system.sh"
      fi
    fi
    if [ -x "$path/user.sh" ]; then
      echo "install $path/user.sh"
      "$path/user.sh"
    fi
  fi
  
  find "$path" -mindepth 1 -maxdepth 1 -type d | while read pkg; do
    dot_package "$pkg"
  done
}

# 只安装特定的配置
if [ "$2" ]; then
  dot_package "$SHELLDIR/packages/$2"
else
  dot_package "$SHELLDIR/packages"
fi



