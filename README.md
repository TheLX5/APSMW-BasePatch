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

## Credits
* lx5
  * Current ASM maintainer
* PoryGone
  * Initial base code
* MarioE
  * [OW Inventory](https://www.smwcentral.net/?p=section&a=details&id=10629)
* Ladida
  * Many misc player DMA codes
* JamesD28
  * [P-Switch Solid Directional Coins](https://www.smwcentral.net/?p=section&a=details&id=29801)
* anonimato
  * Level & palettes
* Vash Varket
  * Level & palettes
* Shiny
  * Level & palettes
* Big Brawler
  * Level & palettes
* IvanSword
  * Level & palettes
