---@module 'hl'
-- =============================================================================
--  PRESET: md3 — Material Design 3 clásico (Pixel, Android 12-15)
--  Tu configuración actual: curvas bezier, sin rebote, workspaces verticales.
-- =============================================================================

hl.config({ animations = { enabled = true } })

hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 },   { 0, 1 } } })
hl.curve("md3_decel",    { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel",    { type = "bezier", points = { { 0.3, 0 },   { 0.8, 0.15 } } })

hl.animation({ leaf = "windowsIn",   enabled = true,  speed = 4, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut",  enabled = true,  speed = 3, bezier = "md3_accel", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true,  speed = 4, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "fadeIn",      enabled = true,  speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "fadeOut",     enabled = true,  speed = 3, bezier = "md3_accel" })
hl.animation({ leaf = "fadeSwitch",  enabled = false, speed = 1, bezier = "md3_decel" })
hl.animation({ leaf = "fadeShadow",  enabled = true,  speed = 4, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces",  enabled = true,  speed = 5, bezier = "md3_decel", style = "slidevert" })
