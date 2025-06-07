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
    subgroup = "tool",
    order = "c[automated-construction]-a[analyzer]",
    stack_size = 1,
    select = {
      border_color = {0, 1, 0},
      mode = {"any-entity"},
      cursor_box_type = "entity"
    },
    alt_select = {
      border_color = {0, 1, 0},
      mode = {"any-entity"},
      cursor_box_type = "entity"
    }
  }
})
