local vars = require("vars")
---@module 'hl'

--  KEYBINDINGS

-- -- SYSTEM ---

hl.bind(vars.mainMod .. " + SHIFT+ R", hl.dsp.exec_cmd(vars.scripts .. "/reload.sh"))

hl.bind(vars.mainMod .. " + X", hl.dsp.exec_cmd("wlogout"))

hl.bind(vars.mainMod .. " + W", hl.dsp.exec_cmd("waypaper", { float = true, center = true, size = {800, 600} } ))

hl.bind(vars.mainMod .. " + ALT + W", hl.dsp.exec_cmd(vars.scripts .. "/wallpaper-random.sh"))

hl.bind(vars.mainMod .. " + D", hl.dsp.exec_cmd(vars.menu))

hl.bind("ALT + Tab", hl.dsp.exec_cmd(vars.scripts .. "/window_switcher.sh"))

hl.bind(vars.mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | " .. vars.menu .. " --dmenu -p ' Portapapeles > ' -w 50 | cliphist decode | wl-copy"))

hl.bind(vars.mainMod .. " + SHIFT + V",
    hl.dsp.exec_cmd(
    "rm -f ~/.cache/cliphist/db && notify-send \"Portapapeles\" \"Base de datos reiniciada (Contador a 0)\" -i edit-delete"))

hl.bind(vars.mainMod .. " + G", hl.dsp.exec_cmd(vars.scripts .. "/gamemode.sh on"))

hl.bind(vars.mainMod .. " + ALT + G", hl.dsp.exec_cmd(vars.scripts .. "/gamemode.sh off"))


hl.bind(vars.mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(vars.scripts .. "/screenshot_gui.sh"))

hl.bind("Print", hl.dsp.exec_cmd(vars.scripts .. "/screenshot_gui.sh"))

hl.bind("CONTROL + U", hl.dsp.exec_cmd(vars.scripts_waybar .. "/updates.sh update"))

hl.bind(vars.mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(vars.scripts .. "/lock.sh"))

hl.bind(vars.mainMod .. " + N", hl.dsp.window.move({ workspace = "special:minimized", follow = false }))

hl.bind(vars.mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(vars.scripts .. "/minimize.sh restore"))

hl.bind(vars.mainMod .. " + P", hl.dsp.exec_cmd("grim ~/captura_lock.png && notify-send \"Captura de pantalla\" \"Guardada como captura_lock.png\" -i image-missing"), { locked = true })

hl.bind(vars.mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("blueman-manager"))

hl.bind(vars.mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.scripts .. "/kb_change.sh"))

hl.bind(vars.mainMod .. " + A", hl.dsp.exec_cmd(vars.swaync .. " -t"))

-- --- APPS ---

hl.bind(vars.mainMod .. " + Return", hl.dsp.exec_cmd(vars.terminal))

hl.bind(vars.mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(vars.terminal ..  " --class kitty_float"))

hl.bind(vars.mainMod .. " + ALT + E", hl.dsp.exec_cmd(vars.terminal .. " --class yazi_float yazi"))

hl.bind(vars.mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))

hl.bind(vars.mainMod .. " + B", hl.dsp.exec_cmd("brave"))

hl.bind(vars.mainMod .. " + C", hl.dsp.exec_cmd(vars.scripts .. "/fuzzel_zed.sh"))

hl.bind(vars.mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("notify-send \"ZED\" \"Abriendo carpeta de configuración en ZED\" && zed ~/.config/hypr"))

hl.bind(vars.mainMod .. " + CTRL + S", hl.dsp.exec_cmd("pavucontrol"))

-- --- WINDOW MANAGEMENT ---

hl.bind(vars.mainMod .. " + Q", hl.dsp.window.close())

hl.bind(vars.mainMod .. " + M", hl.dsp.exit())

hl.bind(vars.mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(vars.mainMod .. " + t", hl.dsp.window.float())

-- -- FOCUS MOVEMENT ---

local table_action = {
    { mod = "", dsp = hl.dsp.focus },
    { mod = "SHIFT + ", dsp = hl.dsp.window.move },
}

local table_key = { "left", "right", "up", "down" }

local function focus_movement(key, mod, action_hl)
    hl.bind(vars.mainMod .. " + " .. mod .. key, action_hl({ direction = key }))
end

for _, act in ipairs(table_action) do
    for _, movement in ipairs(table_key) do
        focus_movement(movement, act.mod, act.dsp)
    end
end

-- --- MOUSE RESIZE ---

hl.bind(vars.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(vars.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- --- Layout Master Hyprland(binds)
local table_master_binds = {
    { key = vars.mainMod .. " + CTRL + Return", command = "swapwithmaster master" }, -- Change Focus window
    { key = vars.mainMod .. " + CTRL + right", command = "mfact +0.05", repeating = true }, 
    { key = vars.mainMod .. " + CTRL + left", command = "mfact -0.05", repeating = true } 
}

local function master_layout(key, command, repeating)
    hl.bind(key, hl.dsp.layout(command), { repeating = repeating })
end

for _, master_bind in ipairs(table_master_binds) do
    master_layout(master_bind.key, master_bind.command, master_bind.repeating)
end

-- --- OSD KEYS

local command_osd = vars.scripts .. "/osd.sh "

local table_osd= {
    { key = "XF86MonBrightnessUp", command = command_osd, action = "bri_up", repeating = true },
    { key = "XF86MonBrightnessDown", command = command_osd,  action = "bri_down",   repeating = true },
    { key = "XF86AudioRaiseVolume", command = command_osd, action = "vol_up", repeating = true },
    { key = "XF86AudioLowerVolume", command = command_osd, action = "vol_down", repeating = true },
    { key = "XF86AudioMute", command = command_osd, action = "vol_mute", repeating = false },
    { key = "XF86AudioMicMute", command = command_osd, action = "mic_mute", repeating = false },
    { key = "XF86AudioPlay",         command = "playerctl ", action = "play-pause", repeating = false },
    { key = "XF86AudioNext",         command = "playerctl ", action = "next",       repeating = false },
    { key = "XF86AudioPrev",         command = "playerctl ", action = "previous",   repeating = false },
    { key = vars.mainMod .. " + Delete", command = "playerctl ", action = "play-pause", repeating = false},
    { key = vars.mainMod .. " + Prior", command = "playerctl ", action = "next", repeating = false},
    { key = vars.mainMod .. " + Next", command = "playerctl ", action = "previous", repeating = false},
}

local function osd_bind(key, command, action, repeating)
    hl.bind(key, hl.dsp.exec_cmd(command .. action), { repeating = repeating, locked = true })
end

for _, osd in ipairs(table_osd) do
    osd_bind(osd.key, osd.command, osd.action, osd.repeating)
end
