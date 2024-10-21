from sprite_gfx_data import sprite_gfx_data

def decompress_gfx(compressed_graphics) -> bytearray:
    # This code decompresses graphics in LC_LZ2 format in order to be able to swap player and yoshi's graphics with ease.
    decompressed_gfx = bytearray([])
    i = 0
    while True:
        cmd = compressed_graphics[i]
        i += 1
        if cmd == 0xFF:
            break
        else:
            if (cmd >> 5) == 0x07:
                size = ((cmd & 0x03) << 8) + compressed_graphics[i] + 1
                cmd = (cmd & 0x1C) >> 2
                i += 1
            else:
                size = (cmd & 0x1F) + 1
                cmd = cmd >> 5
            if cmd == 0x00:
                decompressed_gfx += bytearray([compressed_graphics[i+j] for j in range(size)])
                i += size
            elif cmd == 0x01:
                byte_fill = compressed_graphics[i]
                i += 1
                decompressed_gfx += bytearray([byte_fill for j in range(size)])
            elif cmd == 0x02:
                byte_fill_1 = compressed_graphics[i]
                i += 1
                byte_fill_2 = compressed_graphics[i]
                i += 1
                for j in range(size):
                    if (j & 0x1) == 0x00:
                        decompressed_gfx += bytearray([byte_fill_1])
                    else:
                        decompressed_gfx += bytearray([byte_fill_2])
            elif cmd == 0x03:
                byte_read = compressed_graphics[i]
                i += 1
                decompressed_gfx += bytearray([(byte_read + j) for j in range(size)])
            elif cmd == 0x04:
                position = (compressed_graphics[i] << 8) + compressed_graphics[i+1]
                i += 2
                for j in range(size):
                    copy_byte = decompressed_gfx[position+j]
                    decompressed_gfx += bytearray([copy_byte])
    return decompressed_gfx


def convert_3bpp(decompressed_gfx) -> bytearray:
    i = 0
    converted_gfx = bytearray([])
    while i < len(decompressed_gfx):
        converted_gfx += bytearray([decompressed_gfx[i+j] for j in range(16)])
        i += 16
        for j in range(8):
            converted_gfx += bytearray([decompressed_gfx[i]])
            converted_gfx += bytearray([0x00])
            i += 1
    return converted_gfx


def copy_sprite_tiles(original, order, data_size, px_size = [5, 32]) -> bytearray:
    result = bytearray([0x00 for _ in range(data_size * 0x400)])
    offset = 0
    for x in range(len(order)):
        if x != 0 and x & 0x7 == 0:
            offset += 0x0200

        if type(order[x]) is int:
            z = order[x] << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x20
            z = order[x]+0x01 << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x1E0
            z = order[x]+0x10 << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x20
            z = order[x]+0x11 << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset -= 0x1E0
        else:
            z = order[x][0] << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x20
            z = order[x][1] << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x1E0
            z = order[x][2] << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset += 0x20
            z = order[x][3] << px_size[0]
            result[offset:offset+0x20] = original[z:z+px_size[1]]
            offset -= 0x1E0

    return result


# Decompresses and moves into a expanded region the player, yoshi and animated graphics
# This should make swapping the graphics a lot easier.
# Maybe I should look into making a 32x32 version at some point...
# It also moves some 8x8 tiles in GFX00, thus making some free space for indicators and other stuff
# in VRAM during gameplay, will come super handy later.
# 
# FOR FUTURE REFERENCE
# Player graphics are now located at 0xE0000
# Player auxiliary tiles are now located at 0xE6000
# Yoshi graphics are now located at 0xE8800

with open("Super Mario World (USA).sfc", "rb") as f:
    rom = f.read()
    rom = bytearray(rom)

SMW_COMPRESSED_GFX_32 = 0x40000
SMW_COMPRESSED_GFX_33 = 0x43FC0

SMW_COMPRESSED_GFX_00 = 0x459F9
SMW_COMPRESSED_GFX_01 = 0x46231
SMW_COMPRESSED_GFX_02 = 0x46CBB
SMW_COMPRESSED_GFX_03 = 0x47552
SMW_COMPRESSED_GFX_04 = 0x47F7D
SMW_COMPRESSED_GFX_05 = 0x48963
SMW_COMPRESSED_GFX_06 = 0x4936C
SMW_COMPRESSED_GFX_09 = 0x4AFA1
SMW_COMPRESSED_GFX_0A = 0x4BA15
SMW_COMPRESSED_GFX_0B = 0x4C39C
SMW_COMPRESSED_GFX_0E = 0x4DDCB
SMW_COMPRESSED_GFX_11 = 0x4F7AF
SMW_COMPRESSED_GFX_12 = 0x4FFBD
SMW_COMPRESSED_GFX_13 = 0x50910
SMW_COMPRESSED_GFX_20 = 0x576A1
SMW_COMPRESSED_GFX_23 = 0x591CA
SMW_COMPRESSED_GFX_24 = 0x59AE5
SMW_COMPRESSED_GFX_25 = 0x5A3B5

