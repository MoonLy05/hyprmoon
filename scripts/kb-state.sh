#!/bin/bash

# Buscar los paths reales de los LEDs (varían según teclado/kernel)
CAPS_LED_PATH=$(ls /sys/class/leds/ | grep -i "capslock" | head -1)
NUM_LED_PATH=$(ls /sys/class/leds/ | grep -i "numlock" | head -1)

if [ -z "$CAPS_LED_PATH" ] || [ -z "$NUM_LED_PATH" ]; then
    echo "LEDs disponibles:"
    ls /sys/class/leds/
    exit 1
fi

read_led() {
    cat "/sys/class/leds/$1/brightness" 2>/dev/null
}

send_notification() {
    local label="$1"
    local state="$2"   # "1" = on, "0" = off
    local icon="$3"

    if [ "$state" = "1" ]; then
        notify-send -e "$icon $label" "Activado"
    else
        notify-send -e "$icon $label" "Desactivado"
    fi
}

case "$1" in
    caps)
        sleep 0.1
        send_notification "Mayúsculas" "$(read_led "$CAPS_LED_PATH")" "󰪛"
        ;;
    num)
        sleep 0.1
        send_notification "Bloqueo Numérico" "$(read_led "$NUM_LED_PATH")" "󰎠"
        ;;
esac