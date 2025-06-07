#!/usr/bin/env python3
"""Deploy the Factorio mod to the user's mods directory with a new version.

This script updates `throughput-analyzer/info.json` with the provided version,
removes any existing copies of the mod from the destination mods folder, and
copies the mod folder there with the version appended to the directory name.
"""
import argparse
import json
import os
import shutil
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser(description="Deploy the Throughput Analyzer mod")
    parser.add_argument(
        "version",
        help="New version number, e.g. 0.1.1",
    )
    parser.add_argument(
        "--mods-dir",
        default=r"C:\\Users\\shake\\AppData\\Roaming\\Factorio\\mods",
        help="Path to the Factorio mods directory",
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent
    mod_src = repo_root / "throughput-analyzer"
    info_path = mod_src / "info.json"

    # Update info.json version
    with info_path.open("r", encoding="utf-8") as f:
        info = json.load(f)
    old_version = info.get("version")
    info["version"] = args.version
    with info_path.open("w", encoding="utf-8") as f:
        json.dump(info, f, indent=2)
        f.write("\n")
    print(f"Updated version: {old_version} -> {args.version}")

    mods_dir = Path(os.path.expanduser(args.mods_dir))
    if not mods_dir.is_dir():
        raise FileNotFoundError(f"Mods directory not found: {mods_dir}")

    # Remove any existing copies of the mod
    for entry in mods_dir.iterdir():
        if entry.name.startswith("throughput-analyzer"):
            if entry.is_dir():
                shutil.rmtree(entry)
            else:
                entry.unlink()
            print(f"Removed {entry}")

    dest_name = f"throughput-analyzer_{args.version}"
    dest_path = mods_dir / dest_name
    shutil.copytree(mod_src, dest_path)
    print(f"Copied {mod_src} -> {dest_path}")


if __name__ == "__main__":
    main()
