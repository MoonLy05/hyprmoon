---@module 'hl'

local table_games = require("games")

-- ══════════════════════════════════════════
--  TABLAS (agrega o quita apps aquí)
-- ══════════════════════════════════════════

-- Ventanas flotantes y centradas (size es opcional)
local table_float = {
    -- Sistema
    { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    { class = "^(nwg-look)$" },
    { class = "^(org.pulseaudio.pavucontrol)$", size = { 1000, "(monitor_h*0.6)" } },
    { class = "^(blueman-manager)$",            size = { 1000, 800 } },
    { class = "^(xdg-desktop-portal-gtk)$",                   size = { "(monitor_w*0.6)", "(monitor_h*0.8)" } },
    { class = "^(waypaper)$", title = "^(Waypaper)$",    size = { "(monitor_w*0.5)", "(monitor_h*0.8)" } },

    -- Terminales flotantes
    { class = "^(kitty_float)$",  size = { "(monitor_w*0.5)", "(monitor_h*0.55)" } },
    { class = "^(update_float)$",                             size = { 1200, 800 } },
    { class = "^(yazi_float)$", size = { 1000, 800}},

    -- Apps
    { class = "^(com.shellyorg.shelly)$", size = { "(monitor_w*0.6)", "(monitor_h*0.8)" } },
    { class = "^(brave-browser)$", title = "(Inicia sesión: Cuentas de Google - Brave)", size = { 600, 400 } },
    { class = "^(brave-browser)$", title = "(Sign in to Your Epic Games account | Epic Games - Brave)", size = { 600, 400 } },
    { class = "^(lunarclient)$",                              title = "(Mission Control - Lunar Client)",                          size = { 600, 400 } },

    -- Steam: todas sus ventanas flotan (la principal se tilea en table_noFloat)
    { class = "^(steam)$" },
    { title = "^(Friends List)$", size = { "(monitor_w*0.2)", "(monitor_h*0.7)" } },
}

-- Ventanas que deben quedar tileadas aunque otra regla las haga flotar
local table_noFloat = {
    { class = "^(steam)$", title = "^(Steam)$" },
}

-- ══════════════════════════════════════════
--  FUNCIONES
-- ══════════════════════════════════════════

local function flotante(class, title, size)
    hl.window_rule({
        match = { class = class, title = title },
        float = true,
        center = true,
        size = size,
    })
end

local function no_flotante(class, title)
    hl.window_rule({
        match = { class = class, title = title },
        tile = true,
    })
end

local function gamemode(class, title)
    hl.window_rule({
        match = { class = class, title = title },
        immediate = true,
        fullscreen = true,
    })
end

-- ══════════════════════════════════════════
--  APLICAR (el orden importa: no_flotante va después de flotante)
-- ══════════════════════════════════════════

for _, game in ipairs(table_games) do
    gamemode(game.class, game.title)
end

for _, app in ipairs(table_float) do
    flotante(app.class, app.title, app.size)
end

for _, app in ipairs(table_noFloat) do
    no_flotante(app.class, app.title)
end

-- ══════════════════════════════════════════
--  REGLAS GENERALES
-- ══════════════════════════════════════════

-- Que ninguna app se maximice sola
hl.window_rule({
    name  = "ignore-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Puente para compartir pantalla en apps X11 (ventana invisible)
hl.window_rule({
    name  = "xwayland-video-bridge-fixes",
    match = { class = "^(xwaylandvideobridge)$" },
    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = { 1, 1 },
    opacity = 0.0,
})