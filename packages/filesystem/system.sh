#!/bin/bash
set -e

cat > /etc/profile.d/userbin.sh << EOF
export PATH=\$HOME/.local/bin:\$PATH
EOF

