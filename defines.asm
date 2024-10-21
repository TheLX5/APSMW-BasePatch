;# Print options

!print_palette_info = 0

!sa1_ram = $404000
!snes_ram = $7FA000

!SprSize = 22
!ExtendedSize = 10
!ClusterSize = 20
!BounceSize = 4

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
reset_traps_setting         = $03BFB6


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

!reverse_controls_trap = !game_ram+$0300
!reset_reverse_controls_trap = !game_ram+$0301
!thwimp_trap = !game_ram+$0302
!thwimp_index = !game_ram+$0303
!reset_thwimp_trap = !game_ram+$0304
!fishin_boo_trap = !game_ram+$0305
!fishin_boo_index = !game_ram+$0306
!reset_fishin_boo_trap = !game_ram+$0307
!ice_trap = !game_ram+$0308
!reset_ice_trap = !game_ram+$0309

;# Item Goal Count

!goal_item_count = !game_ram+$001E

;# Received items

!received_items_count = $1F2B|!addr

;# SRAM definitions

!sram = $41A000

!level_clears_sram          = !sram+$000
!yoshi_coins_sram           = !sram+$100
!moons_sram                 = !sram+$110
!checkpoints_sram           = !sram+$120
!bonus_block_sram           = !sram+$130
!blocksanity_sram           = !sram+$140
!goal_item_count_sram       = !sram+$154
!blocksanity_data_sram      = !sram+$200
!inventory_sram             = !sram+$700
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
!message_box_buffer = !game_ram+$1000


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

!bounce_num = $1699|!addr
!extended_num = $170B|!addr
!cluster_num = $1892|!addr

;#########################################################################
;# Customization defines

;# How many tiles from the queue will be uploaded per frame
    !dss_queue_tiles = 5

;# How many frames are needed to mark a GFX as unused
    !dss_time_to_unmark_gfx = 30

;# Main RAM defines
;# Requires at least 1873 (0x751) bytes of consecutive free RAM
;# or you could edit the defines below to make some of them not consecutive
    !dss_ram = $40C000

;#########################################################################
;# Remap stuff

    !small_wing_tile            = $5D
    !big_wing_tile              = $4E

    !lava_particle_large_tile   = $42
    !lava_particle_medium_tile  = $52
    !lava_particle_small_tile   = $43
    !lava_particle_tiny_tile    = $53

    !spinjump_star_tile         = $28

    !glitter_large_tile         = $4C
    !glitter_medium_tile        = $6E
    !glitter_small_tile         = $4D
    !glitter_tiny_tile          = $66

    !sparkle_large_tile         = $5C
    !sparkle_medium_tile        = $6C
    !sparkle_small_tile         = $6D

    !smoke_large_tile           = $60
    !smoke_medium_tile          = $62
    !smoke_small_tile           = $64
    !smoke_tiny_tile            = $66

    !tiny_smoke_large_tile      = $62
    !tiny_smoke_medium_tile     = $64
    !tiny_smoke_small_tile      = $66

    !broken_brick_1_tile        = $3C
    !broken_brick_2_tile        = $3D

    !yoshi_tongue_tip_tile      = $48
    !yoshi_tongue_body_tile     = $49
    !yoshi_throat_tile          = $58
    !yoshi_egg_tile             = $59
    !yoshi_fire_1_tile          = $8C
    !yoshi_fire_2_tile          = $8E

    !berry_tile                 = $80

    !coin_large_tile            = $24
    !coin_rotating_tile         = $26
    !coin_slim_tile             = $36

    !cloud_face_tile            = $6F

    !explosion_tile             = $27

    !water_bubble_tile          = $37

    !question_block_tile        = $2A
    !brown_block_tile           = $2E
    !turn_block_tile            = $40
    !note_block_tile            = $86
    !glass_block_tile           = $88
    !on_off_block_tile          = $8A

;####################################################################
;# RAM defines

;# Map of used 16x16 tiles in SP3-SP4.
;# Each entry has an 9-bit ID, useful to quickly compare data
;# The ID is separated across two different blocks of ram.
;# 64 bytes each
    !dss_map #= !dss_ram

;# List of IDs of the currently loaded GFX files.
;# FF = Invalid GFX
;# 32 bytes
    !dss_list #= !dss_map+64

;# Timer to mark as unused each GFX file
;# Each GFX is marked as unused after 16 frames of being unused
;# This is customizable in a global basis
;# 32 bytes
    !dss_list_timer #= !dss_list+32

;# Amount of tiles used by each loaded GFX
;# 32 bytes
    !dss_gfx_size #= !dss_list_timer+32

;# ExGFX usage map
;# How many times each GFX was searched within a frame, if zero, the timer will start to tick down.
;# 32 bytes
    !dss_list_usage #= !dss_gfx_size+32

