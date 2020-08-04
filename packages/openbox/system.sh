#!/bin/bash
set -e

# 调整按键 Alt 改为 Windows键
sed -i -e 's/A-Left/W-Left/g' -e 's/A-Right/W-Right/g' /etc/xdg/openbox/rc.xml

