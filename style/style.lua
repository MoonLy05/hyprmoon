---@module 'hl'

-- =============================================================================
--  STYLE — Hyprland 0.56 (Lua) 
-- =============================================================================
-- Colores de matugen (plantilla: ~/.config/matugen/templates/hyprland-colors.lua)
-- Si el archivo falta o está roto, usa los colores de respaldo

local matugen_path = os.getenv("HOME") .. "/.config/hypr/style/colors-matugen.lua"
local ok, matugen = pcall(dofile, matugen_path)
if not ok or type(matugen) ~= "table" then
    matugen = {
        inactive = "rgb(1e1e2e)",   
        primary = "rgb(89b4fa)",
        secondary = "rgb(94e2d5)",
    }
end

-- =============================================================================
--  GENERAL
-- =============================================================================
hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 3,
        border_size = 3,
        col = {
            active_border   = { colors = { matugen.primary, matugen.secondary }, angle = 45 },
            inactive_border = matugen.inactive,
        },
        layout = "master",
        allow_tearing = true, -- solo aplica a ventanas con la regla immediate
        snap = {
            enabled = true,
            window_gap = 10,
            monitor_gap = 10,
            border_overlap = true,
        },
    },
})

-- =============================================================================
--  DECORATION
-- =============================================================================
hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2.0, -- 2.0 = circular clásico, >2 = más squircle
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            vibrancy = 0.1696,
        },
        shadow = {
            enabled = false,
        },
    },
})

-- =============================================================================
--  ANIMATIONS — presets en ~/.config/hypr/animations/
--    "md3"        Material 3 clásico (Pixel, lo que tenías)
--    "expressive" Material 3 Expressive (Android 16): springs con rebote sutil
--    "minimal"    Reducir movimiento: fades rápidos y limpios
--  Cambia el nombre y haz: hyprctl reload
-- =============================================================================
local ANIM_PRESET = "minimal"

local anim_path = os.getenv("HOME") .. "/.config/hypr/animations/" .. ANIM_PRESET .. ".lua"
local anim_ok, anim_err = pcall(dofile, anim_path)
if not anim_ok then
    -- Si el preset tiene un error, al menos quedan animaciones por defecto
    hl.config({ animations = { enabled = true } })
    print("Preset de animación falló: " .. tostring(anim_err))
end

-- =============================================================================
--  MISC
-- =============================================================================
hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        disable_hyprland_guiutils_check = true,
    },
})

-- =============================================================================
--  XWAYLAND
-- =============================================================================
hl.config({
    xwayland = {
        force_zero_scaling = true, -- evita apps XWayland borrosas por el escalado
    },
})

-- =============================================================================
--  Layout master
-- =============================================================================
hl.config({
    master = {
        mfact = 0.65,
        orientation = "left"
    },
})