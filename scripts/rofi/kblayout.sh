#!/bin/bash 

options="-location 3 -xoffset -34 -yoffset 82 -m primary"

rofiprompt="$HOME/.config/rofi/kb.rasi"

chlang_eng() {
  setxkbmap -layout ru,us -option "grp:caps_toggle"
}

chlang_rus() {
  setxkbmap -layout us,ru -option "grp:caps_toggle"
}

rofikb=$(printf "English\nRussian" | rofi -config $rofiprompt -dmenu -i -p "Choose keyboard layout" $options)

case $rofikb in 
  English)
    chlang_eng
  ;;
  Russian)
    chlang_rus
  ;;
esac 2>/dev/null
