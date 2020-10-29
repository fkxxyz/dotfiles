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

for item in ${items[@]}; do
  if [ "$(eval echo \$DOT_$item)" ]; then
    value=yes
  else
    value=no
  fi
  echo "$cfg" | grep -q "^$item $value" || \
      sed -Ei 's/^[[:space:]]*#?[[:space:]]*('"$item"')([[:space:]].*)?$/\1 '"$value"'/g' /etc/ssh/sshd_config
done


