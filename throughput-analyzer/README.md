# Throughput Analyzer Mod

This folder contains the actual Factorio mod.

## Installation

1. Copy the `throughput-analyzer` directory into your Factorio `mods` folder.
2. Start the game and enable the mod.

When the mod is active, a shortcut button appears in the upper-left of the screen. Use this shortcut to spawn the **Throughput Analyzer** selection tool when needed.

## Usage

Select the *Throughput Analyzer* tool from your inventory and drag over an area of machines.
A window will appear listing each entity with its maximum and current throughput.

The mod is in an early stage and will evolve as described in the repository `plan.md`.

## Verbose Logging

You can toggle verbose logging from *Settings → Mod Settings → Startup* (or
*Runtime* depending on Factorio version). Enable **Throughput Analyzer verbose**
to print detailed debug messages to `factorio-current.log`. Disable it when you
no longer need the extra output.
