local mainMod = "SUPER"

local terminal = "kitty"

local fileManager = "thunar"

local menu = "fuzzel"

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local scripts_waybar = os.getenv("HOME") .. "/.config/waybar/scripts"

local swaync= "swaync-client"

return {
    mainMod = mainMod,
    terminal = terminal,
    fileManager = fileManager,
    menu = menu,
    scripts = scripts,
    scripts_waybar = scripts_waybar,
    swaync = swaync
}