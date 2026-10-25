---@module 'hl'

-- Config de entorno para MUX en modo HÍBRIDO (Intel mueve el panel, NVIDIA dormida).
-- Si regresas la MUX a dGPU, descomenta el bloque NVIDIA de abajo.

-- --- XDG ---
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- --- TOOLKIT BACKENDS ---
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("CLUTTER_BACKEND", "wayland")
-- hl.env("SDL_VIDEODRIVER", "wayland,x11")

-- --- CURSOR ---
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- --- APPS ---
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- --- GPU ---
-- Solo si Hyprland no elige la Intel por su cuenta.
-- Busca cuál cardN es pci-0000:00:02.0 con: ls -l /dev/dri/by-path/
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card0") -- Intel primero, NVIDIA después

-- --- NVIDIA (solo con MUX en dGPU) ---
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- --- NUNCA ACTIVAR ---
-- AQ_NO_MODIFIERS=1
-- NVD_BACKEND=direct
-- __NV_DISABLE_EXPLICIT_SYNC=1