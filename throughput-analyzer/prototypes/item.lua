---@diagnostic disable: undefined-global
-- luacheck: globals data
-- Use a base game icon to avoid shipping a binary placeholder
local icon_path = "__throughput-analyzer__/graphics/icons/analyzer-icon.png"

data:extend({
  {
    type = "selection-tool",
    name = "throughput-analyzer-tool",
    icon = icon_path,
    icon_size = 64,
    flags = {"goes-to-main-inventory"},
    subgroup = "tool",
    order = "c[automated-construction]-a[analyzer]",
    stack_size = 1,
    selection_color = {r=0, g=1, b=0},
    alt_selection_color = {r=0, g=1, b=0},
    selection_mode = {"any-entity"},
    alt_selection_mode = {"any-entity"},
    selection_cursor_box_type = "entity",
    alt_selection_cursor_box_type = "entity"
  }
})
