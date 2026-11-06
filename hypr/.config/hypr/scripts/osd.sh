#!/usr/bin/env bash

# --- CONFIGURACIÓN ---
# ID para que la notificación se reemplace a sí misma (efecto OSD)
TAG="sys-notify"

# Dispositivo de brillo. Vacío = automático (el que registre el kernel).
# Al cambiar la MUX cambia el dispositivo: en híbrido suele ser intel_backlight,
# en dGPU nvidia_wmi_ec_backlight. Si el automático elige mal, fíjalo aquí.
# Ver cuáles hay: ls /sys/class/backlight/
BL_DEV=""

if [ -z "$BL_DEV" ]; then
    BL_DEV=$(ls /sys/class/backlight/ 2>/dev/null | head -n1)
fi

BRI_ARGS=()
if [ -n "$BL_DEV" ]; then
    BRI_ARGS=(-d "$BL_DEV")
fi

bri() {
    brightnessctl "${BRI_ARGS[@]}" "$@"
}

get_bri() {
    bri -m | cut -d, -f4 | tr -d %
}

# Función para enviar notificación
send_notification() {
    local ICON=$1
    local TEXT=$2
    local VALUE=$3

    # -h string:x-canonical-private-synchronous:$TAG -> se actualiza en lugar de acumularse
    # -h int:value:$VALUE -> valor para la barra de progreso de SwayNC
    notify-send -h string:x-canonical-private-synchronous:"$TAG" \
        -h int:value:"$VALUE" \
        -e \
        -i "$ICON" \
        "$TEXT" \
        "Nivel: $VALUE%"
}

# icono_volumen NÚMERO → imprime el nombre del ícono según el volumen
icono_volumen() {
    local vol="$1"
    if [ "$vol" -eq 0 ]; then
        echo "audio-volume-muted"
    elif [ "$vol" -le 30 ]; then
        echo "audio-volume-low"
    elif [ "$vol" -le 70 ]; then
        echo "audio-volume-medium"
    else
        echo "audio-volume-high"
    fi
}

mostrar_volumen() {
    local vol icon
    vol=$(pamixer --get-volume)
    icon=$(icono_volumen "$vol")
    send_notification "$icon" "Volumen" "$vol"
}

case $1 in
    # --- VOLUMEN ---
    vol_up)
        pamixer -u -i 5
        mostrar_volumen
        ;;
    vol_down)
        pamixer -d 5
        mostrar_volumen
        ;;
    vol_mute)
        pamixer -t
        MUTE=$(pamixer --get-mute)
        if [ "$MUTE" == "true" ]; then
            notify-send -h string:x-canonical-private-synchronous:"$TAG" -e -i "audio-volume-muted" "Silencio" "Audio desactivado"
        else
            mostrar_volumen
        fi
        ;;
    mic_mute)
        pamixer --default-source -t
        MUTE=$(pamixer --default-source --get-mute)
        if [ "$MUTE" == "true" ]; then
            notify-send -h string:x-canonical-private-synchronous:"$TAG" -e -i "microphone-sensitivity-muted" "Micrófono" "Desactivado"
        else
            notify-send -h string:x-canonical-private-synchronous:"$TAG" -e -i "microphone-sensitivity-high" "Micrófono" "Activado"
        fi
        ;;
    # --- BRILLO ---
    bri_up)
        if ! bri set +5% >/dev/null; then
            notify-send -u critical "Brillo" "brightnessctl falló con el dispositivo: ${BL_DEV:-ninguno}"
            exit 1
        fi
        send_notification "display-brightness-high-symbolic" "Brillo" "$(get_bri)"
        ;;
    bri_down)
        if ! bri set 5%- >/dev/null; then
            notify-send -u critical "Brillo" "brightnessctl falló con el dispositivo: ${BL_DEV:-ninguno}"
            exit 1
        fi
        send_notification "display-brightness-low-symbolic" "Brillo" "$(get_bri)"
        ;;
esac