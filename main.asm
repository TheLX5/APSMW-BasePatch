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
    incsrc "data/data_tables.asm"

org !custom_level_palettes_ptrs
    level_palette_pointers:

org !custom_map_palettes_ptrs
    map_palette_pointers:
    
org !main_code_location
    incsrc "code/fastrom.asm"
    incsrc "code/sram.asm"
    incsrc "code/general.asm"
    incsrc "code/overworld.asm"
    incsrc "code/locations.asm"
    incsrc "code/abilities.asm"
    incsrc "code/traps.asm"
    incsrc "code/level.asm"
    incsrc "code/palette_loader.asm"
    incsrc "code/score_sprites.asm"
    incsrc "code/graphics.asm"
    incsrc "code/inventory.asm"
    incsrc "code/irq.asm"

;org $00A273
;    db $00
