---@module 'hl'

package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path

require("environment")
require("monitor")
require("keyboard")
require("style.style")
require("windowrules")
require("keybindings")
require("autostart")
require("workspaces")
require("games")
require("gamemode_auto")