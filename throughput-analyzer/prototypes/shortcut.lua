---@diagnostic disable: undefined-global
-- luacheck: globals data

local icon_path = "__base__/graphics/icons/blueprint.png"

data:extend({
  {
    type = "shortcut",
    name = "throughput-analyzer-shortcut",
    order = "b[tools]-c[analyzer]",
    action = "spawn-item",
    item_to_spawn = "throughput-analyzer-tool",
    toggleable = false,
    icon = {
      filename = icon_path,
      size = 64,
      mipmap_count = 4,
      flags = {"gui-icon"}
    }
  }
})
