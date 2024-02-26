@includefrom "main.asm"
;##################################################################################################
;# This file includes everything that's meant to edit the overworld map

;#########################################################################
;# Track level clears for indicators

pushpc
org $04E5EE
    jmp check_events

org $04A300
    check_events:
        phx 
        jsr get_translevel_num
        lda $0DD5
        beq .dont_sync
        bmi .dont_sync
        cmp #$05
        bcs .dont_sync
        and #$07
        tax 
        lda.l $009E7D,x
        ldx !current_ow_level
        ora !level_clears,x
        sta !level_clears,x
    .dont_sync
        plx 
        lda $0DD5
        cmp #$02
        bne .no_secret
        inc $1DEA
    .no_secret
        jmp $E5F8
pullpc

;#########################################################################
;# Include several routines in bank 04 & extended ROM we need

pushpc 
    org $04A340
        get_translevel_num:
                rep #$30
                ldx $0DD6
                lda $1F1F,x
                sta $00
                lda $1F21,x
                sta $02
                txa 
                lsr #2
                tax 
                jsr $9885
                ldx $04
                lda $7ED000,x
                sep #$30
                sta !current_ow_level
                tax 
                lda $06FF00,x
                cmp #$FF
                beq +
                sta !current_ow_level
            +   
                rts 

        get_translevel_bit:
                lda !current_ow_level
                lsr 
                lsr 
                lsr 
                tay 
                lda !current_ow_level
                and #$07
                tax 
                rts 

        update_flag_pointers:
                inc $00
                inc $00
                inc $03
                inc $03
                inc $06
                inc $06
                inc $62
                inc $62
                inc $63
                rts 
warnpc $04A400


clear_tilemap:
        rep #$20
        lda.w #$3900+!icon_disabled
        ldx #$1E
    .loop
        sta !ow_tilemap_switches,x
        sta !ow_tilemap_abilities,x
        sta !ow_tilemap_flags_top,x
        sta !ow_tilemap_flags_mid,x
        sta !ow_tilemap_flags_bot,x
        dex #2
        bpl .loop 
        sep #$20
        lda #$07
        sta $63
        asl 
        sta $62
        rtl 
    
clear_tilemap_flags:
        rep #$20
        lda.w #$3900+!icon_disabled
        ldx.b #($07*2)-2
    .loop
        sta !ow_tilemap_flags_top,x
        sta !ow_tilemap_flags_mid,x
        sta !ow_tilemap_flags_bot,x
        dex #2
        bpl .loop 
        sep #$20
        lda #$06
        sta $63
        asl 
        sta $62
        rtl 

;#########################################################################
;# Prepare dynamic tilemap

pushpc
    org $00A1C7
        jsl prepare_dynamic_tilemap
pullpc

prepare_dynamic_tilemap:
        jsl $048241     ; Run OW main

    .handle_powerup:
        ldy #$22
        lda $1F2D
        lsr 
        bcc $01
        iny 
        lsr 
        bcc $01
        iny 
        lsr 
        bcc $01
        iny 
        tya 
        sta !ow_tilemap_abilities         ; Progressive powerup

    .handle_spinjump:
        ldy #!icon_not_obtained
        lda $1F2C
        and #$08
        beq $02
        ldy #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$02         ; Spin jump

    .handle_run:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$80
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$04         ; Run

    .handle_carry:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$40
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$06         ; Carry

    .handle_swim:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$04
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$08         ; Swim

    .handle_climb:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$20
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0A         ; Climb

    .handle_yoshi:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$02
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0C         ; Yoshi

    .handle_pswitch:
        ldy.b #!icon_not_obtained
        lda $1F2C
        and #$10
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0E         ; P-Switch

    .handle_pballoon:
        ldy.b #!icon_not_obtained
        lda $1F2D
        and #$08
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$10         ; P-Balloon

    .handle_star:
        ldy.b #!icon_not_obtained
        lda $1F2D
        and #$10
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$12         ; Star

    .handle_yellow_switch:
        ldy.b #!icon_not_obtained
        lda $1F28
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$00
    .handle_green_switch:
        ldy.b #!icon_not_obtained
        lda $1F27
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$02
    .handle_red_switch:
        ldy.b #!icon_not_obtained
        lda $1F2A
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$04
    .handle_blue_switch:
        ldy.b #!icon_not_obtained
        lda $1F29
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$06
    .handle_special_world_clear:
        ldy.b #!icon_not_obtained
        lda !special_world_clear_flag
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$08

        jsl clear_tilemap_flags
        lda $13D9
        cmp #$01
        beq process_level
        cmp #$03
        beq process_level
        rtl

