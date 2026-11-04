#!/usr/bin/env bash

# 1. Función para agregar iconos a la lista
add_icons() {
    while read -r line; do
        [ -z "$line" ] && continue
        echo "📁 $line"
    done
}

# 2. Búsqueda de carpetas
LISTA_RAW=$(find ~/Documents ~/Projects ~/Downloads ~/.config -maxdepth 3 \
    \( -name ".git" -o -name ".cache" -o -name "node_modules" \) -prune \
    -o -type d -print \
    | sort | sed "s|^$HOME|~|")

# 3. Menú Principal
MENU=" Crear nuevo proyecto...\n$(echo "$LISTA_RAW" | add_icons)"

TARGET_CON_ICONO=$(echo -e "$MENU" | fuzzel -d -i -p "󰅴 Abrir Carpeta:")

# Salir si se presiona ESC
[ -z "$TARGET_CON_ICONO" ] && exit 0

TARGET_LIMPIO=$(echo "$TARGET_CON_ICONO" | cut -d' ' -f2-)
REAL_PATH="${TARGET_LIMPIO/#\~/$HOME}"

# 4. Lógica de ejecución
if [ "$TARGET_CON_ICONO" = " Crear nuevo proyecto..." ]; then
    NEW_DIR=$(fuzzel -d -i --prompt-only "📁 Nombre de carpeta:")
    if [ -n "$NEW_DIR" ]; then
        case "$NEW_DIR" in
            /*|"~"*)
                # Es una ruta: se respeta, cambiando la ~ por tu home
                REAL_NEW="${NEW_DIR/#\~/$HOME}"
                ;;
            *)
                # Es solo un nombre: va dentro de Projects
                REAL_NEW="$HOME/Projects/$NEW_DIR"
                ;;
        esac
        mkdir -p "$REAL_NEW"
        zed -n "$REAL_NEW"
    fi
else
    # Verificamos si la ruta limpia existe antes de abrir
    if [ -e "$REAL_PATH" ]; then
        # Enviamos notificación para saber que sí detectó el click
        notify-send "IDE ZED" "Abriendo: $TARGET_LIMPIO" -i zed -t 1500
        zed -n "$REAL_PATH"
    else
        notify-send -u critical "Error" "No se encontró: $TARGET_LIMPIO" -i error
    fi
fi