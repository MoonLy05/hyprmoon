#!/usr/bin/env bash

CHOICE=$(cliphist list | fuzzel --dmenu -p ' Portapapeles > ' -w 50)

if [ -n "$CHOICE" ]; then
    echo "$CHOICE" | cliphist decode | wl-copy
fi