;# Array containing tile number for the latest loaded/searched ExGFX file
;# 32 bytes
    !dss_tile_buffer #= !dss_list_usage+32

;# Array of arrays containing tile numbers for each GFX loaded
;# 1024 bytes
    !dss_tile_buffer_complete #= !dss_tile_buffer+32

;# Index used to select one of the eight possible buffers to decompress RAM to
;# 1 byte
    !dss_ram_buffer_index #= !dss_tile_buffer_complete+1024

;# Holds the maximum amount of tiles used by DSS.
;# Can be modified. Can't be over 64 or bad things will happen.
;# 1 byte
    !dss_maximum_tiles #= !dss_ram_buffer_index+1

;# Holds the current amount of tiles used by DSS
;# It can't exceed !dss_maximum_tiles
;# 1 byte
    !dss_loaded_tiles #= !dss_maximum_tiles+1

;# Queue of pending graphics to be uploaded to VRAM
;# The values are supposed to be VRAM locations for each 16x16 tile needed to be uploaded to VRAM
;# Up to 32 tiles can be put in queue, but only a certain amount will be uploaded each frame which
;# is determined by !dss_queue_tiles
;# Format:
;#      Byte 1-2: VRAM destination
;#      Byte 3-4: RAM GFX buffer location
;# 256 bytes
    !dss_gfx_queue #= !dss_loaded_tiles+1
    !dss_gfx_queue_vram #= !dss_gfx_queue
    !dss_gfx_queue_source_row_1 #= !dss_gfx_queue+2
    !dss_gfx_queue_source_row_2 #= !dss_gfx_queue+5

;# Index for the GFX upload queue. 
    !dss_gfx_queue_index_nmi #= !dss_gfx_queue+256
    !dss_gfx_queue_index_game #= !dss_gfx_queue_index_nmi+2

;# Map of possible VRAM destinations for sprite tiles
;# FF is treated as invalid.
;# 64 bytes
    !dss_vram_dest #= !dss_gfx_queue_index_game+2

;# 16-bit table which contains the last queue index written to for the current
;# GFX.
;# 64 bytes
    !dss_list_queue_index = !dss_vram_dest+64

;# List of flags for each item in the GFX list to determine wheter the GFX has been loaded
;# or not
;# 32 bytes
    !dss_list_gfx_loaded = !dss_list_queue_index+64

;# Copy of the regular sprite number table ($9E)
;# 22 bytes
    !dss_regular_sprite_copy = !dss_list_gfx_loaded+64

;# Copy of the extended sprite number table ($170B)
;# 10 bytes
    !dss_extended_sprite_copy = !dss_regular_sprite_copy+22

;# Copy of the cluster sprite table ($1892)
;# 20 bytes
    !dss_cluster_sprite_copy = !dss_extended_sprite_copy+10

;# Copy of the bounce sprite table ($1699)
;# 4 bytes
    !dss_bounce_sprite_copy = !dss_cluster_sprite_copy+20

;# Copy of the minor extended sprite table ($17F0)
;# 12 bytes
    !dss_minor_extended_sprite_copy = !dss_bounce_sprite_copy+4


