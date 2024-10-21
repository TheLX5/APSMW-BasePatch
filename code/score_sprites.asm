includefrom "main.asm"
;##################################################################################################
;# This file handles everything related to score sprites, also known as indicators

pushpc
    org $02ADBA
        jml score_sprites
pullpc 

score_sprites:
        lda !score_sprite_num,x
        beq .return
        stx $15E9|!addr
        rep #$30
        and #$003F
        sta $00
        asl 
        clc 
        adc $00
        tax 
        lda.l .pointers-3,x
        sta $00
        sep #$30
        lda.l .pointers-3+2,x
        sta $02
        sep #$10
        ldx $15E9|!addr
        phb 
        pha 
        plb 
        phk 
        pea.w .return_code-1
        jml [$0000|!dp]
    .return_code
        plb
    .return 
        jml $02ADC5
    
    .kill
        stz !score_sprite_num,x
        rtl 

    .pointers
        dl original_score_sprites       ; 01 - 10 points
        dl original_score_sprites       ; 02 - 20 points
        dl original_score_sprites       ; 03 - 40 points
        dl original_score_sprites       ; 04 - 80 points
        dl original_score_sprites       ; 05 - 100 points
        dl original_score_sprites       ; 06 - 200 points
        dl original_score_sprites       ; 07 - 400 points
        dl original_score_sprites       ; 08 - 800 points
        dl original_score_sprites       ; 09 - 1000 points
        dl original_score_sprites       ; 0A - 2000 points
        dl original_score_sprites       ; 0B - 4000 points
        dl original_score_sprites       ; 0C - 8000 points
        dl original_score_sprites       ; 0D - 1-up
        dl original_score_sprites       ; 0E - 2-up
        dl original_score_sprites       ; 0F - 3-up
        dl original_score_sprites       ; 10 - 5-up
        dl icon_score                   ; 11 - 1 coin
        dl icon_score                   ; 12 - 5 coins
        dl icon_score                   ; 13 - 10 coins
        dl icon_score                   ; 14 - 15 coins
        dl icon_score                   ; 15 - Yoshi Egg
        dl icon_score                   ; 16 - 1up Mushroom
        dl icon_score                   ; 17 - Mushroom
        dl icon_score                   ; 18 - Flower
        dl icon_score                   ; 19 - Feather
        dl icon_score                   ; 1A - Boss token
        dl icon_score                   ; 1B - Star
        dl icon_score                   ; 1C - Green Yoshi
        dl icon_score                   ; 1D - Red Yoshi
        dl icon_score                   ; 1E - Blue Yoshi
        dl icon_score                   ; 1F - Yellow Yoshi
        dl icon_score                   ; 20 - 
        dl icon_score                   ; 21 - 
        dl icon_score                   ; 22 - 
        dl icon_score                   ; 23 - 
        dl icon_score                   ; 24 - 
        dl icon_score                   ; 25 - 
        dl icon_score                   ; 26 - 
        dl icon_score                   ; 27 - 
        dl icon_score                   ; 28 - 
        dl icon_score                   ; 29 - 
        dl icon_score                   ; 2A - 
        dl icon_score                   ; 2B - 
        dl icon_score                   ; 2C - 
        dl icon_score                   ; 2D - 
        dl icon_score                   ; 2E - 
        dl icon_score                   ; 2F - 
        dl icon_score                   ; 30 - 
        dl icon_score                   ; 31 - 
        dl icon_score                   ; 32 - 
        dl icon_score                   ; 33 - 
        dl icon_score                   ; 34 - 
        dl icon_score                   ; 35 - 
        dl icon_score                   ; 36 - 
        dl icon_score                   ; 37 - 
        dl icon_score                   ; 38 - 
        dl icon_score                   ; 39 - 
        dl icon_score                   ; 3A - 
        dl icon_score                   ; 3B - 
        dl icon_score                   ; 3C - 
        dl icon_score                   ; 3D - 
        dl icon_score                   ; 3E - 
        dl icon_score                   ; 3F - 

original_score_sprites:
        lda #$02
        pha 
        plb
        phk
        pea.w .jslrtsreturn-1
        pea.w $B889-1
        jml $02ADC9
    .jslrtsreturn
        rtl 

;###################################################
;# Give coins

