#!/bin/bash

source "$HOME/.config/hyprlock/Scripts/player_list.sh"

if [[ $(playerctl -p "$PLAYER_APP" status 2>/dev/null) == "Playing" ]]; then
    status='▷ '
else
    status=' '
fi

song_info=$(playerctl -p "$PLAYER_APP" metadata --format "$status {{title}}  \n   {{artist}}")

echo -e "$song_info"