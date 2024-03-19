# Archipelago's Super Mario World Base Patch
This repository contains all the static ASM that's used to implement SMW in [Archipelago](https://github.com/ArchipelagoMW/Archipelago).

## Build
Requires:
* Python for building asm files automatically
  * Any version that supports fstrings works
* [Asar 1.90](https://github.com/RPGHacker/asar/releases/tag/v1.90) for compiling

Steps:
* Run `generate_palettes.py`
* Run `asar main.asm <SMW ROM>`

You now have gotten the SMW ROM with the static code used in AP.
