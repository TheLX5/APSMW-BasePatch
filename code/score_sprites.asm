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
        stx $15E9
        rep #$30
        and #$001F
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
        ldx $15E9
        phb 
        pha 
        plb 
        phk 
        pea.w .return_code-1
        jml [$0000]
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
        dl icon_score                   ; 1B - 
        dl icon_score                   ; 1C - 
        dl icon_score                   ; 1D - 
        dl icon_score                   ; 1E - 
        dl icon_score                   ; 1F - 

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
        jmp ($0000)
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
        lda $001C,y
        sta $02
        lda $001A,y
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
        sta $0201,y
        sta $0205,y
        lda !score_sprite_x_lo,x
        sec 
        sbc $04
        clc 
        adc #$09
        sta $0200,y
        clc 
        adc #$05
        sta $0204,y
        phx 
        lda !score_sprite_num,x
        sec 
        sbc #$11
        asl 
        tax 
        lda ..num_tile+$00,x 
        sta $0202,y
        lda ..num_tile+$01,x
        sta $0206,y
        lda ..num_props+$00,x
        sta $0203,y
        lda ..num_props+$01,x
        sta $0207,y
        plx 
        tya 
        lsr #2
        tay 
        lda #$00
        sta $0420,y
        sta $0421,y
        lda.l ..oam_2,x
        tay 
        lda !score_sprite_y_lo,x
        sec 
        sbc $02
        sta $0201,y
        sta $0205,y
        lda !score_sprite_x_lo,x
        sec 
        sbc $04
        sbc #$07
        sta $0200,y
        clc 
        adc #$08
        sta $0204,y
        phx 
        lda !score_sprite_num,x
        sec 
        sbc #$11
        tax 
        lda ..icon_tile,x
        sta $0202,y
        lda ..icon_props,x
        sta $0203,y
        lda ..plus_props,x
        sta $0207,y
        lda ..plus_tile,x
        sta $0206,y
        plx 
        tya 
        lsr #2
        tay 
        lda #$00
        sta $0420,y
        sta $0421,y
        rtl 

    ..icon_tile
        db $1B      ; 1 coin
        db $1B      ; 5 coins
        db $1B      ; 10 coins
        db $1B      ; 15 coins
        db $0A      ; yoshi egg
        db $0B      ; 1up mushroom
        db $0B      ; mushroom
        db $7E      ; flower
        db $7F      ; feather
        db $38      ; boss token
        db $5A      ;  
        db $5A      ;  
        db $5A      ;  
        db $5A      ;  
        db $0B      ;  
    ..icon_props
        db $34      ; coin
        db $34      ; coin
        db $34      ; coin
        db $34      ; coin
        db $3A      ; yoshi egg
        db $3A      ; 1up mushroom
        db $38      ; mushroom
        db $3A      ; flower
        db $34      ; feather
        db $34      ; boss token
        db $34      ;  
        db $3A      ;  
        db $38      ;  
        db $36      ;  
        db $36      ;  

    ..plus_tile
        db $1A      ; 1 coin
        db $1A      ; 5 coins
        db $1A      ; 10 coins
        db $1A      ; 50 coins
        db $1A      ; yoshi egg
        db $1A      ; 1up mushroom
        db $1A      ; mushroom
        db $1A      ; flower
        db $1A      ; feather
        db $1A      ; boss token
        db $1A      ; 
        db $1A      ; 
        db $1A      ; 
        db $1A      ; 
        db $1A      ; 
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
        db $32      ; 
        db $32      ;  
        db $32      ;  
        db $32      ;  
        db $32      ;  


    ..num_tile
        db $4B,$69  ; 1 coin
        db $5B,$69  ; 5 coins
        db $4B,$4A  ; 10 coins
        db $5B,$4A  ; 50 coins
        db $4B,$69  ; yoshi egg
        db $4B,$69  ; 1up mushroom
        db $4B,$69  ; mushroom
        db $4B,$69  ; flower
        db $4B,$69  ; feather
        db $4B,$69  ; boss token
        db $69,$69  ;  
        db $69,$69  ;  
        db $69,$69  ;  
        db $69,$69  ;  
        db $69,$69  ; 

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
        db $34,$34  ;  
        db $34,$34  ;  
        db $34,$34  ; 
        db $34,$34  ;  
        db $34,$34  ;  


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
        dw .handle_movement
        dw .handle_movement
        dw .handle_movement
        dw .handle_movement
        dw .handle_movement

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
        adc $13CC
        bcc +
        lda #$FF
    +   
        sta $13CC
        lda #$01
        sta $1DFC
        jmp .handle_movement

    .yoshi_egg
        lda $1F24
        cmp #$FF
        beq ..nope
        inc $1F24
    ..nope
        lda #$1F
        sta $1DFC
        jmp .handle_movement
    .boss_token
        inc $1F26
        lda #$09
        sta $1DFC
        jmp .handle_movement

    .green_mushroom
        inc $18E4
        jmp .handle_movement

    .mushroom
        bra .shared_item
    .flower
        bra .shared_item
    .feather
    .shared_item
        lda #$0B
        sta $1DFC
        jmp .handle_movement