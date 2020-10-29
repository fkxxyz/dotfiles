#!/bin/bash
set -e

SHELLDIR="$(dirname "$(readlink -f "$0")")"

execute_script(){
  # $1 script
  if [ -x "$1" ]; then
    "$1" "  Execute: $1"
  fi
}

install_package_cfg(){
  # $1 package
  package="$1"
  echo "Install configure: $package"
  [ "$UID" == "0" ] && execute_script "$SHELLDIR/packages/$package/system.sh"
  execute_script "$SHELLDIR/packages/$package/user.sh"
}

main(){
  help_msg="Usage: $0 [-c <config>] [-p <package>] [-l]
  Install configures.

         -c config
         -p package
  "
  while getopts "c:p:h" opt; do
    case ${opt} in
      c)
        config="$OPTARG"
        ;;
      p)
        package="$OPTARG"
        ;;
      h)
        printf "$help_msg" >&2
        return
        ;;
      \?)
        printf "$help_msg" >&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND -1))

  # 加载全局配置
  source "$SHELLDIR/config/global"

  # 加载参数的配置
  [ "$config" ] && source "$SHELLDIR/config/$config"

  if [ "$package" ]; then
    # 只安装特定包的配置
    [ -d "$SHELLDIR/packages/$package" ] || return 1
    install_package_cfg "$package"
    return
  fi

  # 安装所有包的配置
  ls -1 "$SHELLDIR/packages" | while read package; do
    install_package_cfg "$package"
  done
}

main "$@"

