# Factorio Modding Quick Reference

This document summarizes key aspects of Factorio modding as described on the official wiki.

## Basic Mod Structure
- Each mod is a folder or zipped archive placed inside the `mods` directory.
- An `info.json` file defines the mod's metadata: name, version, author, title, description, Factorio version compatibility, and optional dependencies.
- `data.lua` is executed during the data stage to define prototypes for new items, entities, technologies, etc.
- Optional files like `settings.lua` define startup or runtime settings, and `control.lua` runs during the control stage (the actual game) to register event handlers and game logic.
- Additional prototype definitions are typically organized under a `prototypes` directory and required from `data.lua`.

## Data Stage vs Control Stage
- **Data stage** scripts (e.g., `data.lua` and files it loads) run once when Factorio loads mods. They set up prototypes but cannot interact with the game world.
- **Control stage** scripts (in `control.lua`) run while the game is being played. They handle events, create GUI elements, and manipulate entities.

## Locale
- Mods should provide localization files in the `locale/<language>` directory with `cfg` files defining text strings shown to players.

## Graphics and Assets
- Icons and sprites live under a `graphics` directory referenced by prototype definitions. Using base game assets avoids shipping large binaries when possible.

## Settings
- Startup and runtime settings are declared in `settings.lua`. Runtime settings can be read in control scripts to alter behavior without restarting the game.

## Events and Scripting
- Control scripts register handlers for events such as entity creation, GUI interactions, or custom input.
- Remote interfaces allow interaction between mods.

## Packaging and Distribution
- The mod directory can be zipped into `modname_version.zip` for uploading to the mod portal or sharing.
- The `info.json`'s `factorio_version` field specifies compatibility (e.g., "1.1" or "2.0").

These points provide a condensed overview; consult the Factorio modding tutorials and API docs on the wiki for detailed information.
