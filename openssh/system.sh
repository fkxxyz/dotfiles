#!/bin/bash

# 是否允许root用户登录（否）
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(PermitRootLogin)([[:space:]].*)?$/\1 no/g' /etc/ssh/sshd_config

# 是否允许密码登录（是）
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(PasswordAuthentication)([[:space:]].*)?$/\1 yes/g' /etc/ssh/sshd_config

# 是否允许空密码（否）
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(PermitEmptyPasswords)([[:space:]].*)?$/\1 no/g' /etc/ssh/sshd_config

# 是否允许公钥登录（是）
sed -Ei 's/^[[:space:]]*#?[[:space:]]*(PubkeyAuthentication)([[:space:]].*)?$/\1 yes/g' /etc/ssh/sshd_config

