includefrom "palette_loader.asm"
;##################################################################################################
;# This file includes palette data into the ROM
;# Probably not a good idea to mess around a lot with this file

pushpc
    !i = 0
    !j = 0
    !_bank_palette_count = 0
    org !custom_level_palettes
        ;# $00 grass_hills
            %init_level_group(grass_hills)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(brawler_green)
            %load_level_palette_file(crimson)
            %load_level_palette_file(electro)
            %load_level_palette_file(geo)
            %load_level_palette_file(miku)
            %load_level_palette_file(mogumogu)
            %load_level_palette_file(nocturno)
            %load_level_palette_file(original)
            %load_level_palette_file(sakura)
            %load_level_palette_file(snow)
            %load_level_palette_file(sunsetish_grass_hills)
            %load_level_palette_file(toothpaste)
        ;# $01 grass_forest
            %init_level_group(grass_forest)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(autumn)
            %load_level_palette_file(brawler)
            %load_level_palette_file(brawler_atardecer)
            %load_level_palette_file(brawler_green)
            %load_level_palette_file(crimson)
            %load_level_palette_file(deep_forest)
            %load_level_palette_file(electro)
            %load_level_palette_file(geo)
            %load_level_palette_file(miku)
            %load_level_palette_file(myon)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_green)
            %load_level_palette_file(pizza)
            %load_level_palette_file(sakura)
            %load_level_palette_file(snow_dark_leaves)
            %load_level_palette_file(snow_green)
            %load_level_palette_file(winter)
        ;# $02 grass_rocks
            %init_level_group(grass_rocks)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(crimson)
            %load_level_palette_file(dark)
            %load_level_palette_file(electro)
            %load_level_palette_file(geo)
            %load_level_palette_file(ice)
            %load_level_palette_file(miku)
            %load_level_palette_file(napolitano)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_choco_volcanic)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_volcanic_green)
            %load_level_palette_file(original_white)
            %load_level_palette_file(original_white_2)
            %load_level_palette_file(recks)
            %load_level_palette_file(sakura)
            %load_level_palette_file(thanks_doc)
        ;# $03 grass_clouds
            %init_level_group(grass_clouds)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(crimson)
            %load_level_palette_file(electro)
            %load_level_palette_file(geo)
            %load_level_palette_file(miku)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_green)
            %load_level_palette_file(pizza)
            %load_level_palette_file(sakura)
            %load_level_palette_file(shukfr)
            %load_level_palette_file(snow_day)
            %load_level_palette_file(volcanic_rock)
        ;# $04 grass_mountains
            %init_level_group(grass_mountains)
            %load_level_palette_file(brawler_lifeless)
            %load_level_palette_file(classic_sm)
            %load_level_palette_file(crimson)
            %load_level_palette_file(dry_hills)
            %load_level_palette_file(electro)
            %load_level_palette_file(geo)
            %load_level_palette_file(late_sandish)
            %load_level_palette_file(miku)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_white)
            %load_level_palette_file(recksfr)
            %load_level_palette_file(sakura_hills)
            %load_level_palette_file(snow_day)
        ;# $05 cave
            %init_level_group(cave)
            %load_level_palette_file(brawler_dark)
            %load_level_palette_file(brawler_purple)
            %load_level_palette_file(brawler_red)
            %load_level_palette_file(brawler_teal)
            %load_level_palette_file(bright_magma)
            %load_level_palette_file(dark_red)
            %load_level_palette_file(glowing_mushroom)
            %load_level_palette_file(green_depths)
            %load_level_palette_file(ice)
            %load_level_palette_file(magma_cave)
            %load_level_palette_file(original_chocolate)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(snow)
            %load_level_palette_file(toxic)
            %load_level_palette_file(toxic_moss)
        ;# $06 cave_rocks
            %init_level_group(cave_rocks)
            %load_level_palette_file(bocchi_rock_hair_cube_things)
            %load_level_palette_file(brawler_volcanic)
            %load_level_palette_file(ice)
            %load_level_palette_file(layer_2)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(pyra_mythra_ft_pneuma)
            %load_level_palette_file(snow)
            %load_level_palette_file(toxic)
        ;# $07 water
            %init_level_group(water)
            %load_level_palette_file(dark_water)
            %load_level_palette_file(deep_aqua)
            %load_level_palette_file(deep_chocolate)
            %load_level_palette_file(harmless_magma)
            %load_level_palette_file(murky)
            %load_level_palette_file(oil_spill)
            %load_level_palette_file(original_brown)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(pickle_juice)
        ;# $08 mushroom_rocks
            %init_level_group(mushroom_rocks)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(brightshroom)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_ice)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_white)
            %load_level_palette_file(riesgo_de_chubascos_cafe)
            %load_level_palette_file(riesgo_de_chubascos_negro)
            %load_level_palette_file(shuk_ft_reyn)
        ;# $09 mushroom_clouds
            %init_level_group(mushroom_clouds)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(greenshroom)
            %load_level_palette_file(oilshroom)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_yellow)
            %load_level_palette_file(riesgo_de_chubascos)
        ;# $0A mushroom_forest
            %init_level_group(mushroom_forest)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(autumn)
            %load_level_palette_file(count_shroomcula)
            %load_level_palette_file(cursed_gold)
            %load_level_palette_file(dark_green)
            %load_level_palette_file(lifeless_gray)
            %load_level_palette_file(original)
            %load_level_palette_file(snow_dark)
            %load_level_palette_file(snow_green)
        ;# $0B mushroom_hills
            %init_level_group(mushroom_hills)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(atardecer_naranjo)
            %load_level_palette_file(atardecer_verde)
            %load_level_palette_file(future)
            %load_level_palette_file(original)
            %load_level_palette_file(riesgo_de_chubascos_azul)
            %load_level_palette_file(riesgo_de_chubascos_cafe)
            %load_level_palette_file(riesgo_de_chubascos_negro)
            %load_level_palette_file(watermelon_skies)
        ;# $0C mushroom_stars
            %init_level_group(mushroom_stars)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(cool)
            %load_level_palette_file(dark_night)
            %load_level_palette_file(halloween)
            %load_level_palette_file(light_pollution)
            %load_level_palette_file(midas)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_night)
            %load_level_palette_file(purpleish_night)
            %load_level_palette_file(riesgo_de_chubascos)
        ;# $0D mushroom_cave
            %init_level_group(mushroom_cave)
            %load_level_palette_file(argent_cave)
            %load_level_palette_file(glowing_mushroom)
            %load_level_palette_file(green_aqua)
            %load_level_palette_file(ice)
            %load_level_palette_file(original)
            %load_level_palette_file(really_dark)
            %load_level_palette_file(toxic)
        ;# $0E forest
            %init_level_group(forest)
            %load_level_palette_file(agnian_queen)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(frozen)
            %load_level_palette_file(halloween)
            %load_level_palette_file(kevesi_queen)
            %load_level_palette_file(original_dark)
            %load_level_palette_file(original_fall)
            %load_level_palette_file(original_green)
            %load_level_palette_file(sakura)
            %load_level_palette_file(snow_dark_leaves)
            %load_level_palette_file(snow_green_leaves)
        ;# $0F logs
            %init_level_group(logs)
            %load_level_palette_file(brawler)
            %load_level_palette_file(evening)
            %load_level_palette_file(mahogany)
            %load_level_palette_file(not_quite_dawnbreak)
            %load_level_palette_file(original)
            %load_level_palette_file(riesgo_de_chubascos)
        ;# $10 clouds
            %init_level_group(clouds)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(cloudy)
            %load_level_palette_file(cotton_candy)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_orange)
        ;# $11 castle_pillars
            %init_level_group(castle_pillars)
            %load_level_palette_file(agnus_castle)
            %load_level_palette_file(cheese)
            %load_level_palette_file(chocolate_blue)
            %load_level_palette_file(dark_aqua_marine)
            %load_level_palette_file(dollhouse)
            %load_level_palette_file(gold_caslte)
            %load_level_palette_file(keves_castle)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_green)
            %load_level_palette_file(original_mustard)
            %load_level_palette_file(original_white)
            %load_level_palette_file(pink_purple)
            %load_level_palette_file(purple_pink)
            %load_level_palette_file(sand_gray)
            %load_level_palette_file(sand_green)
            %load_level_palette_file(shenhe)
            %load_level_palette_file(whatsapp)
        ;# $12 castle_windows
            %init_level_group(castle_windows)
            %load_level_palette_file(brawler_pink)
            %load_level_palette_file(cheese)
            %load_level_palette_file(dark_aqua_marine)
            %load_level_palette_file(dollhouse)
            %load_level_palette_file(original_brown)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_water)
            %load_level_palette_file(red_castle)
            %load_level_palette_file(shenhe)
            %load_level_palette_file(underwater)
            %load_level_palette_file(water)
            %load_level_palette_file(whatsapp)
        ;# $13 castle_wall
            %init_level_group(castle_wall)
            %load_level_palette_file(cheese)
            %load_level_palette_file(dollhouse)
            %load_level_palette_file(grand_marshall)
            %load_level_palette_file(hot_wall)
            %load_level_palette_file(original)
            %load_level_palette_file(sand_green)
            %load_level_palette_file(shenhe)
            %load_level_palette_file(water)
        ;# $14 castle_small_windows
            %init_level_group(castle_small_windows)
            %load_level_palette_file(dark_lava)
            %load_level_palette_file(dark_purple)
            %load_level_palette_file(dollhouse)
            %load_level_palette_file(forgotten_temple)
            %load_level_palette_file(original_gray)
            %load_level_palette_file(original_volcanic)
            %load_level_palette_file(original_water)
            %load_level_palette_file(sand_gray)
            %load_level_palette_file(sand_green)
            %load_level_palette_file(shenhe)
            %load_level_palette_file(water)
            %load_level_palette_file(whatsapp)
        ;# $15 ghost_house
            %init_level_group(ghost_house)
            %load_level_palette_file(brawler_cyan)
            %load_level_palette_file(brawler_orange)
            %load_level_palette_file(brawler_purple)
            %load_level_palette_file(creepypasta)
            %load_level_palette_file(crimson_house)
            %load_level_palette_file(golden_house)
            %load_level_palette_file(halloween_pallet)
            %load_level_palette_file(orange_lights)
            %load_level_palette_file(original_aqua)
            %load_level_palette_file(original_blue)
            %load_level_palette_file(original_dark)
            %load_level_palette_file(original_white)
        ;# $16 ghost_house_exit
            %init_level_group(ghost_house_exit)
            %load_level_palette_file(evening_exit)
            %load_level_palette_file(golden_house)
            %load_level_palette_file(original)
            %load_level_palette_file(original_blue_door)
            %load_level_palette_file(underwater)
        ;# $17 ship_exterior
            %init_level_group(ship_exterior)
            %load_level_palette_file(blue_purple)
            %load_level_palette_file(doc_ship)
            %load_level_palette_file(grey_ship)
            %load_level_palette_file(original)
            %load_level_palette_file(reddish)
        ;# $18 ship_interior
            %init_level_group(ship_interior)
            %load_level_palette_file(blue_purple)
            %load_level_palette_file(bocchi_hitori)
            %load_level_palette_file(bocchi_rock)
            %load_level_palette_file(brawler)
            %load_level_palette_file(grey_ship)
            %load_level_palette_file(original)
        ;# $19 switch_palace
            %init_level_group(switch_palace)
            %load_level_palette_file(blue_grid)
            %load_level_palette_file(brawler_brown)
            %load_level_palette_file(cafe_claro)
            %load_level_palette_file(color_del_gato_2)
            %load_level_palette_file(color_de_gato)
            %load_level_palette_file(green_grid)
            %load_level_palette_file(gris)
            %load_level_palette_file(mario_pants)
            %load_level_palette_file(monado)
            %load_level_palette_file(morado)
            %load_level_palette_file(negro)
            %load_level_palette_file(onigiria)
            %load_level_palette_file(original)
            %load_level_palette_file(original_bonus)
            %load_level_palette_file(pink)
            %load_level_palette_file(red_grid)
            %load_level_palette_file(verde)
            %load_level_palette_file(verde_agua)
            %load_level_palette_file(yellow_grid)
            %load_level_palette_file(youbonus)
        ;# $1A yoshi_house
            %init_level_group(yoshi_house)
            %load_level_palette_file(atardecer)
            %load_level_palette_file(brawler_green)
            %load_level_palette_file(choco)
            %load_level_palette_file(crimson)
            %load_level_palette_file(miku)
            %load_level_palette_file(mogumogu)
            %load_level_palette_file(monocromo)
            %load_level_palette_file(neon)
            %load_level_palette_file(nieve)
            %load_level_palette_file(night)
            %load_level_palette_file(nocturno)
            %load_level_palette_file(original)
            %load_level_palette_file(sakura)
            %load_level_palette_file(snow)
            %load_level_palette_file(strong_sun)
            %load_level_palette_file(sunsetish_grass_hills)

