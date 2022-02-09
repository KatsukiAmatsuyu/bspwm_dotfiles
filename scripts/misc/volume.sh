#!/usr/bin/env bash

# You can call this script like this:
# $ ./volumeControl.sh up
# $ ./volumeControl.sh down
# $ ./volumeControl.sh mute

# Script modified from these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

get_volume() {
 pactl get-sink-volume @DEFAULT_SINK@ | grep -Eo -e '[0-9]%' -e '[0-9][0-9]%' -e '[0-9][0-9][0-9]%' | head -1 
}

is_mute() {
  pactl get-sink-mute @DEFAULT_SINK@ | grep -Eo -e no -e yes
}

send_notification() {
  iconSound="audio-volume-high"
  volume="$(get_volume)"
  bar=$volume
  dunstify "Volume at $volume" -i "" -a "Sound" -r 2593 -u low "    $bar"
}

toggle_mute() {
  iconMute="audio-volume-muted"
  state="$(is_mute)"
  req="yes"
  volume="$(get_volume)"
  if [ "$state" = "$req" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle 
    dunstify "Volume at $volume" -a "Sound" -i "" -r 2593 -u low
  else
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    dunstify "Muted" -a "Sound" -i "" -r 2593 -u low
  fi
}

inc_volume() {
  volume="$(get_volume)"
  max="100%"
  if [ "$volume" = "$max" ]; then
    dunstify "Volume at 100% (MAX)" -i "" -a "Sound" -r 2593 -u low
  else
    pactl set-sink-mute @DEFAULT_SINK@ no
    pactl set-sink-volume @DEFAULT_SINK@ +5% 
    dunstify "Volume at $volume" -i "" -a "Sound" -r 2593 -u low
  fi
}

case $1 in
  up)
    # set the volume on (if it was muted)
    # pactl set-sink-mute @DEFAULT_SINK@ no > /dev/null
    # up the volume (+ 5%)
    # pactl set-sink-volume @DEFAULT_SINK@ +5% > /dev/null
    inc_volume
    # send_notification
    ;;
  down)
    pactl set-sink-mute @DEFAULT_SINK@ no > /dev/null
    pactl set-sink-volume @DEFAULT_SINK@ -5% > /dev/null
    send_notification
    ;;
  mute)
    toggle_mute
    # pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
    # send_notification_muted
    ;;
esac
