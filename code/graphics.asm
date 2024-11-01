includefrom "main.asm"
;##################################################################################################
;# This file handles everything regarding player graphics

;##############################################################################
;# Pointers for graphics in the ROM

pushpc
    org $1C8000
        player_gfx:
    org $1CE000
        player_extended_gfx:
    org $1CEC00
        player_name:
    org $1CF000
        score_sprites_tiles:
    org $1D8000
        animated_tiles:
    org $1DB200
        inventory_gfx:
            incbin "../data/graphics/inventory_border.bin"
    org $1DC000
        inventory_items:
            ;incbin "../data/graphics/inventory_items.bin"
    org $1DD000
        gfx_blocks:
            incbin "../data/graphics/blocks.bin"
    org $1CF000
        gfx_indicators:

    org $208000
        sprite_graphics:

    org $2F8000
        sprite_page_1:
        
    org $2F9000
        sprite_page_2:
        
pullpc


;##############################################################################
;# Original player
;# A bunch of hacks made by Ladida to give us more VRAM for global graphics

pushpc
    org $00A300
        mario_gfx_dma:
            ldx #$04
            jsl player_code
            jsl nmi_gamemode_code
            rts

    org $00DF1A
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00

        db $00,$00,$00,$00,$00,$00,$28,$00
        db $00

        db $00,$00,$00,$00,$82,$82,$82,$00
        db $00,$00,$00,$00,$84,$00,$00,$00
        db $00,$86,$86,$86,$00,$00,$88,$88
        db $8A,$8A,$8C,$8C,$00,$00,$90,$00
        db $00,$00,$00,$8E,$00,$00,$00,$00
        db $92,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00

        db $00,$00,$00,$00,$82,$82,$82,$00
        db $00,$00,$00,$00,$84,$00,$00,$00
        db $00,$86,$86,$86,$00,$00,$88,$88
        db $8A,$8A,$8C,$8C,$00,$00,$90,$00
        db $00,$00,$00,$8E,$00,$00,$00,$00
        db $92,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00

    org $00DFDA
        db $00,$02,$80,$80      ;[00-03]
        db $00,$02,$0C,$0D      ;[04-07]

        chartilehijack:
            LDA $DF1A,y
            BPL +
            AND #$7F
            STA $0D
            LDA #$04
            +
            RTS
        capetilehijack:
            LDA $0D
            CPX #$2B
            BCC +
            CPX #$40
            BCS +
            LDA $E1D7,x
            +
            RTS

        db $FF,$FF			;[22-23]
        db $FF,$FF,$FF,$FF  ;[24-27]
        db $00,$02,$02,$80  ;[28-2B]	Balloon Mario
        db $04              ;[2C]		Cape
        db $0C,$0D          ;[2D-2E]	Random Gliding tiles
        db $FF,$FF,$FF      ;[2F-31]

    org $00E1D4+$2B
        db $00,$8C,$14,$14,$2E
        db $00,$CA,$16,$16,$2E
        db $00,$8E,$18,$18,$2E
        db $00,$EB,$1A,$1A,$2E
        db $04,$ED,$1C,$1C

    org $00E3B1
        JSR chartilehijack

    org $00E40D
        JSR capetilehijack

    org $00F649
        adc #$8000
    org $00F667
        adc #$8000
    org $00F67C
        adc #$8000
    org $00F691
        adc.w #player_extended_gfx

pullpc

player_code:
        rep #$20
        ldy $0D84|!addr
        bne .upload_player_palette
        jmp .skip_everything
    .upload_player_palette
        ldy #$86
        sty $2121
        lda #$2200
        sta $4320
        tay 
        lda $0D82|!addr
        sta $4322
        sty $4324
        lda #$0014
        sta $4325
        stx $420B

        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #player_gfx>>16
        sty $4324

    .upload_player_top
        lda #$6000
        sta $2116
        tay  
    -   
        lda $0D85|!addr,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy #$06
        bne -
    .upload_player_bottom
        lda #$6100
        sta $2116
        tay  
    -   
        lda $0D8F|!addr,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy #$06
        bne -
    .upload_player_extended
        ldy $0D9B|!addr
        cpy #$02
        beq .skip_everything
        lda #$60C0
        sta $2116
        lda $0D99|!addr
        sta $4322
        lda #$0040
        sta $4325
        stx $420B

    .upload_misc_tiles
        ldy.b #animated_tiles>>16
        sty $4324
        lda #$6060
        sta $2116
        ldy #$06
        cpy $0D84|!addr
        bcs ..skip
    -   
        lda $0D85|!addr,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy $0D84|!addr
        bcc -
        lda #$6160
        sta $2116
        ldy #$06
    -   
        lda $0D8F|!addr,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy $0D84|!addr
        bcc -

    ..skip

    .skip_everything
        sep #$20
        rtl 

