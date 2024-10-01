;##################################################################################################
;# SMW AP Base patch
;# ASM made by PoryGone & lx5 (& other people)
;# 
;# All the static ASM/ROM data for SMW's AP implementation can be found here.

;#########################################################################
;# Basic imports/setup

if read1($00FFD5) == $23
    sa1rom
    !sa1 = 1
    !dp = $3000
    !addr = $6000
    !bank = $000000
else
    lorom
    !sa1 = 0
    !dp = $0000
    !addr = $0000
    !bank = $800000
endif

incsrc "defines.asm"

;#########################################################################
;# AP Settings defaults


;########################################################################
;# Code imports


org !data_location
    incsrc "data/data_tables.asm"

org !custom_level_palettes_ptrs
    level_palette_pointers:

org !custom_map_palettes_ptrs
    map_palette_pointers:
    
; TODO: Resolver problemas del OW en SA-1 (probablemente sea overworld.asm)

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
