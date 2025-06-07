-- luacheck: globals script game defines

local ANALYZER_NAME = "throughput-analyzer-tool"

-- Verbose debug flag controlled by a runtime setting
local verbose = false

local function update_verbose()
  if settings and settings.global then
    local setting = settings.global["throughput-analyzer-verbose"]
    verbose = setting and setting.value or false
  end
end

local function debug_log(msg)
  if verbose then log("[TA] " .. msg) end
end

local function give_tool(player)
  if player and player.valid then
    local inv = player.get_main_inventory()
    if inv and not inv.find_item_stack(ANALYZER_NAME) then
      inv.insert{name = ANALYZER_NAME, count = 1}
    end
  end
end

local function give_tool_all_players()
  for _, p in pairs(game.players) do
    give_tool(p)
  end
end

script.on_init(function()
  update_verbose()
  give_tool_all_players()
end)

script.on_configuration_changed(function()
  update_verbose()
  give_tool_all_players()
end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if event.setting == "throughput-analyzer-verbose" then
    update_verbose()
  end
end)

local function analyze_entity(entity)
  debug_log("Analyzing entity " .. entity.name .. " (" .. entity.type .. ")")
  local result = {
    name = entity.localised_name or entity.name,
    type = entity.type,
    max = "",
    current = ""
  }

  local has_recipe, recipe = pcall(entity.get_recipe, entity)
  if has_recipe and recipe then
    local crafts_per_sec = entity.crafting_speed / recipe.energy
    local max_outputs = {}
    local current_outputs = {}
    local working = entity.status == defines.entity_status.working
    for _, product in pairs(recipe.products) do
      local amount = product.amount or ((product.amount_min or 0) + (product.amount_max or 0)) / 2
      local per_sec = amount * crafts_per_sec
      table.insert(max_outputs, product.name .. string.format(" %.2f/s", per_sec))
      local cur = working and per_sec or 0
      table.insert(current_outputs, product.name .. string.format(" %.2f/s", cur))
    end
    result.max = table.concat(max_outputs, ", ")
    result.current = table.concat(current_outputs, ", ")
  elseif entity.prototype.belt_speed then
    local speed = entity.prototype.belt_speed
    result.max = string.format("%.2f", speed)
    local count = 0
    if entity.get_transport_line then
      for i = 1, 2 do
        local line = entity.get_transport_line(i)
        if line then count = count + line.get_item_count() end
      end
    end
    local fill_ratio = math.min(count / 16, 1)
    result.current = string.format("%.2f", speed * fill_ratio)
  elseif entity.type == "inserter" then
    local rot = entity.prototype.rotation_speed
    result.max = string.format("%.2f", rot)
    local cur = (entity.held_stack and entity.held_stack.valid_for_read) and rot or 0
    result.current = string.format("%.2f", cur)
  end
  debug_log(string.format("Result for %s: max=%s current=%s", result.name, result.max, result.current))
  return result
end

local function show_gui(player, results)
  debug_log("Showing GUI to " .. player.name .. " with " .. #results .. " entries")
  if player.gui.screen.throughput_analyzer_frame then
    player.gui.screen.throughput_analyzer_frame.destroy()
  end

  local frame = player.gui.screen.add{
    type = "frame",
    name = "throughput_analyzer_frame",
    caption = "Throughput Analysis",
    direction = "vertical"
  }
  frame.auto_center = true

  local table_elem = frame.add{type="table", column_count=4}
  table_elem.add{type="label", caption="Name"}
  table_elem.add{type="label", caption="Type"}
  table_elem.add{type="label", caption="Max"}
  table_elem.add{type="label", caption="Current"}

  for _, r in pairs(results) do
    table_elem.add{type="label", caption=r.name}
    table_elem.add{type="label", caption=r.type}
    table_elem.add{type="label", caption=r.max}
    table_elem.add{type="label", caption=r.current}
  end

  frame.add{type="button", name="throughput_analyzer_close", caption="Close"}
end

local function analyze_selection(event)
  debug_log("Analyzing selection of " .. #event.entities .. " entities")
  local results = {}
  for _, entity in pairs(event.entities) do
    table.insert(results, analyze_entity(entity))
  end
  local player = game.players[event.player_index]
  show_gui(player, results)
  debug_log("Analysis complete")
end

script.on_event(defines.events.on_player_selected_area, function(event)
  if event.item == ANALYZER_NAME then
    analyze_selection(event)
  end
end)

script.on_event(defines.events.on_gui_click, function(event)
  if event.element and event.element.valid and event.element.name == "throughput_analyzer_close" then
    local frame = event.element.parent
    if frame and frame.valid then
      debug_log("Closing analyzer window for player " .. game.players[event.player_index].name)
      frame.destroy()
    end
  end
end)

script.on_event(defines.events.on_player_created, function(event)
  local player = game.players[event.player_index]
  give_tool(player)
end)