process_level:
        jsr get_translevel_num
        ldx !current_ow_level
        lda.l map_indicator_data,x
        bpl .handle_data
        rtl 
    .handle_data
        stz $62
        stz $63
        rep #$20
        lda.w #!ow_tilemap_flags_top
        sta $00
        lda.w #!ow_tilemap_flags_mid
        sta $03
        lda.w #!ow_tilemap_flags_bot
        sta $06
        sep #$20
        lda.b #!ow_tilemap_flags_top>>16
        sta $02
        sta $05
        sta $08


handle_blocksanity:
        lda.l blocksanity_enabled_flag
        beq .dont_draw
        ldx !current_ow_level
        ldy.b #!icon_disabled
        lda.l map_indicator_data,x
        and #$40
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsr get_translevel_bit
        phx 
        tyx 
        lda.l !blocksanity_flags,x
        plx 
        ply 
        and.l $0DA8A6,x
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$01
        sta [$00]
        lda #$12
        sta [$03]
        jsr update_flag_pointers
    .dont_draw

handle_bonus_blocks:
        lda.l bonus_block_enabled_flag
        beq .dont_draw
        ldx !current_ow_level
        ldy.b #!icon_disabled
        lda.l map_indicator_data,x
        and #$20
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsr get_translevel_bit
        phx 
        tyx 
        lda !bonus_block_flags,x
        plx 
        ply 
        and.l $0DA8A6,x
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$01
        sta [$00]
        lda #$4E
        sta [$03]
        jsr update_flag_pointers
    .dont_draw


handle_checkpoints:
        lda.l checkpoints_enabled_flag
        beq .dont_draw
        ldx !current_ow_level
        lda.l map_indicator_data,x
        and #$10
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsr get_translevel_bit
        lda !checkpoints_flags,y
        ply 
        and.l $0DA8A6,x
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$02
        sta [$00]
        lda #$47
        sta [$03]
        jsr update_flag_pointers
    .dont_draw
    
handle_moons:
        lda.l moon_enabled_flag
        beq .dont_draw
        ldx !current_ow_level
        lda.l map_indicator_data,x
        and #$08
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsr get_translevel_bit
        lda !moons_flags,y
        ply 
        and.l $0DA8A6,x
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$0C
        sta [$00]
        lda #$4E
        sta [$03]
        jsr update_flag_pointers
    .dont_draw

handle_dragon_coins:
        lda.l dragon_coin_enabled_flag
        beq .dont_draw
        ldx !current_ow_level
        lda.l map_indicator_data,x
        and #$04
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsr get_translevel_bit
        lda !yoshi_coins_flags,y
        ply 
        and.l $0DA8A6,x
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$03
        sta [$00]
        lda #$02
        sta [$03]
        jsr update_flag_pointers
    .dont_draw



handle_exit_2:
        ldx !current_ow_level
        lda.l map_indicator_data,x
        and #$02
        beq .dont_draw
        ldy.b #!icon_not_obtained
        lda !level_clears,x
        and #$02
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$04
        sta [$00]
        lda #$24
        sta [$03]
        jsr update_flag_pointers
    .dont_draw

handle_exit_1:
        ldx !current_ow_level
        lda.l map_indicator_data,x
        and #$01
        beq .dont_draw
        ldy.b #!icon_not_obtained
        lda !level_clears,x
        and #$01
        beq .write
        ldy.b #!icon_obtained
    .write
        tya 
        sta [$06]
        lda #$04
        sta [$00]
        lda #$23
        sta [$03]
        jsr update_flag_pointers
    .dont_draw
        rtl 