SMW_COMPRESSED_GFX_10 = 0x4EF1E
SMW_COMPRESSED_GFX_28 = 0x5C06C

compressed_graphics = {
    0x00: [SMW_COMPRESSED_GFX_00, 2104, "3bpp"],
    0x01: [SMW_COMPRESSED_GFX_01, 2698, "3bpp"],
    0x02: [SMW_COMPRESSED_GFX_02, 2199, "3bpp"],
    0x03: [SMW_COMPRESSED_GFX_03, 2603, "3bpp"],
    0x04: [SMW_COMPRESSED_GFX_04, 2534, "3bpp"],
    0x05: [SMW_COMPRESSED_GFX_05, 2569, "3bpp"],
    0x06: [SMW_COMPRESSED_GFX_06, 2468, "3bpp"],
    0x09: [SMW_COMPRESSED_GFX_09, 2676, "3bpp"],
    0x0A: [SMW_COMPRESSED_GFX_0A, 2439, "3bpp"],
    0x0B: [SMW_COMPRESSED_GFX_0B, 2503, "3bpp"],
    0x0E: [SMW_COMPRESSED_GFX_0E, 2330, "3bpp"],
    0x11: [SMW_COMPRESSED_GFX_11, 2062, "3bpp"],
    0x12: [SMW_COMPRESSED_GFX_12, 2387, "3bpp"],
    0x13: [SMW_COMPRESSED_GFX_13, 2616, "3bpp"],
    0x20: [SMW_COMPRESSED_GFX_20, 2244, "3bpp"],
    0x23: [SMW_COMPRESSED_GFX_23, 2331, "3bpp"],
    0x24: [SMW_COMPRESSED_GFX_24, 2256, "3bpp"],
    0x25: [SMW_COMPRESSED_GFX_25, 2668, "3bpp"],
    0x10: [SMW_COMPRESSED_GFX_10, 2193, "3bpp"],
    0x28: [SMW_COMPRESSED_GFX_28, 1591, "2bpp"],
    0x32: [SMW_COMPRESSED_GFX_32, 16320, "4bpp"],
    0x33: [SMW_COMPRESSED_GFX_33, 6713, "3bpp"],
}

unconverted_sprite_graphics = bytearray()
player_graphics = bytearray()
animated_graphics = bytearray()

for slot, data in compressed_graphics.items():
    start = data[0]
    end = start + data[1]
    compressed_gfx = rom[start:end]
    if data[2] == "3bpp":
        unconverted_sprite_graphics += convert_3bpp(decompress_gfx(compressed_gfx))
    elif slot == 0x32:
        player_graphics = decompress_gfx(compressed_gfx)
    elif slot == 0x33:
        animated_graphics_graphics = decompress_gfx(compressed_gfx)
    else:
        unconverted_sprite_graphics += decompress_gfx(compressed_gfx)

sprite_graphics = bytearray([0x00 for _ in range(0x23000)])

offset = 0
for sprite_slot, sprite_data in sprite_gfx_data.items():
    if len(sprite_data) == 0:
        continue
    sprite_size = sprite_data.pop(0)
    if sprite_size < 0x0069:
        #print (sprite_size, offset, f"{len(sprite_graphics):06X}")
        sprite_graphics[offset:offset+sprite_size*0x400] = copy_sprite_tiles(unconverted_sprite_graphics, sprite_data, sprite_size)
        offset += 0x400 * sprite_size

with open("unconverted_sprite_graphics.bin", "wb") as f:
    f.write(unconverted_sprite_graphics)

with open("base/sprite_graphics.bin", "wb") as f:
    f.write(sprite_graphics)

with open("base/sprite_page_1.bin", "wb") as f:
    f.write(unconverted_sprite_graphics[0x0000:0x1000])

with open("base/sprite_page_2.bin", "wb") as f:
    f.write(unconverted_sprite_graphics[0x1000:0x2000])

    
order = [
    0x0024,0x0024,0x0026,0x0026,0x000E,0x000E,0x0048,0x0048,
    0x0680,0x0680,0x0680,0x0680,0x0680,0x0680,0x0680,0x0680,
    0x0066,0x0066,0x0066,0x0066,0x0066,0x0066,0x0066,0x0066,
    0x0066,0x0066,0x0066,0x0066,0x0066,0x0066,0x0843,0x0066,
]
inventory_gfx = copy_sprite_tiles(unconverted_sprite_graphics, order, 4)

with open("base/map_sprites.bin", "wb") as f:
    f.write(inventory_gfx)