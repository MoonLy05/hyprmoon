#!/usr/bin/env bash

# ===== 1. CONFIGURACIÓN =====
# variables: el helper de AUR, la ruta del log, la ruta de reload.sh
LOG_DIR="$HOME/.local/state/aur_updates"
LOG_FILE="$LOG_DIR/$(date +'%Y-%m-%d_%H-%M-%S').log"
mkdir -p "$LOG_DIR"
AUR_HELPER="yay"
LOG_FILE="$HOME/.local/state/aur.log"
RELOAD_SCRIPT="$HOME/.config/hypr/scripts/reload.sh"

# ===== 2. FUNCIONES =====
# show_banner()   → el banner ASCII

show_banner() {
    echo -e '\033[1;32m'
    echo '  ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗'
    echo '  ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║'
    echo '  ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║'
    echo '  ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║'
    echo '  ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║'
    echo '  ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝'
    echo '          UNATTENDED SYSTEM UPDATE PROTOCOL'
    echo -e '\033[0m'
}

# count_updates() → el modo recuento

count_updates() {
    local OFFICIAL=$(checkupdates 2> /dev/null | wc -l)
    local AUR=$($AUR_HELPER -Qua 2> /dev/null | wc -l)
    local TOTAL=$((OFFICIAL + AUR))
    
    if [ "$TOTAL" -eq "0" ]; then
        echo "{\"text\": \"\", \"tooltip\": \"Sistema actualizado\", \"class\": \"uptodate\"}"
    else
        local TEXT="📦 $TOTAL"
        local TOOLTIP="Paquetes Pendientes:\n Oficiales: $OFFICIAL\n AUR: $AUR"

        local CLASS
    
        if [ "$TOTAL" -gt 20 ]; then
            CLASS="critical"
        else
            CLASS="pending"
        fi
    
        echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\", \"class\": \"$CLASS\"}"
    fi
}

# print_counts → imprime "OFICIALES AUR" para Quickshell
print_counts() {
    local OFFICIAL=$(checkupdates 2> /dev/null | wc -l)
    local AUR=$($AUR_HELPER -Qua 2> /dev/null | wc -l)
    echo "$OFFICIAL $AUR"
}

# run_update()    → el modo run (los pasos de la actualización)

run_update() {
    set -o pipefail                       # que la tubería falle si yay falla

    show_banner

    local OLD_LOGS
    OLD_LOGS=$(find "$LOG_DIR" -name "*.log" -mtime +30 | wc -l)    # 1. contar
    
    if [ "$OLD_LOGS" -gt 0 ]; then                                    # 2. ¿hay alguno?
        read -p "Hay $OLD_LOGS logs de más de 30 días. ¿Borrarlos? [s/N] " RESP   # 3. preguntar
        if [ "${RESP,,}" = "s" ]; then
            find "$LOG_DIR" -name "*.log" -mtime +30 -exec rm -f {} \;   # 4. borrar
        fi
    fi

    echo '🔑 Requiere autorización de administrador:'

    if sudo -v && $AUR_HELPER -Syu --noconfirm --sudoloop 2>&1 | tee "$LOG_FILE"; then
        echo -e '\n\033[1;32m✔ SISTEMA ACTUALIZADO CORRECTAMENTE\033[0m'
    else
        echo -e '\n\033[1;31m✘ LA ACTUALIZACIÓN FALLÓ\033[0m'
        notify-send -u critical  -i dialog-error "ERROR DE ACTUALIZACION" "Abriendo log en: '$LOG_FILE'"
        xdg-open "$LOG_FILE"
    fi

    "$RELOAD_SCRIPT"
    read -p "Presiona Enter para cerrar..."
}

# ===== 3. QUÉ MODO SE EJECUTA =====
# un case con $1: update, run, y el caso por defecto 
case "$1" in
    update)
        kitty --class update_float --title "System Update" "$0" run
        ;;
    count)
        print_counts
        ;;
    run)
        run_update
        ;;
    *)
        count_updates
        ;;
esac