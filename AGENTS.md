# Repository Guide for Factorio Throughput Analyzer

This repository contains a Factorio 2.0 mod that provides a tool for analyzing factory throughput. The mod lives in the `throughput-analyzer/` folder. Python utilities and documentation reside in the repository root.

## Key Locations
- `throughput-analyzer/` – Factorio mod files (`info.json`, `control.lua`, `data.lua`, etc.)
- `deploy_mod.py` – helper script to copy the mod into your Factorio `mods` directory and update the version.
- `MODDING_SUMMARY.md` – quick reference to the Factorio modding guidelines. Review this when modifying prototypes or control logic.
- `TESTING.md` – manual instructions for verifying the mod in game.

## Contribution Notes
- **Reference `MODDING_SUMMARY.md`** whenever you add or change mod files. Follow the conventions described there for structure, settings, and event handling.
- **Always test your changes.** If you can launch Factorio, follow the steps in `TESTING.md`. Otherwise, inform the user that manual testing is required and outline the steps.
- Keep commits focused and mention major changes in the commit messages.

