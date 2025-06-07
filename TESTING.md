# Manual Testing Guide

This document outlines how to verify the **Throughput Analyzer** Factorio mod in game.

## Prerequisites
- Factorio **2.0** installed.
- The contents of the `throughput-analyzer` folder from this repository.

## Setup
1. Copy or zip the `throughput-analyzer` directory so it becomes `throughput-analyzer_0.1.0.zip` or an unpacked folder.
2. Place the archive or folder into your Factorio `mods` directory (see `PORTING.md` for paths).
3. Launch Factorio and enable the mod in the **Mods** menu if it is not already enabled.

## In‑Game Testing Steps
1. Start a new game or load an existing save.
2. Locate the **Throughput Analyzer** tool in your inventory.
3. Select the tool, then drag over a small area containing a few machines, transport belts and inserters.
4. Upon releasing the mouse button, a window titled **Throughput Analysis** should appear.
5. Verify the window lists each selected entity with columns for **Name**, **Type**, **Max**, and **Current** values.
   - Assemblers should show expected product rates per second in the **Max** column.
   - Transport belts display belt speed in items per second.
   - Inserters report rotation speed.
6. Observe the **Current** column updating depending on whether each entity is currently active.
7. Close the window using the **Close** button and repeat the selection in another area to ensure results refresh correctly.

## Expected Outcome
- The tool is present and usable from the inventory.
- Selecting an area produces a GUI table with throughput numbers for each entity.
- No errors appear in the console while using the tool.
- Closing and re‑selecting different areas shows updated results.

If all of the above behavior is observed, the mod is functioning as intended.
