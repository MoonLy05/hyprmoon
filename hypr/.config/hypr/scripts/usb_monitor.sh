#!/usr/bin/env bash

# ===== 1. CONFIGURACIÓN =====
# el ícono de las notificaciones
ICON="drive-removable-media-usb"


# ===== 2. MEMORIA =====
# dónde recordar qué nombre tiene cada puerto
declare -A NOMBRES                          # crear el arreglo asociativo

# ===== 3. FUNCIONES =====
avisar() {
    local titulo="$1"
    local nombre="$2"
    local urgencia="$3"
    notify-send -e -u "$urgencia" -i "$ICON" "$titulo" "${nombre//_/ }"
}

# ===== 4. ESCUCHAR EVENTOS =====
# el udevadm | while read ... con el case adentro
udevadm monitor --udev --subsystem-match=usb/usb_device --property | while IFS= read -r line; do
    case "$line" in
        ACTION=*)
            ACTION="${line#ACTION=}"
            ;;
        DEVPATH=*)
            DEVPATH="${line#DEVPATH=}"
            ;;
        ID_MODEL=*)
            MODEL="${line#ID_MODEL=}"
            ;;
        "")
            case "$ACTION" in
                add)
                    NOMBRES["$DEVPATH"]="$MODEL"
                    avisar "Dispositivo conectado" "$MODEL" normal
                    ;;
                    remove)
                    avisar "Dispositivo desconectado" "${NOMBRES["$DEVPATH"]:-Dispositivo USB}" low
                    unset 'NOMBRES[$DEVPATH]'
                    ;;
            esac
            ACTION=""; DEVPATH=""; MODEL=""
            ;;
    esac
done