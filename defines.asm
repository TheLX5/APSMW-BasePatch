;# Print options

!print_palette_info = 0

!sa1_ram = $404000
!snes_ram = $7FA000

if !sa1 == 0
    !game_ram = !snes_ram
else
    !game_ram = !sa1_ram
endif

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
energy_link                 = $03BFB4
sprite_map_colors           = $03BFB5

;# Code & Data locations

!main_code_location = $108000
!data_location = $118000
!custom_level_palettes_ptrs = $138000
!custom_map_palettes_ptrs = $13E000
!custom_map_palettes = $148000
!custom_level_palettes = $168000

;# Items

!ability_byte_1 = $1F1C|!addr
!ability_byte_2 = $1F2D|!addr

;# Items

!blocksanity_locs = 582

!current_room       = $010B|!addr
!current_ow_level   = $13BF|!addr
!shuffled_ow_level  = $010D|!addr

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

!ow_tilemap_abilities       = !game_ram+$1000
!ow_tilemap_switches        = !game_ram+$1020
!ow_tilemap_flags_top       = !game_ram+$1040
!ow_tilemap_flags_mid       = !game_ram+$1060
!ow_tilemap_flags_bot       = !game_ram+$1080
!ow_tilemap_goal            = !game_ram+$10C0

;# Flags

!special_world_clear_flag   = $1F1E|!addr
!level_clears               = !game_ram+$0200
!bonus_block_flags          = !game_ram+$0000
!blocksanity_flags          = !game_ram+$0010
!blocksanity_data_flags     = !game_ram+$0400
!yoshi_coins_flags          = $1F2F|!addr
!checkpoints_flags          = $1F3C|!addr
!moons_flags                = $1FEE|!addr

;# Score sprite RAM

!score_sprite_sram              = !game_ram+$0800
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
!score_sprite_add_star          = !score_sprite_sram+$18
!score_sprite_add_green_yoshi   = !score_sprite_sram+$1A
!score_sprite_add_red_yoshi   = !score_sprite_sram+$1C
!score_sprite_add_blue_yoshi   = !score_sprite_sram+$1E
!score_sprite_add_yellow_yoshi   = !score_sprite_sram+$20
!score_sprite_queue_delay       = !score_sprite_sram+$40
!score_sprite_queue             = !score_sprite_sram+$42

;# Extra Sprite Tables

!sprite_blocksanity_x_lo = !game_ram+$0900
!sprite_blocksanity_x_hi = !game_ram+$0920
!sprite_blocksanity_y_lo = !game_ram+$0930
!sprite_blocksanity_y_hi = !game_ram+$0940

;# Traps RAM

!reverse_controls_trap = $18B4|!addr
!thwimp_trap = $18B7|!addr
!thwimp_index = $0F3C|!addr

;# Item Goal Count

!goal_item_count = !game_ram+$001E

;# Received items

!received_items_count = $1F2B|!addr

;# SRAM definitions

!sram = $41C800

!level_clears_sram          = !sram+$000
!yoshi_coins_sram           = !sram+$100
!moons_sram                 = !sram+$110
!checkpoints_sram           = !sram+$120
!bonus_block_sram           = !sram+$130
!blocksanity_sram           = !sram+$140
!goal_item_count_sram       = !sram+$154
!blocksanity_data_sram      = !sram+$200
!inventory_sram             = !sram+$0F0
!death_counter_sram         = !sram+$800
!coin_counter_sram          = !sram+$803

;# Score Sprites

!score_sprite_num = $16E1|!addr
!score_sprite_y_lo = $16E7|!addr
!score_sprite_x_lo = $16ED|!addr
!score_sprite_x_hi = $16F3|!addr
!score_sprite_y_hi = $16F9|!addr
!score_sprite_timer = $16FF|!addr
!score_sprite_layer = $1705|!addr

;# Inventory RAM

