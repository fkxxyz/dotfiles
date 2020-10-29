#!/bin/bash
set -e

type openbox > /dev/null 2>&1 || exit 0
echo "$*"

# 调整按键 Alt 改为 Windows键
grep -q 'A-Left' /etc/xdg/openbox/rc.xml && \
    sed -i -e 's/A-Left/W-Left/g' -e 's/A-Right/W-Right/g' /etc/xdg/openbox/rc.xml

