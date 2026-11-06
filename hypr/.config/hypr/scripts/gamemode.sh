#!/usr/bin/env bash

GAMEMODE_FILE="/tmp/hypr_gamemode_active"
RELOAD_SCRIPT="$HOME/.config/hypr/scripts/reload.sh"

set_cpu_mode() {
        if [ "$1" == "performance" ]; then
            powerprofilesctl set performance
        else
            powerprofilesctl set balanced
        fi
}

activar() {
    # --- ACTIVAR (Modo Juego) ---
    touch "$GAMEMODE_FILE"

    # Optimizar Hyprland (sintaxis Lua)
    hyprctl eval 'hl.config({
        decoration = { shadow = { enabled = false }, blur = { enabled = false }, rounding = 0, inactive_opacity = 1, },
        animations = { enabled = false },
        general = { gaps_in = 0, gaps_out = 0, border_size = 0 },
    })'

    if [ "$MONITOR_LAP" == "" ]; then
        notify-send -e "Monitor de laptop no configurado (environment.lua)" -i video-display
    else
        hyprctl eval "hl.monitor({ output = \"$MONITOR_LAP\", mode = \"preferred\", position = \"2920x0\", scale = 1.2 })"
    fi

    # Potencia máxima
    set_cpu_mode "performance"

    # Cerrar QuickShell
    qs kill -c moonly > /dev/null 2>&1
 
    (notify-send -e "GAMEMODE ON" "🔥 MODO JUEGO: Potencia al máximo." -i video-display; sleep 2; [ -f "$GAMEMODE_FILE" ] && swaync-client -dn) &
}

desactivar() {
    # --- DESACTIVAR (Modo Normal) ---
    rm "$GAMEMODE_FILE"

    swaync-client -df

    set_cpu_mode "balanced"

    qs kill -c moonly
    sleep 0.5
    setsid qs -c moonly 2> /dev/null 2>&1 &

    "$RELOAD_SCRIPT"
}

case "$1" in
    on)
        if [ ! -f "$GAMEMODE_FILE" ]; then
            activar
        fi
        ;;
    off)
        if [ -f "$GAMEMODE_FILE" ]; then
            desactivar
        fi
        ;;
    *)
        if [ -f "$GAMEMODE_FILE" ]; then
            desactivar
        else
            activar
        fi
        ;;
esac