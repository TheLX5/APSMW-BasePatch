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

org $00A273
    db $00

org $1C8000
    player_gfx:
        incbin "./debug/player.bin"

org $1CE000
    player_extended_gfx:
        incbin "./debug/player_extra.bin"

org $1D8000
    animated_tiles:
        incbin "./debug/yoshi+anim.bin"

org $1CE400
    player_map:
        incbin "./debug/player_map.bin"

org $1CEC00
    player_name:
        incbin "./debug/player_name.bin"
        
org $00B0A0
    shared_palette:
        incbin "./debug/shared.mw3":($000)..($7E0)

org $1CEC50
    map_palette:
        incbin "./debug/map.mw3"
org $03BFB5
    db $01

org $1DC000
    inventory_items:
        incbin "./debug/map_sprites.bin"

check bankcross off
org $208000
    sprite_graphics:
        incbin "./debug/sprite_graphics.bin"
check bankcross half

org $2F8000
    sprite_page_1:
        incbin "./debug/sprite_page_1.bin"
org $2F9000
    sprite_page_2:
        incbin "./debug/sprite_page_2.bin"