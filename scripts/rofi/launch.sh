#!/bin/bash

menu="$1"

if [ "$menu" = "music" ]; then
    rofi -modi 'Music:~/scripts/rofi/music.sh' -show Music -theme music-launcher
elif [ "$menu" = "appmenu" ]; then
    rofi -show drun -theme clean -location 1 -xoffset 34 -yoffset 82 -m primary
elif [ "$menu" = "powermenu" ]; then
#    rofi -modi 'Powermenu:~/scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu
    rofi -modi 'Powermenu:~/scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu -location 3 -xoffset -34 -yoffset 82 -m primary
elif [ "$menu" = "tabmenu" ]; then
    ~/scripts/rofi/tabmenu.sh
elif [ "$menu" = "kblayout" ]; then
    ~/scripts/rofi/kblayout.sh
fi
