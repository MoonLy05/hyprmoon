local vars = require("vars")

-- Monitor externo: principal, en 0x0
hl.monitor({ output = vars.monitor_expand, mode = "1920x1080@380", position = "0x0", scale = 1.0 })

-- Laptop: secundaria, a la derecha del externo
hl.monitor({ output = vars.monitor_main, mode = "preferred", position = "1920x0", scale = 1.2 })

-- Cualquier monitor nuevo que no tenga regla propia
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })