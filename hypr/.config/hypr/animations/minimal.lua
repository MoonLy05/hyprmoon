---@module 'hl'
-- =============================================================================
--  PRESET: minimal — "Reducir movimiento" / clean y rápido
--  Casi todo es fade corto; nada se desplaza de más. Bueno para batería
--  y para cuando quieres que todo se sienta instantáneo.
-- =============================================================================

hl.config({ animations = { enabled = true } })

hl.curve("clean",     { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("clean_out", { type = "bezier", points = { { 0.4, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windowsIn",   enabled = true,  speed = 3, bezier = "clean",     style = "popin 95%" })
hl.animation({ leaf = "windowsOut",  enabled = true,  speed = 2, bezier = "clean_out", style = "popin 95%" })
hl.animation({ leaf = "windowsMove", enabled = true,  speed = 3, bezier = "clean",     style = "slide" })
hl.animation({ leaf = "fadeIn",      enabled = true,  speed = 2, bezier = "clean" })
hl.animation({ leaf = "fadeOut",     enabled = true,  speed = 2, bezier = "clean_out" })
hl.animation({ leaf = "fadeSwitch",  enabled = false, speed = 1, bezier = "clean" })
hl.animation({ leaf = "layersIn",    enabled = true,  speed = 2, bezier = "clean",     style = "fade" })
hl.animation({ leaf = "layersOut",   enabled = true,  speed = 2, bezier = "clean_out", style = "fade" })
hl.animation({ leaf = "workspaces",  enabled = true,  speed = 3, bezier = "clean",     style = "fade" })