;##############################################################################
;# Remap animated graphics to use ROM instead of RAM

pushpc
    org $0098D1
        db animated_tiles>>16
    org $00A39E
        db animated_tiles>>16

    org $00B888
        rts 

    org $01E1A8
        adc #$8800
    org $01EEB4
        adc #$8800
    org $01EEC9
        adc #$8800
    org $02EA3E
        adc #$8800

    ; animated tile data	
    org $05B999
        dw animated_tiles+$1800,animated_tiles+$1A00,animated_tiles+$1C00,animated_tiles+$1E00	; entry 00 - animated ? block
        dw animated_tiles+$1880,animated_tiles+$1A80,animated_tiles+$1C80,animated_tiles+$1E80	; entry 01 - animated note block
        dw animated_tiles+$1900,animated_tiles+$1900,animated_tiles+$1900,animated_tiles+$1900	; entry 02 - turn block
        dw animated_tiles+$2080,animated_tiles+$2280,animated_tiles+$2480,animated_tiles+$2680	; entry 03 - midway point
        dw animated_tiles+$1900,animated_tiles+$1B00,animated_tiles+$1D00,animated_tiles+$1F00	; entry 04 - animated turn block
        dw animated_tiles+$3000,animated_tiles+$3080,animated_tiles+$3100,animated_tiles+$3180	; entry 05 - berry
        dw animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20	; entry 06 - blank
        dw animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20	; entry 07 - blank
        dw animated_tiles+$1680,animated_tiles+$1680,animated_tiles+$1680,animated_tiles+$1680	; entry 08 - used block
        dw animated_tiles+$2700,animated_tiles+$2780,animated_tiles+$2700,animated_tiles+$2780	; entry 09 - muncher
        dw animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20,animated_tiles+$2F20	; entry 0A - blank
        dw animated_tiles+$2F00,animated_tiles+$2F00,animated_tiles+$2F00,animated_tiles+$2F00	; entry 0B - on/off line guide?
        dw animated_tiles+$1400,animated_tiles+$1400,animated_tiles+$1400,animated_tiles+$1400	; entry 0C - on switch
        dw animated_tiles+$1980,animated_tiles+$1B80,animated_tiles+$1D80,animated_tiles+$1F80	; entry 0D - animated coin
        dw animated_tiles+$2000,animated_tiles+$2200,animated_tiles+$2400,animated_tiles+$2600	; entry 0E - animated water (tileset index 0)
        dw animated_tiles+$1180,animated_tiles+$1380,animated_tiles+$1580,animated_tiles+$1780	; entry 0F - animated castle lava (tileset index 0)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 10 - ? block (tileset index 0)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 11 - ? block (tileset index 0)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 12 - ? block (tileset index 0)
        dw animated_tiles+$2000,animated_tiles+$2200,animated_tiles+$2400,animated_tiles+$2600	; entry 13 - animated water (tileset index 1)
        dw animated_tiles+$1180,animated_tiles+$1380,animated_tiles+$1580,animated_tiles+$1780	; entry 14 - animated castle lava (tileset index 1)
        dw animated_tiles+$0000,animated_tiles+$0200,animated_tiles+$0400,animated_tiles+$0600	; entry 15 - animated castle conveyor/escalator (tileset index 1)
        dw animated_tiles+$0600,animated_tiles+$0400,animated_tiles+$0200,animated_tiles+$0000	; entry 16 - animated castle conveyor/escalator, reverse (tileset index 1)
        dw animated_tiles+$2100,animated_tiles+$2300,animated_tiles+$2500,animated_tiles+$2300	; entry 17 - animated castle BG candle light (tileset index 1)
        dw animated_tiles+$2000,animated_tiles+$2200,animated_tiles+$2400,animated_tiles+$2600	; entry 18 - animated water (tileset index 2)
        dw animated_tiles+$2800,animated_tiles+$2A00,animated_tiles+$2C00,animated_tiles+$2E00	; entry 19 - animated rope and rope end (tileset index 2)
        dw animated_tiles+$2880,animated_tiles+$2A80,animated_tiles+$2C80,animated_tiles+$2E80	; entry 1A - animated sloped rope (tileset index 2)
        dw animated_tiles+$2E80,animated_tiles+$2C80,animated_tiles+$2A80,animated_tiles+$2880	; entry 1B - reverse animated sloped rope (tileset index 2)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 1C - ? block (tileset index 2)
        dw animated_tiles+$2180,animated_tiles+$2380,animated_tiles+$2580,animated_tiles+$2380	; entry 1D - animated cave BG sparkles (tileset index 3)
        dw animated_tiles+$0080,animated_tiles+$0280,animated_tiles+$0480,animated_tiles+$0680	; entry 1E - animated sloped cave lava (tileset index 3)
        dw animated_tiles+$0100,animated_tiles+$0300,animated_tiles+$0500,animated_tiles+$0700	; entry 1F - more animated sloped cave lava (tileset index 3)
        dw animated_tiles+$0180,animated_tiles+$0380,animated_tiles+$0580,animated_tiles+$0780	; entry 20 - animated cave lava (tileset index 3)
        dw animated_tiles+$0680,animated_tiles+$0480,animated_tiles+$0280,animated_tiles+$0080	; entry 21 - animated sloped cave lava, reverse (tileset index 3)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 22 - ? block (tileset index 4)
        dw animated_tiles+$2980,animated_tiles+$2B80,animated_tiles+$2D80,animated_tiles+$2B80	; entry 23 - animated ghost house light (tileset index 4)
        dw animated_tiles+$1100,animated_tiles+$1300,animated_tiles+$1500,animated_tiles+$1700	; entry 24 - animated seaweed (tileset index 4)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 25 - ? block (tileset index 4)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 26 - ? block (tileset index 4)
        dw animated_tiles+$2180,animated_tiles+$2380,animated_tiles+$2580,animated_tiles+$2380	; entry 27 - animated cave BG sparkles (tileset index 5)
        dw animated_tiles+$2900,animated_tiles+$2B00,animated_tiles+$2D00,animated_tiles+$2B00	; entry 28 - animated stars (tileset index 5)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 29 - ? block (tileset index 5)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 2A - ? block (tileset index 5)
        dw animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800,animated_tiles+$1800	; entry 2B - ? block (tileset index 5)
        dw animated_tiles+$1480,animated_tiles+$1480,animated_tiles+$1480,animated_tiles+$1480	; entry 2C - P-switch door
        dw animated_tiles+$1980,animated_tiles+$1B80,animated_tiles+$1D80,animated_tiles+$1F80	; entry 2D - animated coin
        dw animated_tiles+$1980,animated_tiles+$1B80,animated_tiles+$1D80,animated_tiles+$1F80	; entry 2E - animated coin
        dw animated_tiles+$1980,animated_tiles+$1B80,animated_tiles+$1D80,animated_tiles+$1F80	; entry 2F - animated coin
        dw animated_tiles+$1800,animated_tiles+$1A00,animated_tiles+$1C00,animated_tiles+$1E00	; entry 30 - animated ? block
        dw animated_tiles+$2F80,animated_tiles+$2F80,animated_tiles+$2F80,animated_tiles+$2F80	; entry 31 - more on/off line guide?
        dw animated_tiles+$1600,animated_tiles+$1600,animated_tiles+$1600,animated_tiles+$1600	; entry 32 - off switch
        dw animated_tiles+$1680,animated_tiles+$1680,animated_tiles+$1680,animated_tiles+$1680	; entry 33 - used block

