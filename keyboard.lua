---@module 'hl'

hl.config({
    input = {
        -- Agregamos us (inglés) junto a latam
        kb_layout = "latam, us",
        -- OPCIONAL: Si tu teclado en inglés tiene variantes (como intl) ponlo así:
        -- kb_variant = ,intl
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.4,
            clickfinger_behavior = true,
            disable_while_typing = true,
            tap_to_click = true,
        },
        sensitivity = 0,
    },
})

hl.device({
  name = "wacom-co.-ltd.-wacom-intuos-pro-s",
  enabled = false,
})

