package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. package.path
local vars = require("vars")
local smw = require("plugins.split-monitor-workspaces")

local mainMod = vars.mainMod

smw.setup({
  workspace_count = 5,
  monitor_priority = { "DP-1", "DP-3", "eDP-1", "eDP-2" }, -- el externo recibe los primeros IDs
  keep_focused = true,                         -- no te mueve de workspace al recargar
})

-- Workspaces del monitor donde estás

for i = 1, smw.get_amount_of_workspaces() do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, smw.workspace(tostring(i)))
  hl.bind(mainMod .. " + SHIFT + " .. key, smw.move_to_workspace_silent(tostring(i)))
end

-- Rueda del mouse: cambia de workspace en el monitor actual
hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up", smw.cycle_workspaces("prev"))

-- Manager Window (Focus && Window Move)
local table_action = {
    { mod = " + ", dsp = hl.dsp.focus },
    { mod = " + SHIFT + ", dsp = hl.dsp.window.move, follow = true },
}

local key_bind = {
    { key = "comma", monitor = "l" },
    { key = "period", monitor = "r"},
}

local function manager_window(mod, key, action_hl, monitor, follow)
    hl.bind(mainMod .. mod .. key, action_hl({ monitor = monitor, follow = follow }))
end

for _, act in ipairs(table_action) do
    for _, key_kb in ipairs(key_bind) do
        manager_window(act.mod, key_kb.key, act.dsp, key_kb.monitor, act.follow )
    end
end