!inventory_cursor       = $57   ; The inventory cursor index, 1 byte.
!inventory_direction    = $59   ; The inventory direction, 1 byte.
!inventory_timer        = $5A   ; The inventory timer, 1 byte.
!inventory_y_pos        = $5B   ; The inventory Y position + 32, 1 byte.
!inventory_disabled_item = $5C
!vram_backup            = $7ED800   ; Backup for overwritten layer 1 tilemap, 512 bytes.
!vram_backup            = !game_ram+$2000   ; Backup for overwritten layer 1 tilemap, 512 bytes.
!star_power		= $1DEF|!addr			; The star power flag, 1 byte. CHANGE THIS IF NEEDED!

;# Stat trackers
;# All of them are in decimal mode except EL

!death_counter = !game_ram+$0C00
!coin_counter = !game_ram+$0C03

!energy_link_transfer = !game_ram+$0C06
!energy_link_purchase = !game_ram+$0C08
!energy_link_item = !game_ram+$0C0A
!energy_link_reply = !game_ram+$0C0B
!energy_link_count = !game_ram+$0C0C

;# 

!message_box_buffer = $7EC200
!message_box_buffer = !game_ram+$0B00


macro define_ram_addr(name, name2, addr, addr_sa1)
if !sa1 == 0
    !<name> = <addr>
else
    !<name> = <addr_sa1>
endif
    !<name2> = !<name>
endmacro

; Regular sprite tables
%define_ram_addr(sprite_num, "9E", $9E, $3200)
%define_ram_addr(sprite_speed_y, "AA", $AA, $9E)
%define_ram_addr(sprite_speed_x, "B6", $B6, $B6)
%define_ram_addr(sprite_misc_c2, "C2", $C2, $D8)
%define_ram_addr(sprite_y_low, "D8", $D8, $3216)
%define_ram_addr(sprite_x_low, "E4", $E4, $322C)

%define_ram_addr(sprite_num_16bit, "009E", $009E, $3200)
%define_ram_addr(sprite_speed_y_16bit, "00AA", $00AA, $309E)
%define_ram_addr(sprite_speed_x_16bit, "00B6", $00B6, $30B6)
%define_ram_addr(sprite_misc_c2_16bit, "00C2", $00C2, $30D8)
%define_ram_addr(sprite_y_low_16bit, "00D8", $00D8, $3216)
%define_ram_addr(sprite_x_low_16bit, "00E4", $00E4, $322C)

