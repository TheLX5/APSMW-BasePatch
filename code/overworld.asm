includefrom "main.asm"
;##################################################################################################
;# This file includes everything that's meant to edit the overworld map

;#########################################################################
;# Track level clears for indicators

pushpc
    ORG $00A0EB
        db $20

    ORG $04E6FA
        dw $E496

    ORG $04E73E
        db $FF

    ORG $04E75E
        STZ $1494|!addr

    ORG $04EAAE
        BRA $04

    ORG $04EACC
        LDA $1495|!addr
        CLC
        ADC #$0D
        STA $1495|!addr
        RTS
pullpc

;#########################################################################
;# Track level clears for indicators

pushpc
    org $04E5EE
        jmp check_events

    org $04A300
        check_events:
            phx 
            jsl get_translevel_num
            lda $0DD5|!addr
            beq .dont_sync
            bmi .dont_sync
            cmp #$05
            bcs .dont_sync
            and #$07
            tax 
            lda.l $009E7D,x
            ldx !shuffled_ow_level
            ora !level_clears,x
            sta !level_clears,x
        .dont_sync
            plx 
            lda $0DD5|!addr
            cmp #$02
            bne .no_secret
            inc $1DEA|!addr
        .no_secret
            jmp $E5F8
pullpc

;#########################################################################
;# Include several routines in bank 04 & extended ROM we need

pushpc 
    org $04A340
        get_translevel_num:
                rep #$30
                ldx $0DD6|!addr
                lda $1F1F|!addr,x
                sta $00
                lda $1F21|!addr,x
                sta $02
                txa 
                lsr #2
                tax 
                jsr $9885
                ldx $04
                lda $40D000,x
                sep #$30
                sta !shuffled_ow_level
                tax 
                lda $06FF00,x
                cmp #$FF
                beq +
                sta !shuffled_ow_level
            +   
                rtl

        get_translevel_bit:
                lda !shuffled_ow_level
                lsr 
                lsr 
                lsr 
                tay 
                lda !shuffled_ow_level
                and #$07
                tax 
                rtl

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
                rtl


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
pullpc

;#########################################################################
;# Prepare dynamic tilemap

pushpc
    org $00A1C7
        jsl prepare_dynamic_tilemap
pullpc



prepare_dynamic_tilemap:
    if !sa1 == 1
        %invoke_sa1(.sa1)
        rtl
    endif

.sa1
        jsl $048241     ; Run OW main

    .handle_powerup:
        ldy #$22
        lda !ability_byte_2
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
        lda !ability_byte_1
        and #$08
        beq $02
        ldy #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$02         ; Spin jump

    .handle_run:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$80
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$04         ; Run

    .handle_carry:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$40
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$06         ; Carry

    .handle_swim:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$04
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$08         ; Swim

    .handle_climb:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$20
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0A         ; Climb

    .handle_yoshi:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$02
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0C         ; Yoshi

    .handle_pswitch:
        ldy.b #!icon_not_obtained
        lda !ability_byte_1
        and #$10
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$0E         ; P-Switch

    .handle_pballoon:
        ldy.b #!icon_not_obtained
        lda !ability_byte_2
        and #$08
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$10         ; P-Balloon

    .handle_star:
        ldy.b #!icon_not_obtained
        lda !ability_byte_2
        and #$10
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_abilities+$12         ; Star

    .handle_yellow_switch:
        ldy.b #!icon_not_obtained
        lda $1F28|!addr
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$00
    .handle_green_switch:
        ldy.b #!icon_not_obtained
        lda $1F27|!addr
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$02
    .handle_red_switch:
        ldy.b #!icon_not_obtained
        lda $1F2A|!addr
        beq $02
        ldy.b #!icon_obtained
        tya 
        sta !ow_tilemap_switches+$04
    .handle_blue_switch:
        ldy.b #!icon_not_obtained
        lda $1F29|!addr
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
        lda $13D9|!addr
        cmp #$01
        beq process_level
        cmp #$03
        beq process_level
        rtl

process_level:
        jsl get_translevel_num
        ldx !shuffled_ow_level
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
        ldx !shuffled_ow_level
        ldy.b #!icon_disabled
        lda.l map_indicator_data,x
        and #$40
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsl get_translevel_bit
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
        jsl update_flag_pointers
    .dont_draw

handle_bonus_blocks:
        lda.l bonus_block_enabled_flag
        beq .dont_draw
        ldx !shuffled_ow_level
        ldy.b #!icon_disabled
        lda.l map_indicator_data,x
        and #$20
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsl get_translevel_bit
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
        jsl update_flag_pointers
    .dont_draw


handle_checkpoints:
        lda.l checkpoints_enabled_flag
        beq .dont_draw
        ldx !shuffled_ow_level
        lda.l map_indicator_data,x
        and #$10
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsl get_translevel_bit
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
        jsl update_flag_pointers
    .dont_draw
    
handle_moons:
        lda.l moon_enabled_flag
        beq .dont_draw
        ldx !shuffled_ow_level
        lda.l map_indicator_data,x
        and #$08
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsl get_translevel_bit
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
        jsl update_flag_pointers
    .dont_draw

handle_dragon_coins:
        lda.l dragon_coin_enabled_flag
        beq .dont_draw
        ldx !shuffled_ow_level
        lda.l map_indicator_data,x
        and #$04
        beq .dont_draw
        ldy.b #!icon_not_obtained
        phy 
        jsl get_translevel_bit
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
        jsl update_flag_pointers
    .dont_draw



handle_exit_2:
        ldx !shuffled_ow_level
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
        jsl update_flag_pointers
    .dont_draw

handle_exit_1:
        ldx !shuffled_ow_level
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
        jsl update_flag_pointers
    .dont_draw
        rtl 

;#########################################################################
;# Draw tilemap

pushpc
    org $008222
        jml draw_ow_tilemap
pullpc

draw_ow_tilemap:
        lda $13D9|!addr
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
