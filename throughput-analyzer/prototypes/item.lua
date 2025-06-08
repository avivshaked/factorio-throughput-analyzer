---@diagnostic disable: undefined-global
local icon_path = "__base__/graphics/icons/blueprint.png"

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
