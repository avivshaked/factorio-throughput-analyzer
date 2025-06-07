# Factorio Throughput Analyzer

This repository contains a Factorio 2.0 mod that allows you to select an area of your factory and inspect the throughput of machines, belts and inserters.

The mod itself lives in the `throughput-analyzer` directory and can be copied directly into your Factorio mods folder. See the README in that directory for in-game usage instructions.

## Repository Layout

- `throughput-analyzer/` – the mod files loaded by Factorio
- `plan.md` – high level development roadmap

## Deployment Helper

The `deploy_mod.py` script automates installing the mod into your local
Factorio `mods` folder. Provide a new version number and it will update
`throughput-analyzer/info.json`, remove any old copies of the mod and copy the
folder with the version appended to its name. Example:

```bash
python deploy_mod.py 0.1.1
```

Use `--mods-dir` to override the default path of
`C:\Users\shake\AppData\Roaming\Factorio\mods`.

The project is released under the MIT License found in `LICENSE`.

## Debug Logging

Verbose debug messages can be enabled from the in-game mod settings. Enable the
**Throughput Analyzer verbose** option to log additional information to the
`factorio-current.log` file. Leave it disabled for normal play.
