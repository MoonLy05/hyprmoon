#!/usr/bin/env bash

# --- 1. MAGIA DE MATUGEN ---
if [ -n "$1" ]; then
    matugen image "$1" --source-color-index 0
fi

# --- 2. REINICIAR WAYBAR (Versión Inmortal) ---
pkill waybar
sleep 0.5
setsid waybar > /dev/null 2>&1 &
swaync-client -rs > /dev/null 2>&1 &
hyprctl reload

# --- 3. AVISO FINAL ---
notify-send -e "Sistema Recargado" "Sistema Recargado" -i utilities-terminal