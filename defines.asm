;# Print options

!print_palette_info = 0

;# Archipelago settings ROM addreses

goal_setting                = $03BFA0
required_bosses_setting     = $03BFA1
required_yoshi_eggs_setting = $03BFA2
dragon_coin_enabled_flag    = $03BFA6
moon_enabled_flag           = $03BFA8
checkpoints_enabled_flag    = $03BFA9
bonus_block_enabled_flag    = $03BFAA
blocksanity_enabled_flag    = $03BFAB
level_palette_setting       = $03BFAC
map_palette_setting         = $03BFAD
player_setting              = $03BFAE
level_shuffle_active        = $03BFB0
block_collect_behavior      = $03BFB1
block_visual_indicator      = $03BFB2
block_contents              = $03BFB3

;# Code & Data locations

!main_code_location = $108000
!data_location = $118000
!custom_level_palettes_ptrs = $128000
!custom_map_palettes_ptrs = $12E000
!custom_map_palettes = $138000
!custom_level_palettes = $158000

;# Items

!ability_byte_1 = $1F1C
!ability_byte_2 = $1F2D

;# Items

!blocksanity_locs = 582

!current_room       = $010B
!current_ow_level   = $13BF
!shuffled_ow_level  = $010D

;# Overworld indicators defines

!icon_obtained      = $3F
!icon_not_obtained  = $5E
!icon_disabled      = $1F

!vram_level_data_top = $503D
!vram_level_data_mid = $505D
!vram_level_data_bot = $507D

!vram_abilities_top = $5027
!vram_abilities_mid = $5047
!vram_abilities_bot = $5067

!vram_switches_top = $5032
!vram_switches_mid = $5052
!vram_switches_bot = $5072

;# Overworld indicators RAM

!randomized_ow_level = $60

!ow_tilemap_abilities       = $7FA100
!ow_tilemap_switches        = $7FA120
!ow_tilemap_flags_top       = $7FA140
!ow_tilemap_flags_mid       = $7FA160
!ow_tilemap_flags_bot       = $7FA180
!ow_tilemap_goal            = $7FA1C0

;# Flags

!special_world_clear_flag   = $1F1E
!level_clears               = $7FA200
!bonus_block_flags          = $7FA000
!blocksanity_flags          = $7FA010
!blocksanity_data_flags     = $7FA400
!yoshi_coins_flags          = $1F2F
!checkpoints_flags          = $1F3C
!moons_flags                = $1FEE

;# Score sprite RAM

!score_sprite_sram              = $7FB000
!score_sprite_count             = !score_sprite_sram
!score_sprite_index             = !score_sprite_sram+$02
!score_sprite_add_1_coin        = !score_sprite_sram+$04
!score_sprite_add_5_coins       = !score_sprite_sram+$06
!score_sprite_add_10_coins      = !score_sprite_sram+$08
!score_sprite_add_15_coins      = !score_sprite_sram+$0A
!score_sprite_add_yoshi_egg     = !score_sprite_sram+$0C
!score_sprite_add_boss_token    = !score_sprite_sram+$0E
!score_sprite_add_1up           = !score_sprite_sram+$10
!score_sprite_add_mushroom      = !score_sprite_sram+$12
!score_sprite_add_flower        = !score_sprite_sram+$14
!score_sprite_add_feather       = !score_sprite_sram+$16
!score_sprite_queue_delay       = !score_sprite_sram+$20
!score_sprite_queue             = !score_sprite_sram+$22

;# Extra Sprite Tables

!sprite_blocksanity_x_lo = $7FB800
!sprite_blocksanity_x_hi = $7FB810
!sprite_blocksanity_y_lo = $7FB820
!sprite_blocksanity_y_hi = $7FB830

;# Traps RAM

!reverse_controls_trap = $18B4
!thwimp_trap = $18B7
!thwimp_index = $0F3C

;# Item Goal Count

!goal_item_count = $7FA01E

;# Received items

!received_items_count = $1F2B

;# SRAM definitions

!level_clears_sram          = $700800
!yoshi_coins_sram           = $700900
!moons_sram                 = $700910
!checkpoints_sram           = $700920
!bonus_block_sram           = $700930
!blocksanity_sram           = $700940
!goal_item_count_sram       = $700954
!blocksanity_data_sram      = $700A00

;# 

!score_sprite_num = $16E1
!score_sprite_y_lo = $16E7
!score_sprite_x_lo = $16ED
!score_sprite_x_hi = $16F3
!score_sprite_y_hi = $16F9
!score_sprite_timer = $16FF
!score_sprite_layer = $1705