map_indicator_data:
  ;     dsbcmy21
    db %10000000        ; 00 - Bonus
    db %01000101        ; 01 - Vanilla Secret 2
    db %01000101        ; 02 - Vanilla Secret 3
    db %10000000        ; 03 - Top Secret Area
    db %01000011        ; 04 - Donut Ghost House
    db %01100101        ; 05 - Donut Plains 3
    db %01011101        ; 06 - Donut Plains 4
    db %01010001        ; 07 - Morton's Castle
    db %00000001        ; 08 - Green Switch Palace
    db %01000111        ; 09 - Donut Plains 2
    db %01000111        ; 0A - Donut Secret 1
    db %01010001        ; 0B - Vanilla Fortress
    db %01100101        ; 0C - Butter Bridge 1
    db %01000101        ; 0D - Butter Bridge 2
    db %01000001        ; 0E - Ludwig Castle
    db %01001111        ; 0F - Cheese Bridge Area
    db %01010101        ; 10 - Cookie Mountain
    db %01000101        ; 11 - Soda Lake
    db %10000000        ; 12 - Test
    db %01000011        ; 13 - Donut Secret House
    db %00000001        ; 14 - Yellow Switch Palace
    db %01010111        ; 15 - Donut Plains 1
    db %10000000        ; 16 - Test
    db %10000000        ; 17 - Test
    db %01000101        ; 18 - Sunken Ghost Ship
    db %10000000        ; 19 - Test
    db %01010001        ; 1A - Wendy's Castle
    db %01000001        ; 1B - Chocolate Fortress
    db %01000101        ; 1C - Chocolate Island 5
    db %01000101        ; 1D - Chocolate Island 4
    db %10000000        ; 1E - Test
    db %01000001        ; 1F - Forest Fortress
    db %01000101        ; 20 - Roy's Castle
    db %01000001        ; 21 - Choco Ghost House
    db %01001101        ; 22 - Chocolate Island 1
    db %01100111        ; 23 - Chocolate Island 3
    db %01010111        ; 24 - Chocolate Island 2
    db %01000001        ; 101 - Iggy's Castle
    db %01010101        ; 102 - Yoshi's Island 4
    db %01100101        ; 103 - Yoshi's Island 3
    db %10000000        ; 104 - Yoshi's House
    db %01001101        ; 105 - Yoshi's Island 1
    db %01000101        ; 106 - Yoshi's Island 2
    db %01010101        ; 107 - Vanilla Ghost House
    db %10000000        ; 108 - Test
    db %01000111        ; 109 - Vanilla Secret 1
    db %01001101        ; 10A - Vanilla Dome 3
    db %01000101        ; 10B - Donut Secret 2
    db %10000000        ; 10C - Test
    db %10000000        ; 10D - Front Door
    db %10000000        ; 10E - Back Door
    db %01000011        ; 10F - Valley of Bowser 4
    db %01010101        ; 110 - Larry's Castle
    db %01000001        ; 111 - Valley Fortress
    db %10000000        ; 112 - Test
    db %01000101        ; 113 - Valley of Bowser 3
    db %01000111        ; 114 - Valley Ghost House
    db %01010111        ; 115 - Valley of Bowser 2
    db %01001101        ; 116 - Valley of Bowser 1
    db %01000001        ; 117 - Chocolate Secret
    db %01000111        ; 118 - Vanilla Dome 2
    db %01010101        ; 119 - Vanilla Dome 4
    db %01000111        ; 11A - Vanilla Dome 1
    db %00000001        ; 11B - Red Switch Palace
    db %01000001        ; 11C - Lemmy's Castle
    db %01001111        ; 11D - Forest Ghost House
    db %01000011        ; 11E - Forest of Illusion 1
    db %01000111        ; 11F - Forest of Illusion 4
    db %01000111        ; 120 - Forest of Illusion 2
    db %00000001        ; 121 - Blue Switch Palace
    db %01000101        ; 122 - Forest Secret Area
    db %01010111        ; 123 - Forest of Illusion 3
    db %10000000        ; 124 - Test
    db %01000101        ; 125 - Funky
    db %01000101        ; 126 - Outrageous
    db %01000101        ; 127 - Mondo
    db %01000101        ; 128 - Groovy
    db %10000000        ; 129 - Test
    db %01010101        ; 12A - Gnarly
    db %01000101        ; 12B - Tubular
    db %01000101        ; 12C - Way Cool
    db %01000101        ; 12D - Awesome
    db %10000000        ; 12E - Test
    db %10000000        ; 12F - Test
    db %01000011        ; 130 - Star World 2
    db %10000000        ; 131 - Test
    db %01000011        ; 132 - Star World 3
    db %10000000        ; 133 - Test
    db %00000111        ; 134 - Star World 1
    db %01000011        ; 135 - Star World 4
    db %01000011        ; 136 - Star World 5
    db %10000000        ; 137 - Test
    db %10000000        ; 138 - Test
    db %10000000        ; 139 - Test
    db %10000000        ; 13A - Test
    db %10000000        ; 13B - Test