pullpc

;##############################################################################
;# Fix berries

pushpc
    org $00A3F0
        jsl fix_berries
        nop #2
pullpc

fix_berries:
        ldy.b #animated_tiles>>16
        sty $4324
        lda $0D76|!addr
        sta $4322
        rtl 

;##############################################################################
;# Upload GFX
;# Will be reprogrammed at some point to make it faster

!gfx_uploaded_flag = $7C

;######################################

nmi_gamemode_code:
        lda $0D9B|!addr
        bmi +
        lda $0100|!addr
        asl 
        tax 
        jsr (.ptrs,x)
        rtl 
    +
        lda $0100|!addr
        cmp #$14
        bne +
        jsr upload_dss
    +
        rtl 

    .return
        rts

    .ptrs
        dw .return      ; 00 Load Nintendo Presents
        dw .return      ; 01 Nintendo Presents
        dw .return      ; 02 Fade to Title Screen
        dw .return      ; 03 Load Title Screen
        dw .return      ; 04 Prepare Title Screen
        dw .return      ; 05 Title Screen: Fade in
        dw .return      ; 06 Title Screen: Circle effect
        dw .return      ; 07 Title Screen
        dw .return      ; 08 Title Screen: File select
        dw .return      ; 09 Title Screen: File delete
        dw .return      ; 0A Title Screen: Player select
        dw .return      ; 0B Fade to Overworld
        dw .return      ; 0C Load Overworld
        dw nmi_gamemode_ow_fade_in      ; 0D Overworld: Fade in
        dw nmi_gamemode_ow_main      ; 0E Overworld
        dw .return      ; 0F Fade to Level
        dw .return      ; 10 Fade to Level (black)
        dw .return      ; 11 Load Level (Mario Start!)
        dw .return      ; 12 Prepare Level
        dw nmi_gamemode_level_fade_in      ; 13 Level: Fade in
        dw nmi_gamemode_level_main      ; 14 Level
        dw .return      ; 15 Fade to Game Over / Time Up
        dw .return      ; 16 Load Game Over / Time Up
        dw .return      ; 17 Game Over / Time Up
        dw .return      ; 18 Load Credits/Cutscene?
        dw .return      ; 19 Load Credits/Cutscene?
        dw .return      ; 1A Load Credits/Cutscene?
        dw .return      ; 1B Ending: Credits / Cutscene
        dw .return      ; 1C Ending: Fade to Yoshi's House
        dw .return      ; 1D Ending: Load Yoshi's House
        dw .return      ; 1E Ending: Yoshi's House: Fade in
        dw .return      ; 1F Ending: Yoshi's House
        dw .return      ; 20 Fade to Enemies
        dw .return      ; 21 Fade to Enemies (black)
        dw .return      ; 22 Fade to Enemies?
        dw .return      ; 23 Fade to Enemies (black)?
        dw .return      ; 24 Ending: Enemies: Fade in
        dw .return      ; 25 Ending: Enemies
        dw .return      ; 26 Fade to The End / Go to 22
        dw .return      ; 27 Ending: Load The End
        dw .return      ; 28 Ending: The End: Fade in
        dw .return      ; 29 Ending: The End

