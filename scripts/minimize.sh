#!/usr/bin/env bash

# Nombre del espacio especial
WORKSPACE="special:minimized"

dispatch() {
    hyprctl dispatch "$1" >/dev/null
}

if [ "$1" == "hide" ]; then
    dispatch "hl.dsp.window.move({ workspace = \"$WORKSPACE\", follow = false })"

elif [ "$1" == "restore" ]; then
    # 1. Pedir las ventanas minimizadas UNA sola vez (para que las listas coincidan)
    JSON=$(hyprctl clients -j | jq "[.[] | select(.workspace.name == \"$WORKSPACE\")]")

    # 2. Tres listas en el mismo orden
    mapfile -t ADDRS   < <(echo "$JSON" | jq -r '.[].address')
    mapfile -t CLASSES < <(echo "$JSON" | jq -r '.[].class')
    mapfile -t TITLES  < <(echo "$JSON" | jq -r '.[].title')

    # Si no hay ventanas, salir
    if [ ${#ADDRS[@]} -eq 0 ]; then
        notify-send -u low "Bolsillo Vacío" "No hay apps minimizadas"
        exit 0
    fi

    # 3. Menú: solo "Clase: Título" + su icono. --index regresa la posición elegida
    CHOICE=$(for i in "${!ADDRS[@]}"; do
        printf '%s: %s\0icon\x1f%s\n' "${CLASSES[$i]}" "${TITLES[$i]}" "${CLASSES[$i],,}"
    done | fuzzel -d -i --index -p "📦 Restaurar ")

    # 4. Con la posición, sacar la dirección de la lista escondida
    if [ -n "$CHOICE" ]; then
        ADDR="${ADDRS[$CHOICE]}"
        CUR=$(hyprctl activeworkspace -j | jq -r '.id')

        dispatch "hl.dsp.window.move({ workspace = $CUR, window = \"address:$ADDR\" })"
        dispatch "hl.dsp.focus({ window = \"address:$ADDR\" })"
    fi
fi