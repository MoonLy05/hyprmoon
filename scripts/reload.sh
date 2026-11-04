#!/usr/bin/env bash

# --- 0. CANDADO: solo una copia a la vez ---
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/reload.lock"
flock -w 30 9 || exit 1

# Sin imagen y en modo juego: no deshacer sus optimizaciones
# (va antes del debounce: si no, guardaría la hora sin haber recargado
# y el "gamemode.sh off" que llegue justo después se ignoraría)
if [ -z "$1" ] && [ -f /tmp/hypr_gamemode_active ]; then
    exit 0
fi

# --- DEBOUNCE ---
RELOAD_FILE="${XDG_RUNTIME_DIR:-/tmp}/reload.last"
NOW=$(date +%s)                              # la hora actual en segundos
LAST=$(cat "$RELOAD_FILE" 2>/dev/null)       # la última recarga guardada

if [ -z "$1" ] && [ $(( NOW - ${LAST:-0} )) -lt 5 ]; then
    exit 0
fi

echo "$NOW" > "$RELOAD_FILE"                 # guardar la hora de esta recarga

# --- 1. COLORES Y RECARGA ---
if [ -n "$1" ]; then
    # Con imagen: matugen genera los colores y sus hooks recargan Hyprland y swaync
    if ! matugen image "$1" --source-color-index 0; then
        notify-send -e "Error de recarga" "matugen falló con: $1" -i dialog-error
        exit 1
    fi
else
    # Sin imagen: nadie más va a recargar, lo hacemos aquí
    hyprctl reload
    swaync-client -rs > /dev/null 2>&1
fi

# --- 2. WAYBAR (en los dos casos) ---
pkill -x waybar
sleep 0.5
setsid waybar 9>&- > /dev/null 2>&1 &

# --- 3. AVISO FINAL ---
notify-send -e "Sistema Recargado" -i utilities-terminal