nmi_gamemode_level_fade_in:
        lda !gfx_uploaded_flag
        bne .skip
        inc !gfx_uploaded_flag
        ldx #$04
        jsr upload_static_level_gfx
    .skip
        rts 

nmi_gamemode_ow_main:
        jsr update_map_palette
        rts

nmi_gamemode_ow_fade_in:
        lda !gfx_uploaded_flag
        bne .skip
        inc !gfx_uploaded_flag
        ldx #$04
        jsr upload_player_map_graphics
        jsr upload_sprite_map_graphics
    .skip
        jsr update_map_palette
        rts

nmi_gamemode_level_main:
        ldx #$04
        jsr upload_blocks
        jsr upload_dss
        rts 


upload_sprite_map_graphics:
        rep #$20
        lda.w #$6800
        sta $2116
        lda #$1801
        sta $4320
        lda.w #inventory_items
        sta $4322
        lda #$1000
        sta $4325
        ldy.b #inventory_items>>16
        sty $4324
        stx $420B
        sep #$20
        rts

upload_static_level_gfx:
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320

    .sprite_page_1
        ldy.b #sprite_page_1>>16
        sty $4324
        ldy #$04
        lda.w #sprite_page_1
        sta $4322
        lda #$6000
        sta $2116
        lda #$1000
        sta $4325
        sty $420B

    .sprite_page_2
        lda.w #sprite_page_2
        sta $4322
        lda #$6800
        sta $2116
        lda #$1000
        sta $4325
        sty $420B

    ..layer_3
        ldy.b #player_name>>16
        sty $4324
        ldy #$04
        lda.w #player_name
        sta $4322
        lda #$4180
        sta $2116
        lda #$0050
        sta $4325
        sty $420B

    ..dragon_coins
        ldy.b #gfx_blocks>>16
        sty $4324
        ldy #$04
        lda.l block_visual_indicator
        and #$0002
        beq ...skip
        lda !shuffled_ow_level
        and #$00FF
        tax 
        lda.l dragon_coin_item_flags,x
        and #$000F
        tax 
        lda.l ..dragon_coins_offsets,x
        sta $4322

        lda #$0080
        sta $2116
        lda #$0040
        sta $4325
        sty $420B

        lda #$0180
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
        
        lda #$0280
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
        
        lda #$0380
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
    ...skip

    ..moon
        lda.l block_visual_indicator
        and #$0004
        beq ...skip
        lda !shuffled_ow_level
        and #$00FF
        tax 
        lda.l moon_item_flags,x
        and #$000F
        tax 
        lda.l ..moon_offsets,x
        sta $4322
        
        lda #$0BB0
        sta $2116
        lda #$0020
        sta $4325
        sty $420B
        
        lda #$08D0
        sta $2116
        lda #$0020
        sta $4325
        sty $420B
        
        lda #$0F00
        sta $2116
        lda #$0020
        sta $4325
        sty $420B
        
        lda #$09D0
        sta $2116
        lda #$0020
        sta $4325
        sty $420B
    ...skip

    ..goal
        lda.l block_visual_indicator
        and #$0001
        beq ...skip
        lda.w #$0580+gfx_blocks
        sta $4322
        lda #$0A00
        sta $2116
        lda #$0080
        sta $4325
        sty $420B
    ...skip

    ..bonus_block
        lda.l block_visual_indicator
        and #$0008
        beq ...skip
        lda.w #$0500+gfx_blocks
        sta $4322

        lda #$0BE0
        sta $2116
        lda #$0020
        sta $4325
        sty $420B

        lda #$0D70
        sta $2116
        lda #$0020
        sta $4325
        sty $420B

        lda #$0F60
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
    ...skip
        
        sep #$20
        rts 

    ..dragon_coins_offsets
        dw $0200+gfx_blocks
        dw $0300+gfx_blocks
        dw $0200+gfx_blocks
        dw $0200+gfx_blocks
        dw $0300+gfx_blocks

    ..moon_offsets
        dw $0400+gfx_blocks
        dw $0480+gfx_blocks
        dw $0400+gfx_blocks
        dw $0400+gfx_blocks
        dw $0480+gfx_blocks

