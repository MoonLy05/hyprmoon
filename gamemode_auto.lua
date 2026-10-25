---@module 'hl'

local table_games = require("games")
local vars = require("vars")

-- ¿Esta ventana es uno de mis juegos?
local function es_juego(w)
    for _, game in ipairs(table_games) do
        if string.match(w.class, game.class) then
            return true -- Regresamos verdadero
        end
    end
return false
end

-- Avisar si abrio una ventana

hl.on("window.open", function(w)
    if es_juego(w) then
        hl.exec_cmd(vars.scripts .. "/gamemode.sh on")
    end
end)

-- ¿Queda algún juego abierto, sin contar el que se está cerrando?
local function queda_otro_juego(cerrada)
    for _, otra in ipairs(hl.get_windows()) do
        -- si "otra" NO es la misma que "cerrada" Y "otra" es un juego...
        if otra.address ~= cerrada.address and es_juego(otra) then
            return true
        end
    end
    return false
end

-- Avisar cuando cerro la ventana

hl.on("window.close", function(w)
    if es_juego(w) and not queda_otro_juego(w) then
        hl.exec_cmd(vars.scripts .. "/gamemode.sh off")
    end
end)