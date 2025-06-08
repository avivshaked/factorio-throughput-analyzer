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

local LOG_PREFIX = "[Throughput Analyzer] "

local function debug_log(msg)
  if verbose then log(LOG_PREFIX .. msg) end
end

local function safe_string(val)
  if type(val) == "table" then
    if game then
      local ok, result = pcall(function()
        if game.table_to_json then
          return game.table_to_json(val)
        elseif game.table_to_string then
          return game.table_to_string(val)
        end
      end)
      if ok and result then
        return result
      end
    end
    return "[table]"
  end
  return tostring(val)
end

script.on_init(function()
  update_verbose()
end)

script.on_configuration_changed(function()
  update_verbose()
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
    max = 0,
    current = 0
  }

  local has_recipe, recipe = pcall(entity.get_recipe, entity)
  if has_recipe and recipe then
    local crafts_per_sec = entity.crafting_speed / recipe.energy
    local max_outputs = {}
    local current_outputs = {}
    local working = entity.status == defines.entity_status.working
    for _, product in pairs(recipe.products) do
      local amount = product.amount or ((product.amount_min or 0) + (product.amount_max or 0)) / 2
      local per_min = amount * crafts_per_sec * 60
      table.insert(max_outputs, product.name .. string.format(" %.2f/m", per_min))
      local cur = working and per_min or 0
      table.insert(current_outputs, product.name .. string.format(" %.2f/m", cur))
      result.max = result.max + per_min
      result.current = result.current + cur
    end
    result.max_text = table.concat(max_outputs, ", ")
    result.current_text = table.concat(current_outputs, ", ")
  elseif entity.prototype.belt_speed then
    local speed = entity.prototype.belt_speed
    result.max = speed * 60
    local count = 0
    if entity.get_transport_line then
      for i = 1, 2 do
        local line = entity.get_transport_line(i)
        if line then count = count + line.get_item_count() end
      end
    end
    local fill_ratio = math.min(count / 16, 1)
    result.current = speed * fill_ratio * 60
  elseif entity.type == "inserter" then
    local rot = entity.prototype.rotation_speed
    if not rot then
      -- rotation_speed may be missing on some modded inserters
      rot = 0
      debug_log("rotation_speed missing for " .. entity.name)
    end
    result.max = rot * 60
    local cur = (entity.held_stack and entity.held_stack.valid_for_read) and rot or 0
    result.current = cur * 60
  end
  debug_log(string.format("Result for %s: max=%s current=%s",
    safe_string(result.name), result.max, result.current))
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

  local max_height = player.display_resolution.height * player.display_scale - 100
  local pane = frame.add{type="scroll-pane"}
  pane.style.maximal_height = max_height

  local table_elem = pane.add{type="table", column_count=5}
  table_elem.add{type="label", caption="Name"}
  table_elem.add{type="label", caption="Count"}
  table_elem.add{type="label", caption="Type"}
  table_elem.add{type="label", caption="Max"}
  table_elem.add{type="label", caption="Current"}

  for _, r in pairs(results) do
    table_elem.add{type="label", caption=r.name}
    table_elem.add{type="label", caption=tostring(r.count)}
    table_elem.add{type="label", caption=r.type}
    table_elem.add{type="label", caption=r.max}
    table_elem.add{type="label", caption=r.current}
  end

  frame.add{type="button", name="throughput_analyzer_close", caption="Close"}
end

local function analyze_selection(event)
  debug_log("Analyzing selection of " .. #event.entities .. " entities")
  local aggregated = {}
  for _, entity in pairs(event.entities) do
    local r = analyze_entity(entity)
    local key = r.name
    local entry = aggregated[key]
    if not entry then
      entry = {name = r.name, type = r.type, count = 0, max = 0, current = 0}
      aggregated[key] = entry
    end
    entry.count = entry.count + 1
    entry.max = entry.max + r.max
    entry.current = entry.current + r.current
  end
  local results = {}
  for _, entry in pairs(aggregated) do
    entry.max = string.format("%.2f/m", entry.max)
    entry.current = string.format("%.2f/m", entry.current)
    table.insert(results, entry)
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

