#!/usr/bin/env bash

# --- CONFIGURACIÓN ---
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
NAME="$(date +'%Y-%m-%d_%H-%M-%S.png')"
FILE="$DIR/$NAME"

if ! command -v hyprshot >/dev/null 2>&1; then
    notify-send -e "Error" "hyprshot no está instalado"
    exit 1
fi

if ! command -v grim >/dev/null 2>&1; then
    notify-send -e "Error" "grim no está instalado"
    exit 1
fi

# Iconos y Textos
opt_full="  Pantalla Completa"
opt_area="  Seleccionar Área"
opt_win="  Ventana Activa"
opt_delay="  Temporizador (3s)"

# Menú después de capturar (Esc = solo portapapeles)
opt_pinta="Abrir en Pinta"
opt_clip="Solo portapapeles"

# true  = guarda el archivo aunque no abras Pinta
# false = si no abres Pinta, la captura solo queda en el portapapeles
KEEP_FILE=false

chosen=$(echo -e "$opt_full\n$opt_area\n$opt_win\n$opt_delay" | fuzzel --dmenu -p  "📸 Captura " -w 30 -l 4)

# Si cancelas, salimos
if [ -z "$chosen" ]; then
    exit 0
fi

# --- FUNCIONES ---
notify_cmd() {
    notify-send -h string:x-canonical-private-synchronous:shot-notify \
        -e -i "camera-photo-symbolic" "$1" "$2"
}

set_anims() {
    command -v hyprctl >/dev/null 2>&1 || return 0
    hyprctl eval "hl.config({ animations = { enabled = $1 } })" >/dev/null 2>&1
}

countdown() {
    for i in 3 2 1; do
        notify_cmd "Captura en $i..." "Prepara la pose"
        sleep 1
    done
    notify_cmd "Sonrían..." " "
    sleep 1
}

open_in_pinta() {
    if command -v pinta >/dev/null 2>&1; then
        nohup pinta "$FILE" >/dev/null 2>&1 &
    else
        notify-send -u normal "Pinta no encontrado" "Instala pinta para editar la captura automáticamente"
    fi
}

ask_pinta() {
    local ans
    ans=$(printf '%s\n%s\n' "$opt_pinta" "$opt_clip" | fuzzel --dmenu -p "🖼️ Captura lista " -w 30 -l 2)
    [ "$ans" = "$opt_pinta" ]
}

capture_success() {
    wl-copy --type image/png < "$FILE" 

    if ask_pinta; then
        open_in_pinta
        notify-send -i "$FILE" "Captura guardada" "Abierta en Pinta: $FILE"
    elif [ "$KEEP_FILE" = true ]; then
        notify-send -i "$FILE" "Captura copiada" "También guardada en $FILE"
    else
        notify-send -i "edit-copy" "Captura copiada" "Lista para pegar"
        rm -f "$FILE"
    fi
}

take_shot() {
    set_anims false
    hyprshot -o "$DIR" -f "$NAME" -s "$@"
    local rc=$?
    set_anims true

    if [ "$rc" -eq 0 ]; then
        capture_success
    fi
    return "$rc"
}

take_full() {
    # grim como método principal para captura completa
    set_anims false
    if grim "$FILE"; then
        set_anims true
        capture_success
        return 0
    fi
    set_anims true

    # Fallback a hyprshot si grim falla
    if take_shot -m active -m output || take_shot -m output; then
        return 0
    fi

    notify-send -u critical "Captura fallida" "No se pudo capturar pantalla completa"
    return 1
}

take_window_active() {
    if take_shot -m window -m active || take_shot -m active -m window; then
        return 0
    fi

    if command -v jq >/dev/null 2>&1; then
        local geom
        geom=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        if [ -n "$geom" ] && [ "$geom" != "null,null nullxnull" ]; then
            if grim -g "$geom" "$FILE"; then
                capture_success
                return 0
            fi
        fi
    fi

    notify-send -u critical "Captura fallida" "No se pudo capturar la ventana activa"
    return 1
}

# --- LÓGICA ---
case $chosen in
    "$opt_full")
        sleep 0.6 
        take_full
        ;;
    "$opt_area")
        sleep 0.6 
        take_shot -m region -z || notify-send -u critical "Captura fallida" "No se pudo capturar el área"
        ;;
    "$opt_win")
        sleep 0.6
        take_window_active
        ;;
    "$opt_delay")
        countdown
        take_full
        ;;
esac