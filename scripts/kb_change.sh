#!/bin/bash

# 1. Cambiar al siguiente idioma de la lista
hyprctl switchxkblayout all next

# 2. Preguntar cuál quedó activo
LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# 3. Avisar
notify-send -e "⌨️ Teclado" "Cambiado a: $LAYOUT"