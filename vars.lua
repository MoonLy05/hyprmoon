local mainMod = "SUPER"

local terminal = "kitty"

local fileManager = "thunar"

local menu = "fuzzel"

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local scripts_waybar = os.getenv("HOME") .. "/.config/waybar/scripts"

local swaync = "swaync-client"

local monitor_main = "desc:China Star Optoelectronics Technology Co. Ltd MNG007QX2-1"

local monitor_expand = "desc:ASUSTek COMPUTER INC XG279CNS T7LMQV062777"

return {
    mainMod = mainMod,
    terminal = terminal,
    fileManager = fileManager,
    menu = menu,
    scripts = scripts,
    scripts_waybar = scripts_waybar,
    swaync = swaync,
    monitor_main = monitor_main,
    monitor_expand = monitor_expand,
}
