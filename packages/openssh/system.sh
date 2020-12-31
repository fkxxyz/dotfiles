#!/bin/bash
set -e

type sshd > /dev/null 2>&1 || exit 0
echo "$*"

items=(
  PermitRootLogin
  PasswordAuthentication
  PermitEmptyPasswords
  PubkeyAuthentication
)
cfg="$(cat /etc/sudoers)"
sed_scripts=()

for item in ${items[@]}; do
  if [ "$(eval echo \$DOT_$item)" ]; then
    value=yes
  else
    value=no
  fi
  echo "$cfg" | grep -q "^$item $value" || \
    sed_scripts+=(-e 's/^[[:space:]]*#?[[:space:]]*('"$item"')([[:space:]].*)?$/\1 '"$value"'/g')
done

sed -Ei -e '' "${sed_scripts[@]}" /etc/ssh/sshd_config

