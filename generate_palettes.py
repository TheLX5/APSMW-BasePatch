import os
import json

tilesets = {
    "grass_hills": [],
    "grass_forest": [],
    "grass_rocks": [],
    "grass_clouds": [],
    "grass_mountains": [],
    "cave": [],
    "cave_rocks": [],
    "water": [],
    "mushroom_rocks": [],
    "mushroom_clouds": [],
    "mushroom_forest": [],
    "mushroom_hills": [],
    "mushroom_stars": [],
    "mushroom_cave": [],
    "forest": [],
    "logs": [],
    "clouds": [],
    "castle_pillars": [],
    "castle_windows": [],
    "castle_wall": [],
    "castle_small_windows": [],
    "ghost_house": [],
    "ghost_house_exit": [],
    "ship_exterior": [],
    "ship_interior": [],
    "switch_palace": [],
    "yoshi_house": []
}

tileset_names = [
    "grass_hills",
    "grass_forest",
    "grass_rocks",
    "grass_clouds",
    "grass_mountains",
    "cave",
    "cave_rocks",
    "water",
    "mushroom_rocks",
    "mushroom_clouds",
    "mushroom_forest",
    "mushroom_hills",
    "mushroom_stars",
    "mushroom_cave",
    "forest",
    "logs",
    "clouds",
    "castle_pillars",
    "castle_windows",
    "castle_wall",
    "castle_small_windows",
    "ghost_house",
    "ghost_house_exit",
    "ship_exterior",
    "ship_interior",
    "switch_palace",
    "yoshi_house"
]

map_names = [
    "main",
    "yoshi",
    "vanilla",
    "forest",
    "valley",
    "special",
    "star"
]

maps = {
    "main": [],
    "yoshi": [],
    "vanilla": [],
    "forest": [],
    "valley": [],
    "special": [],
    "star": []
}

data = """includefrom "palette_loader.asm"
;##################################################################################################
;# This file includes palette data into the ROM
;# Probably not a good idea to mess around a lot with this file

pushpc
    !i = 0
    !j = 0
    !_bank_palette_count = 0
    org !custom_level_palettes
"""

map_data = """
pullpc

pushpc
    !i #= 0
    !j #= 0
    !_bank_palette_count #= 0
    org !custom_map_palettes
"""

i = 0
for tileset in tilesets.keys():
    path = os.path.join(os.path.dirname(__file__), "data", "palettes", "level", tileset)
    palettes = next(os.walk(path))[2]
    data += f"        ;# ${i:02X} {tileset}\n"
    data += f"            %init_level_group({tileset})\n"
    for palette in palettes:
        data += f"            %load_level_palette_file({palette[:-4]})\n"
        tilesets[tileset].append(palette)
    i += 1

data += map_data

i = 0
for map_name in maps.keys():
    path = os.path.join(os.path.dirname(__file__), "data", "palettes", "map", map_name)
    palettes = next(os.walk(path))[2]
    data += f"        ;# ${i:02X} {map_name}\n"
    data += f"            %init_map_group({map_name})\n"
    for palette in palettes:
        data += f"            %load_map_palette_file({palette[:-4]})\n"
        maps[map_name].append(palette)
    i += 1

data += "pullpc\n\n"

with open("data/palette_data.asm", "w", encoding='utf-8') as f:
    f.write(data)
    f.close()

with open('level_palettes.json', 'w', encoding='utf-8') as f:
    json.dump(tilesets, f, ensure_ascii=False, indent=4)
with open('map_palettes.json', 'w', encoding='utf-8') as f:
    json.dump(maps, f, ensure_ascii=False, indent=4)