#!/bin/bash
set -e

type openbox > /dev/null 2>&1 || exit 0
echo "$*"

# 调整按键 Alt 改为 Windows键
if [ -f ~/.config/openbox/rc.xml ]; then
  sed -i -e 's/A-Left/W-Left/g' -e 's/A-Right/W-Right/g' ~/.config/openbox/rc.xml
fi

