---@module 'hl'

local function modo_dgpu()
    local f = io.open("/sys/class/backlight/intel_backlight/brightness")
    if f then
        f:close()
        return false
    end
    return true
end

if modo_dgpu() then
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("GBM_BACKEND", "nvidia-drm")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
end

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

-- --- NVIDIA (solo con MUX en dGPU) ---
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")