icon_score:
        lda !score_sprite_timer,x
        bne .active
        stz !score_sprite_num,x
        rtl 

    .active 
        dec !score_sprite_timer,x
        cmp #$30
        bne ..not_give_reward
        lda !score_sprite_num,x
        sec 
        sbc #$11
        asl 
        tay 
        rep #$20
        lda .reward_ptrs,y 
        sta $00
        sep #$20
        jmp ($0000|!dp)
    ..not_give_reward

    .handle_movement
        lda !score_sprite_timer,x
        lsr #4
        tay 
        lda $13
        and .speed,y
        bne ..skip_update
        lda !score_sprite_y_lo,x
        tay 
        sec 
        sbc $1C
        cmp #$04
        bcc ..skip_update
        dec !score_sprite_y_lo,x
        tya 
        bne ..skip_update
        dec !score_sprite_y_hi,x
    ..skip_update
        bra .gfx 

    .speed
        db $03,$01,$00,$00

    .return 
        rtl
    .gfx
        lda !score_sprite_layer,x
        asl #2
        tay 
        rep #$20
        lda $001C|!dp,y
        sta $02
        lda $001A|!dp,y
        sta $04
        sep #$20
        lda !score_sprite_x_hi,x
        xba 
        lda !score_sprite_x_lo,x
        rep #$20
        sec 
        sbc $04
        sec 
        sbc #$0006
        cmp #$00EA
        sep #$20
        bcs .return
        lda !score_sprite_y_lo,x
        cmp $02
        lda !score_sprite_y_hi,x
        sbc $03
        bne .return 
        lda $02AD9E,x
        tay 
        lda !score_sprite_y_lo,x
        sec 
        sbc $02
        sta $0201|!addr,y
        sta $0205|!addr,y
        lda !score_sprite_x_lo,x
        sec 
        sbc $04
        clc 
        adc #$09
        sta $0200|!addr,y
        clc 
        adc #$05
        sta $0204|!addr,y
        phx 
        lda !score_sprite_num,x
        sec 
        sbc #$11
        asl 
        tax 
        lda ..num_tile+$00,x 
        sta $0202|!addr,y
        lda ..num_tile+$01,x
        sta $0206|!addr,y
        lda ..num_props+$00,x
        sta $0203|!addr,y
        lda ..num_props+$01,x
        sta $0207|!addr,y
        plx 
        tya 
        lsr #2
        tay 
        lda #$00
        sta $0420|!addr,y
        sta $0421|!addr,y
        lda.l ..oam_2,x
        tay 
        lda !score_sprite_y_lo,x
        sec 
        sbc $02
        sta $0201|!addr,y
        sta $0205|!addr,y
        lda !score_sprite_x_lo,x
        sec 
        sbc $04
        sbc #$07
        sta $0200|!addr,y
        clc 
        adc #$08
        sta $0204|!addr,y
        phx 
        lda !score_sprite_num,x
        sec 
        sbc #$11
        tax 
        lda ..icon_tile,x
        sta $0202|!addr,y
        lda ..icon_props,x
        sta $0203|!addr,y
        lda ..plus_props,x
        sta $0207|!addr,y
        lda ..plus_tile,x
        sta $0206|!addr,y
        plx 
        tya 
        lsr #2
        tay 
        lda #$00
        sta $0420|!addr,y
        sta $0421|!addr,y
        rtl 

    ..icon_tile
        db $1D      ; 1 coin
        db $1D      ; 5 coins
        db $1D      ; 10 coins
        db $1D      ; 15 coins
        db $0F      ; yoshi egg
        db $2E      ; 1up mushroom
        db $2E      ; mushroom
        db $2F      ; flower
        db $3E      ; feather
        db $0E      ; boss token
        db $3F      ; star
        db $1E      ; green yoshi
        db $1E      ; red yoshi
        db $1E      ; blue yoshi
        db $1E      ; yellow yoshi
    ..icon_props
        db $34      ; coin
        db $34      ; coin
        db $34      ; coin
        db $34      ; coin
        db $34      ; yoshi egg
        db $3A      ; 1up mushroom
        db $38      ; mushroom
        db $3A      ; flower
        db $34      ; feather
        db $34      ; boss token
        db $34      ; star
        db $3A      ; green yoshi
        db $38      ; red yoshi
        db $36      ; blue yoshi
        db $34      ; yellow yoshi

    ..plus_tile
        db $0A      ; 1 coin
        db $0A      ; 5 coins
        db $0A      ; 10 coins
        db $0A      ; 50 coins
        db $0A      ; yoshi egg
        db $0A      ; 1up mushroom
        db $0A      ; mushroom
        db $0A      ; flower
        db $0A      ; feather
        db $0A      ; boss token
        db $0A      ; star
        db $0A      ; green yoshi
        db $0A      ; red yoshi
        db $0A      ; blue yoshi
        db $0A      ; yellow yoshi
    ..plus_props
        db $32      ; 1 coin
        db $32      ; 5 coins
        db $32      ; 10 coins
        db $32      ; 50 coins
        db $32      ; yoshi egg
        db $32      ; 1up mushroom
        db $32      ; mushroom
        db $32      ; flower
        db $32      ; feather
        db $32      ; boss token
        db $32      ; star
        db $32      ; green yoshi
        db $32      ; red yoshi
        db $32      ; blue yoshi
        db $32      ; yellow yoshi


    ..num_tile
        db $1B,$69  ; 1 coin
        db $3B,$69  ; 5 coins
        db $1B,$1A  ; 10 coins
        db $3B,$1A  ; 50 coins
        db $1B,$69  ; yoshi egg
        db $1B,$69  ; 1up mushroom
        db $1B,$69  ; mushroom
        db $1B,$69  ; flower
        db $1B,$69  ; feather
        db $1B,$69  ; boss token
        db $1B,$69  ; star
        db $1B,$69  ; green yoshi
        db $1B,$69  ; red yoshi
        db $1B,$69  ; blue yoshi
        db $1B,$69  ; yellow yoshi

    ..num_props
        db $34,$34  ; 1 coin
        db $34,$34  ; 5 coins
        db $34,$34  ; 10 coins
        db $34,$34  ; 15 coins
        db $34,$34  ; yoshi egg
        db $34,$34  ; 1up mushroom
        db $34,$34  ; mushroom
        db $34,$34  ; flower
        db $34,$34  ; feather
        db $34,$34  ; boss token
        db $34,$34  ; star
        db $34,$34  ; green yoshi
        db $34,$34  ; red yoshi
        db $34,$34  ; blue yoshi
        db $34,$34  ; yellow yoshi 


    ..oam_2
        db $50,$58,$60,$68,$70,$78


    .reward_ptrs
        dw .one_coin
        dw .five_coins
        dw .ten_coins
        dw .fifty_coins
        dw .yoshi_egg
        dw .green_mushroom
        dw .mushroom
        dw .flower
        dw .feather
        dw .boss_token
        dw .star
        dw .green_yoshi
        dw .red_yoshi
        dw .blue_yoshi
        dw .yellow_yoshi

    .one_coin
        lda.b #1
        bra .shared_coins
    .five_coins
        lda.b #5
        bra .shared_coins
    .ten_coins
        lda.b #10
        bra .shared_coins
    .fifty_coins
        lda.b #50
    .shared_coins
        clc 
        adc $13CC|!addr
        bcc +
        lda #$FF
    +   
        sta $13CC|!addr
        lda #$01
        sta $1DFC|!addr
        jmp .handle_movement

    .yoshi_egg
        lda $1F24|!addr
        cmp #$FF
        beq ..nope
        inc $1F24|!addr
    ..nope
        lda #$1F
        sta $1DFC|!addr
        jmp .handle_movement
    .boss_token
        inc $1F26|!addr
        lda #$09
        sta $1DFC|!addr
        jmp .handle_movement

    .green_mushroom
        inc $18E4|!addr
        jmp .handle_movement

    .mushroom
        lda #$00
        bra .shared_item
    .flower
        lda #$01
        bra .shared_item
    .feather
        lda #$02
        bra .shared_item
    .star
        lda #$03
        bra .shared_item
    .green_yoshi
        lda #$04
        bra .shared_item
    .red_yoshi
        lda #$05
        bra .shared_item
    .blue_yoshi
        lda #$06
        bra .shared_item
    .yellow_yoshi
        lda #$07
        bra .shared_item
    .shared_item
        jsl add_item
        lda #$0B
        sta $1DFC|!addr
        jmp .handle_movement