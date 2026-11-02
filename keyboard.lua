---@module 'hl'

hl.config({
    input = {
        kb_layout = "latam,us",
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

