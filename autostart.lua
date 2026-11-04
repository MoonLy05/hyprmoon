---@module 'hl'


local vars = require("vars")


-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("rm -f /tmp/hypr_gamemode_active")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("steam-nvidia -no-cef-sandbox")
    hl.exec_cmd("rog-control-center")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd(vars.scripts .. "/usb_monitor.sh")
    hl.exec_cmd(vars.scripts .. "/battery_monitor.sh")
end)
