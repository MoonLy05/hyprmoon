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

    hyprctl eval 'hl.monitor({ output = "desc:China Star Optoelectronics Technology Co. Ltd MNG007QX2-1", mode = "preferred", position = "2920x0", scale = 1.2 })'

    # Potencia máxima
    set_cpu_mode "performance"

    # Matar la barra
    killall waybar

    (notify-send -e "GAMEMODE ON" "🔥 MODO JUEGO: Potencia al máximo." -i video-display; sleep 2; swaync-client -dn)&
}

desactivar() {
    # --- DESACTIVAR (Modo Normal) ---
    rm "$GAMEMODE_FILE"

    swaync-client -df

    set_cpu_mode "balanced"

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