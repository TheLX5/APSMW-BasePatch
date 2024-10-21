import bsdiff4
import os
import sys

base_path = "Super Mario World (USA).sfc"
patch_path = sys.argv[1]
base = open(base_path, 'rb').read()
patch = open(patch_path, 'rb').read()

bsdiff4.file_diff(base_path, patch_path, patch_path.replace(".sfc", ".bsdiff4"))

if not os.path.exists(patch_path.replace(".sfc", ".bsdiff4")):
    print("PATCH FAILED")

bsdiff4.file_diff("base/sprite_graphics.bin", "sprite_graphics.bin", "patches/sprite_graphics.bsdiff4")

bsdiff4.file_diff("base/sprite_page_1.bin", "sprite_page_1.bin", "patches/sprite_page_1.bsdiff4")

bsdiff4.file_diff("base/sprite_page_2.bin", "sprite_page_2.bin", "patches/sprite_page_2.bsdiff4")

bsdiff4.file_diff("base/map_sprites.bin", "map_sprites.bin", "patches/map_sprites.bsdiff4")