#!/bin/bash

PIC=/home/katsuki/i3lock.png
SCRSHT="scrot $PIC"

BLUR="7x6"

$SCRSHT
convert $PIC -blur $BLUR $PIC
i3lock -i $PIC
rm $PIC
