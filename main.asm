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
;# ROM expansion

;# ROM is now 1MiB
org $00FFD7
    db $0A
org $1FFFFF
    db $FF

;########################################################################
;# Code imports

org !main_code_location
    incsrc "fastrom.asm"
    incsrc "sram.asm"
    incsrc "locations.asm"
    incsrc "overworld.asm"
    incsrc "abilities.asm"
    incsrc "palette_loader.asm"
    incsrc "score_sprites.asm"
    incsrc "player_graphics.asm"
    incsrc "data_tables.asm"
