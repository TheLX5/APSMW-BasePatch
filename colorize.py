import os

sprite_primary_colors = []
sprite_colors = []
foreground_colors = []
with open("base_ap.mw3", "rb") as f:
    f.seek(0x58*2)
    foreground_colors.append(f.read(0x10))
    f.seek(0x68*2)
    foreground_colors.append(f.read(0x10))
    f.seek(0x78*2)
    foreground_colors.append(f.read(0x10))
    f.seek(0xC8*2)
    sprite_colors.append(f.read(0x10))
    f.seek(0xD8*2)
    sprite_colors.append(f.read(0x10))
    sprite_primary_colors = f.read(0x40)

cave_colors = []
with open("original_volcanic.mw3", "rb") as f:
    f.seek(0xE8*2)
    cave_colors.append(f.read(0x10))
    f.seek(0xF8*2)
    cave_colors.append(f.read(0x10))

for folder in os.listdir("data/palettes/level"):
    folder_path = os.path.join("data/palettes/level", folder)
    for filename in os.listdir(folder_path):
        with open(os.path.join(folder_path, filename), "r+b") as f:
            print (os.path.join(folder_path, filename))
            offset = 0
            for colors in foreground_colors:
                f.seek(0x58*2 + offset)
                f.write(colors)
                offset += 0x20
            offset = 0
            for colors in sprite_colors:
                f.seek(0xC8*2 + offset)
                f.write(colors)
                offset += 0x20
            f.write(sprite_primary_colors)