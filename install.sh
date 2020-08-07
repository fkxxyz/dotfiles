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
arch|archarm)
  package_list="$(pacman -Qq)"
  ;;
debian|ubuntu)
  package_list="$(dpkg-query -f '${Package}\n' -W)"
  ;;
*)
  echo "Unknow release_id: $release_id"
  exit 1
esac

dot_package(){
  local path pkg
  
  path="$(readlink -f "$1")"
  
  if [ "$2" ]; then
    echo "enter package $2"
    if echo "$package_list" | grep -q "^$2\$"; then
      package_list="$(echo "$package_list" | grep -v "^$2\$")"
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
  fi
  
  find "$path" -mindepth 1 -maxdepth 1 -type d,l | while read pkg; do
    dot_package "$pkg" "$(basename "$pkg")"
  done
}

# 只安装特定的配置
if [ "$2" ]; then
  dot_package "$SHELLDIR/packages/$2" "$2"
else
  dot_package "$SHELLDIR/packages"
fi



