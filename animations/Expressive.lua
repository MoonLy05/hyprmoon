---@module 'hl'
-- =============================================================================
--  PRESET: expressive — Material 3 Expressive (Android 16)
--  Resortes (springs) en vez de curvas: las ventanas "caen" en su lugar con un
--  rebote sutil, y los workspaces se deslizan en vertical (de arriba hacia abajo).
--
--  Cómo ajustar el rebote de un spring:
--    damping = ratio * 2 * sqrt(stiffness * mass)
--    ratio 1.0 = sin rebote | 0.8 = rebote sutil | 0.6 = rebote notorio
--  Más stiffness = más rápido y más "firme".
-- =============================================================================

hl.config({ animations = { enabled = true } })

-- Springs
hl.curve("m3e_spatial", { type = "spring", mass = 1, stiffness = 300, damping = 27.7 }) -- ratio 0.8
hl.curve("m3e_bouncy",  { type = "spring", mass = 1, stiffness = 300, damping = 20.8 }) -- ratio 0.6
hl.curve("m3e_effects", { type = "spring", mass = 1, stiffness = 400, damping = 40 })   -- ratio 1.0

-- Beziers (salidas y fades: ahí un rebote se ve raro)
hl.curve("m3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("m3_accel", { type = "bezier", points = { { 0.3, 0 },   { 0.8, 0.15 } } })

-- Ventanas
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4, spring = "m3e_bouncy",  style = "popin 85%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2, bezier = "m3_accel",    style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, spring = "m3e_spatial", style = "slide" })

-- Bordes y fades
hl.animation({ leaf = "border",      enabled = true,  speed = 4, bezier = "m3_decel" })
hl.animation({ leaf = "fadeIn",      enabled = true,  speed = 3, bezier = "m3_decel" })
hl.animation({ leaf = "fadeOut",     enabled = true,  speed = 2, bezier = "m3_accel" })
hl.animation({ leaf = "fadeSwitch",  enabled = false, speed = 1, bezier = "m3_decel" })

-- Capas (waybar, notificaciones, menús)
-- "slide" sin dirección: cada capa entra desde su borde más cercano
-- (la waybar de arriba baja desde arriba, la de la izquierda entra desde la izquierda)
hl.animation({ leaf = "layersIn",    enabled = true, speed = 3, spring = "m3e_effects", style = "slide" })
hl.animation({ leaf = "layersOut",   enabled = true, speed = 2, bezier = "m3_accel",    style = "slide" })

-- Workspaces: vertical, acorde a la waybar lateral con los workspaces apilados
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, spring = "m3e_spatial", style = "slidefadevert 15%" })