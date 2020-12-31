
[ -f ~/.xprofile ] && . ~/.xprofile

source /etc/profile

# deamon process
daemon_dir=/tmp/xinitrc_deamon_$USER
mkdir -p $daemon_dir
cp -f /usr/bin/sleep $daemon_dir/xinitrc_deamon_$USER
$daemon_dir/xinitrc_deamon_$USER 3650000d &
main_pid=$!
echo $main_pid > $daemon_dir/pid

export > $daemon_dir/xrun
echo 'exec "$@"' >> $daemon_dir/xrun
chmod +x $daemon_dir/xrun

# wallpaper || desktop
pcmanfm --desktop &
#xwallpaper --stretch "$(wallpaper get | cut -d"	" -f3)"

# window manager
compiz &

# nodify
/usr/lib/xfce4/notifyd/xfce4-notifyd &

# polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

if [ -d /etc/xdg/autostart ] ; then
 for f in /etc/xdg/autostart/*.desktop ; do
  exo-open "$f" &
 done
 unset f
fi

# panel
xfce4-panel &

if [ -d ~/.config/autostart ] ; then
 for f in ~/.config/autostart/*.desktop ; do
  [ -x "$f" ] && exo-open "$f" &
 done
 unset f
fi

if [ -d ~/.config/autostart ] ; then
 for f in ~/.config/autostart/*.sh ; do
  [ -x "$f" ] && "$f" &
 done
 unset f
fi

wait $main_pid


