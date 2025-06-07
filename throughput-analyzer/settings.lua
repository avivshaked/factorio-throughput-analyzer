---@diagnostic disable: undefined-global
-- Runtime setting to control verbose debug output
-- luacheck: globals data

local order_prefix = "a[throughput-analyzer]"

data:extend({
  {
    type = "bool-setting",
    name = "throughput-analyzer-verbose",
    setting_type = "runtime-global",
    default_value = false,
    order = order_prefix .. "[verbose]"
  }
})