%define_ram_addr(sprite_status, "14C8", $14C8, $3242)
%define_ram_addr(sprite_y_high, "14D4", $14D4, $3258)
%define_ram_addr(sprite_x_high, "14E0", $14E0, $326E)
%define_ram_addr(sprite_speed_y_frac, "14EC", $14EC, $74C8)
%define_ram_addr(sprite_speed_x_frac, "14F8", $14F8, $74DE)
%define_ram_addr(sprite_misc_1504, "1504", $1504, $74F4)
%define_ram_addr(sprite_misc_1510, "1510", $1510, $750A)
%define_ram_addr(sprite_misc_151c, "151C", $151C, $3284)
%define_ram_addr(sprite_misc_1528, "1528", $1528, $329A)
%define_ram_addr(sprite_misc_1534, "1534", $1534, $32B0)
%define_ram_addr(sprite_misc_1540, "1540", $1540, $32C6)
%define_ram_addr(sprite_misc_154c, "154C", $154C, $32DC)
%define_ram_addr(sprite_misc_1558, "1558", $1558, $32F2)
%define_ram_addr(sprite_misc_1564, "1564", $1564, $3308)
%define_ram_addr(sprite_misc_1570, "1570", $1570, $331E)
%define_ram_addr(sprite_misc_157c, "157C", $157C, $3334)
%define_ram_addr(sprite_blocked_status, "1588", $1588, $334A)
%define_ram_addr(sprite_misc_1594, "1594", $1594, $3360)
%define_ram_addr(sprite_off_screen_horz, "15A0", $15A0, $3376)
%define_ram_addr(sprite_misc_15ac, "15AC", $15AC, $338C)
%define_ram_addr(sprite_slope, "15B8", $15B8, $7520)
%define_ram_addr(sprite_off_screen, "15C4", $15C4, $7536)
%define_ram_addr(sprite_being_eaten, "15D0", $15D0, $754C)
%define_ram_addr(sprite_obj_interact, "15DC", $15DC, $7562)
%define_ram_addr(sprite_oam_index, "15EA", $15EA, $33A2)
%define_ram_addr(sprite_oam_properties, "15F6", $15F6, $33B8)
%define_ram_addr(sprite_misc_1602, "1602", $1602, $33CE)
%define_ram_addr(sprite_misc_160e, "160E", $160E, $33E4)
%define_ram_addr(sprite_index_in_level, "161A", $161A, $7578)
%define_ram_addr(sprite_misc_1626, "1626", $1626, $758E)
%define_ram_addr(sprite_behind_scenery, "1632", $1632, $75A4)
%define_ram_addr(sprite_misc_163e, "163E", $163E, $33FA)
%define_ram_addr(sprite_in_water, "164A", $164A, $75BA)
%define_ram_addr(sprite_tweaker_1656, "1656", $1656, $75D0)
%define_ram_addr(sprite_tweaker_1662, "1662", $1662, $75EA)
%define_ram_addr(sprite_tweaker_166e, "166E", $166E, $7600)
%define_ram_addr(sprite_tweaker_167a, "167A", $167A, $7616)
%define_ram_addr(sprite_tweaker_1686, "1686", $1686, $762C)
%define_ram_addr(sprite_off_screen_vert, "186C", $186C, $7642)
%define_ram_addr(sprite_misc_187b, "187B", $187B, $3410)
%define_ram_addr(sprite_tweaker_190f, "190F", $190F, $7658)
%define_ram_addr(sprite_misc_1fd6, "1FD6", $1FD6, $766E)
%define_ram_addr(sprite_cape_disable_time, "1FE2", $1FE2, $7FD6)

; Map 16
%define_ram_addr(map16_lo, "7EC800", $7EC800, $40C800)
%define_ram_addr(map16_hi, "7FC800", $7FC800, $41C800)

; Other
%define_ram_addr(sprite_load_list, "1938", $1938, $418A00)
%define_ram_addr(sprite_wiggler_mem, "7F9A7B", $7F9A7B, $418800)
%define_ram_addr(sram_index, "700000", $700000, $41C000)

; Romi's Sprite Tool defines.
%define_ram_addr(sprite_extra_bits, "7FAB10", $7FAB10, $6040)
%define_ram_addr(sprite_new_code_flag, "7FAB1C", $7FAB1C, $6056) ;note that this is not a flag at all.
%define_ram_addr(sprite_extra_prop1, "7FAB28", $7FAB28, $6057)
%define_ram_addr(sprite_extra_prop2, "7FAB34", $7FAB34, $606D)
%define_ram_addr(sprite_custom_num, "7FAB9E", $7FAB9E, $6083)

; PIXI and GIEPY memory defines are not included. Updating this document would be appreciated.

; Macro for calling SA-1 CPU. Label should point to a routine which ends in RTL.
; Data bank is not set, so use PHB/PHK/PLB ... PLB in your SA-1 code.
macro invoke_sa1(label)
	LDA.b #<label>
	STA $3180
	LDA.b #<label>>>8
	STA $3181
	LDA.b #<label>>>16
	STA $3182
	JSR $1E80
endmacro

; Macro for calling SNES CPU (from SA-1 CPU). Label should point to a routine which ends in RTL.
; Data bank is not set automatically.
macro invoke_snes(addr)
	LDA.b #<addr>
	STA $0183
	LDA.b #<addr>/256
	STA $0184
	LDA.b #<addr>/65536
	STA $0185
	LDA #$D0
	STA $2209
-	LDA $018A
	BEQ -
	STZ $018A
endmacro
