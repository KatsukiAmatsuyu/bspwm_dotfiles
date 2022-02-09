#!/bin/bash

get_state() {
  xkblayout-state print %n | grep -Eo -e English -e Russian
}

get_caps_state() {
  xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p'
}

get_num_state() {
  xset q | grep -i num | cut -c 46-48
}

num=$(get_num_state)
caps=$(get_caps_state)
kb=$(get_state)
kbstate=""

case $kb in
  English)
    kbstate="ENG"
  ;;
  Russian)
    kbstate="RUS"
  ;;
esac 2>/dev/null

# if [ "$caps" = "on" ]; then
#   kbstate="${kbstate} [+]"
# fi

case $caps in
  on)
    capsState="[+]"
  ;;
  off)
    capsState=""
  ;;
esac 2>/dev/null

printf "$kbstate $capsState"
