;##################################################################################################
;# SMW AP Base patch
;# ASM made by PoryGone & lx5
;# 
;# All the static ASM/ROM data for SMW's AP implementation can be found here.

;#########################################################################
;# Basic imports/setup

lorom

incsrc "defines.asm"

;#########################################################################
;# AP Settings defaults

org goal_setting
    db 0

org required_bosses_setting
    db 7

org required_yoshi_eggs_setting
    db 50

org dragon_coin_enabled_flag
    db 0

org moon_enabled_flag
    db 0

org checkpoints_enabled_flag
    db 0

org bonus_block_enabled_flag
    db 0

org blocksanity_enabled_flag
    db 0

org level_palette_setting
    db 0

org map_palette_setting
    db 0

org player_setting
    db 0

org level_shuffle_active
    db 0

;#########################################################################
;# ROM expansion

;# ROM is now 1MiB
org $00FFD7
    db $0A
org $1FFFFF
    db $FF

;########################################################################
;# Code imports


org !data_location
    incsrc "data_tables.asm"

org !custom_level_palettes_ptrs
    level_palette_pointers:

org !custom_map_palettes_ptrs
    map_palette_pointers:
    
org !main_code_location
    incsrc "fastrom.asm"
    incsrc "sram.asm"
    incsrc "general.asm"
    incsrc "overworld.asm"
    incsrc "locations.asm"
    incsrc "abilities.asm"
    incsrc "traps.asm"
    incsrc "palette_loader.asm"
    incsrc "score_sprites.asm"
    incsrc "graphics.asm"