;#########################################################################
;# Draw tilemap

pushpc
org $008222
    jml draw_ow_tilemap
pullpc

draw_ow_tilemap:
        lda $13D9
        cmp #$0A
        bne write_tilemap
        jml $008229

write_tilemap:
        rep #$20
        ldy #$80
        sty $2115

write_abilities:
    .top
        lda #!vram_abilities_top
        sta $2116
        ldx.b #$00
    ..loop
        lda.l abilities_top,x 
        sta $2118
        inx #2
        cpx.b #$0A*2
        bcc ..loop
    .mid
        lda #!vram_abilities_mid
        sta $2116
        ldx.b #$00
    ..loop
        lda.l abilities_bottom,x 
        sta $2118
        inx #2
        cpx.b #$0A*2
        bcc ..loop
    .bot
        lda #!vram_abilities_bot
        sta $2116
        ldx.b #$00
    ..loop
        lda !ow_tilemap_abilities,x 
        sta $2118
        inx #2
        cpx.b #$0A*2
        bcc ..loop


write_switches:
    .top
        lda #!vram_switches_top
        sta $2116
        ldx.b #$00
    ..loop
        lda.l switches_top,x 
        sta $2118
        inx #2
        cpx.b #$05*2
        bcc ..loop
    .mid
        lda #!vram_switches_mid
        sta $2116
        ldx.b #$00
    ..loop
        lda.l switches_bottom,x 
        sta $2118
        inx #2
        cpx.b #$05*2
        bcc ..loop
    .bot
        lda #!vram_switches_bot
        sta $2116
        ldx.b #$00
    ..loop
        lda !ow_tilemap_switches,x 
        sta $2118
        inx #2
        cpx.b #$05*2
        bcc ..loop

write_level_data:
        pei ($00)
        lda $63
        and #$00FF
        sta $00
        beq .skip_flags
    .top 
        lda.w #!vram_level_data_top+$01
        sec 
        sbc $00
        sta $2116
        ldx.b $62
        dex #2
    ..loop
        lda.l !ow_tilemap_flags_top,x
        sta $2118
        dex #2
        bpl ..loop
    .mid 
        lda.w #!vram_level_data_mid+$01
        sec 
        sbc $00
        sta $2116
        ldx.b $62
        dex #2
    ..loop
        lda.l !ow_tilemap_flags_mid,x
        sta $2118
        dex #2
        bpl ..loop
    .bot 
        lda.w #!vram_level_data_bot+$01
        sec 
        sbc $00
        sta $2116
        ldx.b $62
        dex #2
    ..loop
        lda.l !ow_tilemap_flags_bot,x
        sta $2118
        dex #2
        bpl ..loop
    .skip_flags
        pla 
        sta $00

        sep #$20
        jml $008237

abilities_top:
    dw $390F,$3912,$3911,$3902,$3912,$3902,$3918,$390F,$390F,$3912
abilities_bottom:
    dw $394E,$394F,$3954,$3940,$3956,$394B,$394E,$3952,$3941,$3953

switches_top:
    dw $3918,$3906,$3911,$3901,$3912
switches_bottom:
    dw $3912,$3912,$3912,$3912,$394F

;#########################################################################
;# 
