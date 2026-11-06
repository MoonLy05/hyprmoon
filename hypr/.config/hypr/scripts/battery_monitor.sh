#!/usr/bin/env bash

# ===== 1. CONFIGURACIÓN =====
BAT=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)
BAT_DIR="/sys/class/power_supply/$BAT"
UMBRAL_BAJO=20
UMBRAL_CRITICO=10
INTERVALO=60
GAMEMODE_FILE="/tmp/hypr_gamemode_active"
RELOAD_SCRIPT="$HOME/.config/hypr/scripts/reload.sh"

# ===== 2. ESTADO =====
# 0 = sin avisos, 1 = ya avisé el 20%, 2 = ya avisé el crítico
NIVEL=0

# ===== 3. FUNCIONES =====
# avisar TÍTULO MENSAJE URGENCIA ÍCONO
avisar() {
    local titulo="$1"
    local mensaje="$2"
    local urgencia="$3"
    local icono="$4"
    notify-send -u "$urgencia" -i "$icono" "$titulo" "$mensaje"
}

ahorrar_energia() {
    powerprofilesctl set power-saver
    hyprctl eval 'hl.config({
        decoration = { shadow = { enabled = false }, blur = { enabled = false }, rounding = 0, inactive_opacity = 1, },
        animations = { enabled = false },
        general = { gaps_in = 0, gaps_out = 0, border_size = 0 },
    })'
}

restaurar_energia() {
    if [ -f "$GAMEMODE_FILE" ]; then
        powerprofilesctl set performance
    else
        powerprofilesctl set balanced
        "$RELOAD_SCRIPT"
    fi
}

# ===== 4. CICLO =====
while true; do
    CAPACIDAD=$(cat "$BAT_DIR/capacity")
    ESTADO=$(cat "$BAT_DIR/status")

    # Caso 1: no se está descargando, o hay batería de sobra → todo bien
    if [ "$ESTADO" != "Discharging" ] || [ "$CAPACIDAD" -gt "$UMBRAL_BAJO" ]; then
        if [ "$NIVEL" -gt 0 ]; then
            restaurar_energia
            NIVEL=0
        fi

    # Caso 2: crítico (va primero porque es el más grave)
    elif [ "$CAPACIDAD" -le "$UMBRAL_CRITICO" ] && [ "$NIVEL" -lt 2 ]; then
        avisar "🪫 Batería crítica ($CAPACIDAD%)" "Carga la batería lo más rápido posible." critical battery-level-10-symbolic
        ahorrar_energia
        NIVEL=2

    # Caso 3: batería baja
    elif [ "$CAPACIDAD" -le "$UMBRAL_BAJO" ] && [ "$NIVEL" -lt 1 ]; then
        avisar "⚠️ Batería baja ($CAPACIDAD%)" "Ten precaución: modo de ahorro activado." normal battery-level-20-symbolic
        ahorrar_energia
        NIVEL=1
    fi

    sleep "$INTERVALO"
done