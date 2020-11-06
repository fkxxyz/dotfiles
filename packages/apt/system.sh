#!/bin/bash
set -e

type apt > /dev/null 2>&1 || exit 0
echo "$*"

# TODO

# 设置默认不安装 Recommends 和 Suggests 的软件包
mkdir -p "/etc/apt/apt.conf.d"
cat > "/etc/apt/apt.conf.d/no-recommends-suggests" << EOF
APT::Install-Recommends "false";
APT::Install-Suggests "false";
EOF

# 设置源
case "$release_id" in
'ubuntu')
  cat > /etc/apt/sources.list << EOF
deb $DOT_mirror_ubuntu/ $release_codename main restricted universe multiverse
# deb-src $DOT_mirror_ubuntu/ $release_codename main restricted universe multiverse
deb $DOT_mirror_ubuntu/ $release_codename-updates main restricted universe multiverse
# deb-src $DOT_mirror_ubuntu/ $release_codename-updates main restricted universe multiverse
deb $DOT_mirror_ubuntu/ $release_codename-backports main restricted universe multiverse
# deb-src $DOT_mirror_ubuntu/ $release_codename-backports main restricted universe multiverse
deb $DOT_mirror_ubuntu/ $release_codename-security main restricted universe multiverse
# deb-src $DOT_mirror_ubuntu/ $release_codename-security main restricted universe multiverse

# deb $DOT_mirror_ubuntu/ $release_codename-proposed main restricted universe multiverse
# deb-src $DOT_mirror_ubuntu/ $release_codename-proposed main restricted universe multiverse
EOF
  ;;
'debian')
  if [ "$DOT_debian_release_codename" == "sid" ]; then
  cat > /etc/apt/sources.list << EOF
deb $DOT_mirror_debian/ $DOT_debian_release_codename main contrib non-free
# deb-src $DOT_mirror_debian/ $DOT_debian_release_codename main contrib non-free
EOF
  else
  cat > /etc/apt/sources.list << EOF
deb $DOT_mirror_debian/ $DOT_debian_release_codename main contrib non-free
# deb-src $DOT_mirror_debian/ $DOT_debian_release_codename main contrib non-free
deb $DOT_mirror_debian/ $DOT_debian_release_codename-updates main contrib non-free
# deb-src $DOT_mirror_debian/ $DOT_debian_release_codename-updates main contrib non-free
deb $DOT_mirror_debian/ $DOT_debian_release_codename-backports main contrib non-free
# deb-src $DOT_mirror_debian/ $DOT_debian_release_codename-backports main contrib non-free
deb $DOT_mirror_debian-security $DOT_debian_release_codename-security main contrib non-free
# deb-src $DOT_mirror_debian-security $DOT_debian_release_codename-security main contrib non-free
EOF
  fi
  ;;
esac


