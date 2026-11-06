local mainMod = "SUPER"

local terminal = "kitty"

local fileManager = "thunar"

local menu = "fuzzel"

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local scripts_quickshell = os.getenv("HOME") .. "/.config/quickshell/moonly/scripts"

local swaync = "swaync-client"

local monitor_main = "desc:China Star Optoelectronics Technology Co. Ltd MNG007QX2-1"

local monitor_expand = "desc:ASUSTek COMPUTER INC XG279CNS T7LMQV062777"

return {
    mainMod = mainMod,
    terminal = terminal,
    fileManager = fileManager,
    menu = menu,
    scripts = scripts,
    scripts_quickshell = scripts_quickshell,
    swaync = swaync,
    monitor_main = monitor_main,
    monitor_expand = monitor_expand,
}