upload_player_map_graphics:
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #$1C
        sty $4324
        lda.w #$E400
        sta $4322
        phx 
        txy 
        ldx.b #(.map_targets_end-.map_targets-2)
    .loop
        lda #$0040
        sta $4325
        lda.l .map_targets,x
        sta $2116
        sty $420B
        lda.l .map_targets,x
        clc 
        adc #$0100
        sta $2116
        lda #$0040
        sta $4325
        sty $420B
        dex #2
        bpl .loop
        plx 
        sep #$20
        rts 

    .map_targets
    ..yoshi
        dw $6420,$6400,$62E0
    ..mario
        dw $6660,$6640
        dw $6460
        dw $6240,$6200
        dw $60E0,$60C0,$60A0,$6080,$6060
    ..end


update_map_palette:
        rep #$20
        ldy #$A3
        sty $2121
        lda #$2200
        sta $4320
        lda.w #$B59C
        sta $4322
        ldy #$00    ; bank
        sty $4324
        lda #$000A
        sta $4325
        ldx #$04
        stx $420B

        lda.l sprite_map_colors
        and #$00FF
        beq .nope

        ldy #$98
        sty $2121
        lda.w #$EC50
        sta $4322
        ldy #$1C    ; bank
        sty $4324
        lda #$0010
        sta $4325
        stx $420B

        ldy #$A8
        sty $2121
        lda #$0010
        sta $4325
        stx $420B

        ldy #$B8
        sty $2121
        lda #$0010
        sta $4325
        stx $420B

    .nope
        sep #$20
        rts 

