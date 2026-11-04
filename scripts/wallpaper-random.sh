#!/usr/bin/env bash

# --- CONFIGURACIÓN ---
# ⚠️ Asegúrate de que esta carpeta exista y tenga imágenes
WALLPAPER_FILE="/tmp/wallpaper_previous"
DIR="$HOME/wallpapers" 
FPS=60
STEP=90

# En modo juego: No cambiar wallpaper
if [ -f /tmp/hypr_gamemode_active ]; then
    swaync-client -df
    notify-send -e "Aviso" "No puedes cambiar de wallpaper en modo juego"
    sleep 3
    # Si el juego se cerró durante la espera, no reactivar "no molestar"
    [ -f /tmp/hypr_gamemode_active ] && swaync-client -dn
    exit 0
fi


# 1. Seleccionar imagen al azar
# (Usamos nullglob para evitar errores si no hay gifs, etc)
shopt -s nullglob
PICS=($DIR/*.jpg $DIR/*.png $DIR/*.jpeg $DIR/*.gif)

if [ ${#PICS[@]} -eq 0 ]; then
    notify-send -e "Wallpaper AWWW" "No hay imagenes en carpeta ('$DIR')"
    exit 1
fi

LAST_WALLPAPER=$(cat "$WALLPAPER_FILE" 2>/dev/null)

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

while [ "$RANDOMPICS" == "$LAST_WALLPAPER" ] && [ ${#PICS[@]} -gt 1 ] ; do
    echo "La imagen es la misma"
    RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}
done

echo "$RANDOMPICS" > "$WALLPAPER_FILE"

# 2. Definir transiciones
TRANSITIONS=("grow" "outer" "wave" "wipe" "any")
SELECTED_TRANSITION=${TRANSITIONS[ $RANDOM % ${#TRANSITIONS[@]} ]}

echo "Imagen: $RANDOMPICS | Efecto: $SELECTED_TRANSITION"

# 3. Posición y Ángulo Random
POS_X="0.$((RANDOM % 9 + 1))"
POS_Y="0.$((RANDOM % 9 + 1))"
ANGLE=$((RANDOM % 360))

# 4. EJECUTAR AWWW (Cambio visual)
awww img "$RANDOMPICS" \
    --transition-type "$SELECTED_TRANSITION" \
    --transition-pos "$POS_X,$POS_Y" \
    --transition-angle "$ANGLE" \
    --transition-fps $FPS \
    --transition-step $STEP \
    --transition-bezier 0.65,0,0.35,1 


# 5. Colores y recarga: reload.sh se encarga de matugen, Hyprland, Waybar y swaync
"$HOME/.config/hypr/scripts/reload.sh" "$RANDOMPICS"