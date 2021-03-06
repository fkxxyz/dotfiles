#!/bin/bash
set -e

type conky > /dev/null 2>&1 || exit 0
echo "$*"

exit 0

# 写入配置
# TODO
mkdir -p ~/.config/conky
echo '
background yes
double_buffer yes

alignment top_right

border_width 1
cpu_avg_samples 1
default_color white
default_outline_color white
default_shade_color white
draw_borders no
draw_graph_borders yes
draw_outline no
draw_shades no

gap_x 16
gap_y 16
net_avg_samples 1
no_buffers yes
out_to_console no
out_to_stderr no
extra_newline no

own_window yes
own_window_type normal 
own_window_hints undecorated,below,skip_taskbar,skip_pager
own_window_transparent no
own_window_colour 2E0047
own_window_argb_visual yes
own_window_argb_value 102

minimum_size 170 0
stippled_borders 0
update_interval 1.0
uppercase no
use_spacer none

show_graph_scale no
show_graph_range no

use_xft yes
xftalpha 0.1
xftfont Droid Sans:size=10
color0 white
color1 EAEAEA
color2 FFA300
color3 grey

TEXT
${color2}CPU ${color0}${alignr}${cpu}%
${cpubar cpu0 6,}
${top name 1} $alignr ${top cpu 1}%
${top name 2} $alignr ${top cpu 2}%
${top name 3} $alignr ${top cpu 3}%
${top name 4} $alignr ${top cpu 4}%
${top name 5} $alignr ${top cpu 5}%
${top name 6} $alignr ${top cpu 6}%
${top name 7} $alignr ${top cpu 7}%
${top name 8} $alignr ${top cpu 8}%

${color2}RAM ${color0}${alignr}${mem}
${membar 6,}
${top_mem name 1} $alignr ${top_mem mem_res 1}
${top_mem name 2} $alignr ${top_mem mem_res 2}
${top_mem name 3} $alignr ${top_mem mem_res 3}
${top_mem name 4} $alignr ${top_mem mem_res 4}
${top_mem name 5} $alignr ${top_mem mem_res 5}
${top_mem name 6} $alignr ${top_mem mem_res 6}
${top_mem name 7} $alignr ${top_mem mem_res 7}
${top_mem name 8} $alignr ${top_mem mem_res 8}

${color2}Network ${color0}' > ~/.config/conky/conky.conf

for ifname in $(ls -1 /sys/class/net/); do
	[ "$ifname" == "lo" ] && continue
	printf "$ifname \${color0}\${alignr}↓ \${downspeedf $ifname} KiB/s
\${downspeedgraph $ifname 26,}
$ifname \${color0}\${alignr}↑ \${upspeedf $ifname} KiB/s
\${upspeedgraph $ifname 26,}
" >> ~/.config/conky/conky.conf
done


# 设置自动启动
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/conky.sh << EOF
exec conky
EOF

chmod 755 ~/.config/autostart/conky.sh 

