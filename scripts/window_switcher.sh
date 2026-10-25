#!/usr/bin/env bash

dispatch() {
    hyprctl dispatch "$1" >/dev/null
}

JSON=$(hyprctl clients -j | jq "[.[] | select(.workspace.id > 0)]")

mapfile -t ADDRS   < <(echo "$JSON" | jq -r '.[].address')
mapfile -t CLASSES < <(echo "$JSON" | jq -r '.[].class')
mapfile -t TITLES  < <(echo "$JSON" | jq -r '.[].title')

if [ ${#ADDRS[@]} -eq 0 ]; then
    notify-send -u low "Tabulador de apps" "No hay ventanas abiertas"
    exit 0
fi

CHOICE=$(for i in "${!ADDRS[@]}"; do
    printf '%s: %s\0icon\x1f%s\n' "${CLASSES[$i]}" "${TITLES[$i]}" "${CLASSES[$i],,}"
done | fuzzel -d -i --index -p "󰖯 Ventanas ")

if [ -n "$CHOICE" ]; then
    ADDR="${ADDRS[$CHOICE]}"

    dispatch "hl.dsp.focus({ window = \"address:$ADDR\" })"
fi