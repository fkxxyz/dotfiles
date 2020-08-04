#!/bin/bash
set -e

items=(
  PermitRootLogin
  PasswordAuthentication
  PermitEmptyPasswords
  PubkeyAuthentication
)

for item in ${items[@]}; do
  if [ "$(eval echo \$DOT_$item)" ]; then
    value=yes
  else
    value=no
  fi
  sed -Ei 's/^[[:space:]]*#?[[:space:]]*('"$item"')([[:space:]].*)?$/\1 '"$value"'/g' /etc/ssh/sshd_config
done