upload_blocks:
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #gfx_blocks>>16
        sty $4324

        lda $14
        and #$0007
        beq .question_blocks
        cmp #$0001
        beq .pswitch_blocks
        sep #$20
        rts

    .question_blocks
        lda $14
        and #$001C
        lsr #2
        tax 
        lda.l .question_block_srcs,x
        sta $4322
        ldx #$04
        lda !shuffled_ow_level
        and #$00FF
        cmp #$0025
        beq ..castle
        cmp #$0031
        beq ..castle
        cmp #$000E
        beq ..castle
        lda #$0890
        sta $2116
        lda #$0060
        sta $4325
        stx $420B
        lda #$0820
        sta $2116
        lda #$0020
        sta $4325
        stx $420B
        sep #$20
        rts 
    ..castle
        lda #$08E0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
        lda #$09E0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
        sep #$20
        rts 

    .pswitch_blocks
        lda !shuffled_ow_level
        and #$00FF
        cmp #$0025
        beq ..castle
        cmp #$0031
        beq ..castle
        cmp #$000E
        beq ..castle
        lda $14AD|!addr
        and #$00FF
        bne ..active
        lda.w #gfx_blocks+$0780
        bra ..animate
    ..active
        lda $14
        and #$001C
        lsr #2
        tax 
        lda.l .question_block_srcs,x
    ..animate
        sta $4322
        ldx #$04
        lda #$0990
        sta $2116
        lda #$0060
        sta $4325
        stx $420B
        lda #$0920
        sta $2116
        lda #$0020
        sta $4325
        stx $420B
    ..castle
        sep #$20
        rts 

.question_block_srcs
    dw $0000+gfx_blocks,$0080+gfx_blocks,$0100+gfx_blocks,$0180+gfx_blocks

;######################################

macro dss_write_tile()
    lda !dss_gfx_queue_vram,x       ; force end if there's no gfx in the queue (vram dest = $0000)
    bne ?continue_upload
    jmp queue_end
?continue_upload:
    sta $2116

    lda !dss_gfx_queue_source_row_1+$01,x
    sta $23
    lda !dss_gfx_queue_source_row_1,x
    sta $22
    lda #$0040
    sta $25
    sty $420B

    lda !dss_gfx_queue_vram,x
    clc
    adc #$0100
    sta $2116
    lda !dss_gfx_queue_source_row_2,x
    sta $22
    lda #$0040
    sta $25
    sty $420B

    lda #$0000                      ; mark slot as unused
    sta !dss_gfx_queue_vram,x

    lda !dss_gfx_queue_index_nmi
    clc 
    adc #$0008                      ; update index
    sta !dss_gfx_queue_index_nmi
    tax
endmacro

upload_dss:
    lda !dss_gfx_queue_index_nmi    ; get index of the next graphics ready to be uploaded to vram
    tax
    lda !dss_gfx_queue_vram+1,x     ; if the next entry in the queue is blank, skip the entire routine
    bne .start_queue
    rts

.start_queue
    rep #$20
    lda #$4300
    tcd                             ; small optimization: change dp to $4300

    lda #$1801
    sta $20                         ; setup some regs
    ldy #$80
    sty $2115
    ldy #$04

    !i = 0
while !i < !dss_queue_tiles
    %dss_write_tile()
    !i #= !i+1
endwhile

queue_end:
    lda #$3000                      ; restore dp
    tcd
    sep #$20
    rts