pullpc

pushpc
    !i #= 0
    !j #= 0
    !_bank_palette_count #= 0
    org !custom_map_palettes
        ;# $00 main
            %init_map_group(main)
            %load_map_palette_file(atardecer)
            %load_map_palette_file(brawler)
            %load_map_palette_file(cake_frosting)
            %load_map_palette_file(invertido)
            %load_map_palette_file(mono)
            %load_map_palette_file(morning)
            %load_map_palette_file(night)
            %load_map_palette_file(night_time)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(sepia)
            %load_map_palette_file(snow_day)
        ;# $01 yoshi
            %init_map_group(yoshi)
            %load_map_palette_file(atardecer)
            %load_map_palette_file(gum)
            %load_map_palette_file(lava_island)
            %load_map_palette_file(mono)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(sepia)
            %load_map_palette_file(snow_day)
            %load_map_palette_file(sunset)
            %load_map_palette_file(tritanopia)
            %load_map_palette_file(yochis_ailand)
        ;# $02 vanilla
            %init_map_group(vanilla)
            %load_map_palette_file(aqua_marine)
            %load_map_palette_file(dark_cave)
            %load_map_palette_file(DOMO)
            %load_map_palette_file(fire_cave)
            %load_map_palette_file(gold_mine)
            %load_map_palette_file(invertido)
            %load_map_palette_file(mono)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(purple)
            %load_map_palette_file(sepia)
            %load_map_palette_file(witches_cauldron)
        ;# $03 forest
            %init_map_group(forest)
            %load_map_palette_file(atardecer)
            %load_map_palette_file(burnt_forest)
            %load_map_palette_file(dark_forest)
            %load_map_palette_file(halloween)
            %load_map_palette_file(ice_forest)
            %load_map_palette_file(lost_woods)
            %load_map_palette_file(mono)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(sepia)
            %load_map_palette_file(snow_day)
        ;# $04 valley
            %init_map_group(valley)
            %load_map_palette_file(bowser)
            %load_map_palette_file(castle_colors)
            %load_map_palette_file(dark_cave)
            %load_map_palette_file(dream_world)
            %load_map_palette_file(fire_cave)
            %load_map_palette_file(invertido)
            %load_map_palette_file(mono)
            %load_map_palette_file(orange)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(purple_blue)
            %load_map_palette_file(sepia)
            %load_map_palette_file(snow)
            %load_map_palette_file(Tamaulipas)
        ;# $05 special
            %init_map_group(special)
            %load_map_palette_file(black_out)
            %load_map_palette_file(blood_star)
            %load_map_palette_file(brawler)
            %load_map_palette_file(green)
            %load_map_palette_file(light_pollution_map)
            %load_map_palette_file(original)
            %load_map_palette_file(purple)
            %load_map_palette_file(white_special)
        ;# $06 star
            %init_map_group(star)
            %load_map_palette_file(blood_moon)
            %load_map_palette_file(mono)
            %load_map_palette_file(mountain_top)
            %load_map_palette_file(original)
            %load_map_palette_file(original_special)
            %load_map_palette_file(pink_star)
            %load_map_palette_file(sepia)
            %load_map_palette_file(yellow_star)
pullpc