;####################################################################
;# Spriteset defines

    !dss_id_koopa                   ?= $00
    !dss_id_koopa_shell             ?= $01
    !dss_id_shelless_koopa          ?= $02
    !dss_id_shelless_blue_koopa     ?= $03
    !dss_id_goomba                  ?= $04
    !dss_id_piranha_plant           ?= $05
    !dss_id_misc_tiles_1            ?= $06
    !dss_id_cheep_cheep             ?= $07
    !dss_id_spiny                   ?= $08
    !dss_id_lakitu                  ?= $09
    !dss_id_misc_tiles_2            ?= $0A
    !dss_id_bobomb                  ?= $0B
    !dss_id_bubble                  ?= $0C
    !dss_id_wiggler                 ?= $0D
    !dss_id_paragoomba              ?= $0E
    !dss_id_parabobomb              ?= $0F
    !dss_id_parachute               ?= $10
    !dss_id_football                ?= $11
    !dss_id_bullet_bill             ?= $12
    !dss_id_buzzy_beetle            ?= $13
    !dss_id_hopping_flame           ?= $14
    !dss_id_vertical_growing_pipe   ?= $15
    !dss_id_spike_top               ?= $16
    !dss_id_swooper_bat             ?= $17
    !dss_id_blarrg                  ?= $18
    !dss_id_floating_skull          ?= $19
    !dss_id_piranha_plant_stem      ?= $1A
    !dss_id_ninji                   ?= $1B
    !dss_id_mega_mole               ?= $1C
    !dss_id_banzai_bill             ?= $1D
    !dss_id_volcano_lotus           ?= $1E
    !dss_id_pokey                   ?= $1F
    !dss_id_rex                     ?= $20
    !dss_id_monty_mole              ?= $21
    !dss_id_sumo_bro                ?= $22
    !dss_id_sumo_bro_lightning      ?= $23
    !dss_id_fire_pillar             ?= $24
    !dss_id_bony_beetle             ?= $25
    !dss_id_dry_bones               ?= $26
    !dss_id_bones                   ?= $27
    !dss_id_bone_projectile         ?= $28
    !dss_id_fishbone                ?= $29
    !dss_id_thwomp                  ?= $2A
    !dss_id_thwimp                  ?= $2B
    !dss_id_magikoopa               ?= $2C
    !dss_id_magikoopa_magic         ?= $2D
    !dss_id_ball_n_chain            ?= $2E
    !dss_id_castle_block            ?= $2F
    !dss_id_net_koopa               ?= $30
    !dss_id_hothead                 ?= $31
    !dss_id_sparky                  ?= $32
    !dss_id_climbing_net            ?= $33
    !dss_id_grinder                 ?= $34
    !dss_id_wooden_spike            ?= $35
    !dss_id_bowser_statue           ?= $36
    !dss_id_bowser_statue_flame     ?= $37
    !dss_id_reflecting_fireball     ?= $38
    !dss_id_background_flames       ?= $39
    !dss_id_falling_spike           ?= $3A
    !dss_id_eerie                   ?= $3B
    !dss_id_boo                     ?= $3C
    !dss_id_boo_block               ?= $3D
    !dss_id_big_boo                 ?= $3E
    !dss_id_fishing_boo             ?= $3F
    !dss_id_chuck_head              ?= $40
    !dss_id_chuck_body              ?= $41
    !dss_id_chuck_pitchin_puntin    ?= $42
    !dss_id_chuck_diggin            ?= $43
    !dss_id_chuck_rock              ?= $44
    !dss_id_motor                   ?= $45
    !dss_id_chainsaw                ?= $46
    !dss_id_rope                    ?= $47
    !dss_id_fuzzy                   ?= $48
    !dss_id_blurp                   ?= $49
    !dss_id_rip_van_fish            ?= $4A
    !dss_id_horizontal_dolphin      ?= $4B
    !dss_id_vertical_dolphin        ?= $4C
    !dss_id_torpedo_ted             ?= $4D
    !dss_id_torpedo_ted_hand        ?= $4E
    !dss_id_urchin                  ?= $4F
    !dss_id_porcupuffer             ?= $50
    !dss_id_super_koopa             ?= $51
    !dss_id_mushroom_scale          ?= $52
    !dss_id_rock_platform           ?= $53
    !dss_id_orange_platform         ?= $54
    !dss_id_spiky_balls             ?= $55
    !dss_id_goal_question_sphere    ?= $56
    !dss_id_springboard             ?= $57
    !dss_id_disco_ball              ?= $58
    !dss_id_hammer_bro              ?= $59
    !dss_id_hammer_projectile       ?= $5A
    !dss_id_carrot_platform         ?= $5B
    !dss_id_timed_platform          ?= $5C
    !dss_id_dino_rhino              ?= $5D
    !dss_id_dino_torch              ?= $5E
    !dss_id_dino_fire               ?= $5F
    !dss_id_mechakoopa              ?= $60
    !dss_id_bowling_ball            ?= $61
    !dss_id_brown_platform          ?= $62
    !dss_id_brown_platform_chain    ?= $63
    !dss_id_smiling_coin            ?= $64
    !dss_id_checkerboard_platform   ?= $65
    !dss_id_reznor                  ?= $66
    !dss_id_yoshi_eggs              ?= $67
    !dss_id_ludwig_fireball         ?= $68
    !dss_id_reznor_fireball         ?= $69
    !dss_id_balls                   ?= $6A
    !dss_id_reznor_platform         ?= $6B
    !dss_id_podoboo                 ?= $6C
    !dss_id_gas_bubble              ?= $6D
    !dss_id_moving_hole             ?= $6E
    !dss_id_red_coin                ?= $6F
    !dss_id_key                     ?= $70
    !dss_id_keyhole                 ?= $71
    !dss_id_goal_tape               ?= $72
    !dss_id_p_switch                ?= $73
    !dss_id_info_fox                ?= $74
    !dss_id_question_block          ?= $75
    !dss_id_turn_block              ?= $76
    !dss_id_used_block              ?= $77
    !dss_id_on_off_bounce_block     ?= $78
    !dss_id_note_block              ?= $79
    !dss_id_glass_block             ?= $7A
    !dss_id_            ?= $7B
    !dss_id_            ?= $7C
    !dss_id_            ?= $7D
    !dss_id_            ?= $7E
    !dss_id_            ?= $7F
    !dss_id_            ?= $80
    !dss_id_            ?= $81
    !dss_id_            ?= $82
    !dss_id_            ?= $83
    !dss_id_            ?= $84
    !dss_id_            ?= $85
    !dss_id_            ?= $86
    !dss_id_            ?= $87
    !dss_id_            ?= $88
    !dss_id_            ?= $89
    !dss_id_            ?= $8A
    !dss_id_            ?= $8B
    !dss_id_            ?= $8C
    !dss_id_            ?= $8D
    !dss_id_            ?= $8E
    !dss_id_            ?= $8F
    !dss_id_            ?= $90
    !dss_id_            ?= $91
    !dss_id_            ?= $92
    !dss_id_            ?= $93
    !dss_id_            ?= $94
    !dss_id_            ?= $95
    !dss_id_            ?= $96
    !dss_id_            ?= $97
    !dss_id_            ?= $98
    !dss_id_            ?= $99
    !dss_id_            ?= $9A
    !dss_id_            ?= $9B
    !dss_id_            ?= $9C
    !dss_id_            ?= $9D
    !dss_id_            ?= $9E
    !dss_id_            ?= $9F
    !dss_id_            ?= $A0
    !dss_id_            ?= $A1
    !dss_id_            ?= $A2
    !dss_id_            ?= $A3
    !dss_id_            ?= $A4
    !dss_id_            ?= $A5
    !dss_id_            ?= $A6
    !dss_id_            ?= $A7
    !dss_id_            ?= $A8
    !dss_id_            ?= $A9
    !dss_id_            ?= $AA
    !dss_id_            ?= $AB
    !dss_id_            ?= $AC
    !dss_id_            ?= $AD
    !dss_id_            ?= $AE
    !dss_id_            ?= $AF
    !dss_id_            ?= $B0
    !dss_id_            ?= $B1
    !dss_id_            ?= $B2
    !dss_id_            ?= $B3
    !dss_id_            ?= $B4
    !dss_id_            ?= $B5
    !dss_id_            ?= $B6
    !dss_id_            ?= $B7
    !dss_id_            ?= $B8
    !dss_id_            ?= $B9
    !dss_id_            ?= $BA
    !dss_id_            ?= $BB
    !dss_id_            ?= $BC
    !dss_id_            ?= $BD
    !dss_id_            ?= $BE
    !dss_id_            ?= $BF
    !dss_id_            ?= $C0
    !dss_id_            ?= $C1
    !dss_id_            ?= $C2
    !dss_id_            ?= $C3
    !dss_id_            ?= $C4
    !dss_id_            ?= $C5
    !dss_id_            ?= $C6
    !dss_id_            ?= $C7
    !dss_id_            ?= $C8
    !dss_id_            ?= $C9
    !dss_id_            ?= $CA
    !dss_id_            ?= $CB
    !dss_id_            ?= $CC
    !dss_id_            ?= $CD
    !dss_id_            ?= $CE
    !dss_id_            ?= $CF
    !dss_id_            ?= $D0
    !dss_id_            ?= $D1
    !dss_id_            ?= $D2
    !dss_id_            ?= $D3
    !dss_id_            ?= $D4
    !dss_id_            ?= $D5
    !dss_id_            ?= $D6
    !dss_id_            ?= $D7
    !dss_id_            ?= $D8
    !dss_id_            ?= $D9
    !dss_id_            ?= $DA
    !dss_id_            ?= $DB
    !dss_id_            ?= $DC
    !dss_id_            ?= $DD
    !dss_id_            ?= $DE
    !dss_id_            ?= $DF
    !dss_id_mushroom                ?= $E0
    !dss_id_fire_flower             ?= $E1
    !dss_id_feather                 ?= $E2
    !dss_id_star                    ?= $E3
    !dss_id_p_balloon               ?= $E4
    !dss_id_            ?= $E5
    !dss_id_            ?= $E6
    !dss_id_            ?= $E7
    !dss_id_            ?= $E8
    !dss_id_            ?= $E9
    !dss_id_            ?= $EA
    !dss_id_            ?= $EB
    !dss_id_            ?= $EC
    !dss_id_            ?= $ED
    !dss_id_            ?= $EE
    !dss_id_            ?= $EF
    !dss_id_            ?= $F0
    !dss_id_            ?= $F1
    !dss_id_            ?= $F2
    !dss_id_            ?= $F3
    !dss_id_            ?= $F4
    !dss_id_            ?= $F5
    !dss_id_            ?= $F6
    !dss_id_            ?= $F7
    !dss_id_            ?= $F8
    !dss_id_            ?= $F9
    !dss_id_            ?= $FA
    !dss_id_            ?= $FB
    !dss_id_yoshi_fireball          ?= $FC
    !dss_id_            ?= $FD
    !dss_id_bonus_box               ?= $FE
    !dss_id_null                    ?= $FF










