#!/bin/bash
set -e

cat > ~/.xprofile << EOF
export GTK_IM_MODULE=$DOT_X_im_module
export QT_IM_MODULE=$DOT_X_im_module
export XMODIFIERS="@im=$DOT_X_im_module"

export LANG="$DOT_X_LANG"
export LC_CTYPE="$DOT_X_LANG"
EOF


