includefrom "palette_loader.asm"
;##################################################################################################
;# This file includes palette data into the ROM
;# Probably not a good idea to mess around a lot with this file

pushpc
    !i = 0
    !j = 0
    !_bank_palette_count = 0
    org !custom_level_palettes
        ; $00 grass_hills     
            %init_level_group(grass_hills)   
            %load_level_palette_file(original)
        ; $01 grass_forest
            %init_level_group(grass_forest)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_green)
            %load_level_palette_file(atardecer)   
        ; $02 grass_rocks [tides] (0)
            %init_level_group(grass_rocks)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_choco_volcanic)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_volcanic_green)
            %load_level_palette_file(original_white)
            %load_level_palette_file(original_white_2)
        ; $03 grass_clouds           
            %init_level_group(grass_clouds)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_green)
        ; $04 grass_mountains (0)
            %init_level_group(grass_mountains)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_white)
        ; $05 cave [lava] (4,2)
            %init_level_group(cave)
            %load_level_palette_file(original_chocolate)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_volcanic)
        ; $06 cave_rocks [layer 2, lava] (4)
            %init_level_group(cave_rocks)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_mustard)
        ; $07 water                  
            %init_level_group(water)
            %load_level_palette_file(original_brown)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_volcanic)
        ; $08 mushroom_rocks [tides] (3)
            %init_level_group(mushroom_rocks)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_white)
        ; $09 mushroom_clouds [tides] (3)
            %init_level_group(mushroom_clouds)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_yellow)
        ; $0A mushroom_forest    
            %init_level_group(mushroom_forest) 
            %load_level_palette_file(original)  
        ; $0B mushroom_hills
            %init_level_group(mushroom_hills)
            %load_level_palette_file(original)
        ; $0C mushroom_stars    
            %init_level_group(mushroom_stars)  
            %load_level_palette_file(original_night)  
            %load_level_palette_file(original_green)
        ; $0D mushroom_cave       
            %init_level_group(mushroom_cave)  
            %load_level_palette_file(original)
        ; $0E forest             
            %init_level_group(forest)  
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_fall)
            %load_level_palette_file(original_dark)
        ; $0F logs                  
            %init_level_group(logs)
            %load_level_palette_file(original)
        ; $10 clouds                
            %init_level_group(clouds)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_orange)
        ; $11 castle_pillars [lava] 
            %init_level_group(castle_pillars)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_white)
        ; $12 castle_windows [lava] (1)
            %init_level_group(castle_windows)
            %load_level_palette_file(original_brown)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_water)
        ; $13 castle_wall           
            %init_level_group(castle_wall)
            %load_level_palette_file(original)
        ; $14 castle_small_windows [lava] 
            %init_level_group(castle_small_windows)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_water)
        ; $15 ghost_house (5)
            %init_level_group(ghost_house)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_dark)
            %load_level_palette_file(original_white)
        ; $16 ghost_house_exit (4)
            %init_level_group(ghost_house_exit)
            %load_level_palette_file(original)
            %load_level_palette_file(original_blue_door)
        ; $17 ship_exterior         
            %init_level_group(ship_exterior)
            %load_level_palette_file(original)
        ; $18 ship_interior (5)
            %init_level_group(ship_interior)
            %load_level_palette_file(original)
        ; $19 switch_palace       
            %init_level_group(switch_palace) 
            %load_level_palette_file(original)
            %load_level_palette_file(original_bonus) 
        ; $1A yoshi_house
            %init_level_group(yoshi_house) 
            %load_level_palette_file(original)
pullpc

pushpc
    !i #= 0
    !j #= 0
    !_bank_palette_count #= 0
    org !custom_map_palettes
        ; $00 Main map
            %init_map_group(main)
            %load_map_palette_file(original)
        ; $01 Yoshi's Island
            %init_map_group(yoshi)
            %load_map_palette_file(original)
        ; $02 Vanilla Dome
            %init_map_group(vanilla)
            %load_map_palette_file(original)
        ; $03 Forest of Illusion
            %init_map_group(forest)
            %load_map_palette_file(original)
        ; $04 Valley of Bowser
            %init_map_group(valley)
            %load_map_palette_file(original)
        ; $05 Special World
            %init_map_group(special)
            %load_map_palette_file(original)
        ; $06 Star World
            %init_map_group(star)
            %load_map_palette_file(original)
pullpc
