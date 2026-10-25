-- Monitor externo: principal, en 0x0
hl.monitor({ output = "desc:ASUSTek COMPUTER INC XG279CNS T7LMQV062777", mode = "1920x1080@380", position = "0x0", scale = 1.0 })

-- Laptop: secundaria, a la derecha del externo
hl.monitor({ output = "desc:China Star Optoelectronics Technology Co. Ltd MNG007QX2-1", mode = "preferred", position = "1920x0", scale = 1.2 })

-- Cualquier monitor nuevo que no tenga regla propia
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })