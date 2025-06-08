# Throughput Analyzer Mod Plan

## Overall Goals
- Provide a tool that allows a player to select an area and analyze the throughput of machines, belts, and inserters within that area.
- Display throughput data in a GUI and highlight potential bottlenecks.
- Iteratively expand functionality as the mod evolves.

## Implementation Checklist
- [x] Create base mod folder with `info.json`, `data.lua`, and basic prototypes
- [x] Implement selection tool prototype and localization
- [x] Register selection tool events in `control.lua`
- [x] On selection, scan entities and compute simple throughput metrics
- [x] Display results in a basic GUI table
- [x] Show max vs actual throughput for each entity
- [x] Switch to built-in icon to avoid binary files in repo
- [x] Remove custom icon file and reference a base game icon in `item.lua`
- [ ] Identify and highlight bottlenecks
- [ ] Incrementally refine analysis logic and GUI

## Rationales
- **Base mod structure** ensures Factorio can load the mod.
- **Selection tool** lets players choose an area similar to blueprint tools.
- **Event handling** is required to react when players use the tool.
- **Throughput calculations** provide the core functionality—measuring production rates and belt speeds.
- **GUI display** communicates results to the player in-game.
- **Bottleneck detection** helps players optimize their factories.
- **Iterative updates** allow gradual enhancement of features and accuracy.
- **Max vs actual throughput** reveals inefficiencies in production.
- **Built-in icon** avoids storing unsupported binary files.

## Future Plans
- Implement color-coded overlays for belts and pipes to visualize throughput in-world.
- Extend analysis to logistic bots, trains, and fluid systems.
- Provide export options for throughput statistics (e.g., CSV files).
- Add historical graphs to track performance over time.
- Allow players to configure bottleneck detection thresholds and alerts.
