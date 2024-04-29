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
    org $1CF000
        score_sprites_tiles:
    org $1D8000
        animated_tiles:
pullpc


;##############################################################################
;# Original player
;# A bunch of hacks made by Ladida to give us more VRAM for global graphics

pushpc
    org $00A300
        mario_gfx_dma:
            ldx #$04
            jsl upload_score_sprite_gfx
            jsl player_code
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
        ldy $0D84
        bne .upload_player_palette
        jmp .skip_everything
    .upload_player_palette
        ldy #$86
        sty $2121
        lda #$2200
        sta $4320
        tay 
        lda $0D82
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
        lda $0D85,y
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
        lda $0D8F,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy #$06
        bne -
    .upload_player_extended
        ldy $0D9B
        cpy #$02
        beq .skip_everything
        lda #$60C0
        sta $2116
        lda $0D99
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
        cpy $0D84
        bcs ..skip
    -   
        lda $0D85,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy $0D84
        bcc -
        lda #$6160
        sta $2116
        ldy #$06
    -   
        lda $0D8F,y
        sta $4322
        lda #$0040
        sta $4325
        stx $420B
        iny #2
        cpy $0D84
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
        lda $0D76
        sta $4322
        rtl 

;##############################################################################
;# Upload score sprite GFX
;# Will be reprogrammed at some point to make it faster

upload_score_sprite_gfx:
        lda $0100
        cmp #$13
        beq .check_level
        jmp .check_map
    .check_level
        lda $7C
        beq ..perform
        jmp .skip
    ..perform
        inc $7C
        rep #$20
        ldy #$80
        sty $2115
        lda #$1801
        sta $4320
        ldy.b #$1C
        sty $4324
        lda.w #$F000
        sta $4322
    .nums_01
        lda #$64A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .nums_35
        lda #$65A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .plus_coin
        lda #$61A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .egg_mushroom
        lda #$60A0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .flower_feather
        lda #$67E0
        sta $2116
        lda #$0040
        sta $4325
        stx $420B
    .token
        lda #$6380
        sta $2116
        lda #$0020
        sta $4325
        stx $420B
    .layer_3
        lda.w #$EC00
        sta $4322
        lda #$4180
        sta $2116
        lda #$0050
        sta $4325
        stx $420B
        sep #$20
    .skip 
        rtl 
    .check_map
        cmp #$0E
        beq .map_pal
        cmp #$0D
        bne .skip
        lda $7C
        bne .skip
        inc $7C
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
    ..loop
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
        bpl ..loop
        plx 
        sep #$20
    .map_pal
        lda #$A3
        sta $2121
        lda $00B59C
        sta $2122
        lda $00B59D
        sta $2122
        lda $00B59E
        sta $2122
        lda $00B59F
        sta $2122
        lda $00B5A0
        sta $2122
        lda $00B5A1
        sta $2122
        lda $00B5A2
        sta $2122
        lda $00B5A3
        sta $2122
        lda $00B5A4
        sta $2122
        lda $00B5A5
        sta $2122
        rtl 

    .map_targets
    ..yoshi
        dw $6420,$6400,$62E0
    ..mario
        dw $6660,$6640
        dw $6460
        dw $6240,$6200
        dw $60E0,$60C0,$60A0,$6080,$6060
    ..end

pushpc
    org $1CF000
        incbin "../data/graphics/indicators.bin"
pullpc