includefrom "main.asm"
;##################################################################################################
;# This file handles everything related to score sprites, also known as indicators

pushpc
    org $00A2E6
        jsl gm14_hijack
pullpc

gm14_hijack:
        lda $0100
        cmp #$14
        bne .invalid
        lda $71
        beq .valid
    .invalid
        jml $028AB1
    .valid
        rep #$30
        lda !score_sprite_add_1_coin
        beq .no_1_coin
        jsr add_1_coin
    .no_1_coin
        lda !score_sprite_add_5_coins
        beq .no_5_coins
        jsr add_5_coins
    .no_5_coins
        lda !score_sprite_add_10_coins
        beq .no_10_coins
        jsr add_10_coins
    .no_10_coins
        lda !score_sprite_add_15_coins
        beq .no_15_coins
        jsr add_15_coins
    .no_15_coins
        lda !score_sprite_add_1up
        beq .no_1up
        jsr add_1up
    .no_1up
        lda !score_sprite_add_yoshi_egg
        beq .no_yoshi_egg
        jsr add_yoshi_egg
    .no_yoshi_egg
        lda !score_sprite_add_boss_token
        beq .no_boss_token
        jsr add_boss_token
    .no_boss_token
        lda !score_sprite_add_mushroom
        beq .no_mushroom
        jsr add_mushroom
    .no_mushroom
        lda !score_sprite_add_flower
        beq .no_flower
        jsr add_flower
    .no_flower
        lda !score_sprite_add_feather
        beq .no_feather
        jsr add_feather
    .no_feather
        lda !score_sprite_add_star
        beq .no_star
        jsr add_star
    .no_star
        lda !score_sprite_add_green_yoshi
        beq .no_green_yoshi
        jsr add_green_yoshi
    .no_green_yoshi
        lda !score_sprite_add_red_yoshi
        beq .no_red_yoshi
        jsr add_red_yoshi
    .no_red_yoshi
        lda !score_sprite_add_blue_yoshi
        beq .no_blue_yoshi
        jsr add_blue_yoshi
    .no_blue_yoshi
        lda !score_sprite_add_yellow_yoshi
        beq .no_yellow_yoshi
        jsr add_yellow_yoshi
    .no_yellow_yoshi
        sep #$30

        jsr goal_sanity_check

        jsr score_sprite_queue

        jml $028AB1


score_sprite_queue:
        lda !score_sprite_queue_delay
        beq .spawn
        dec 
        sta !score_sprite_queue_delay
        rts 
    .spawn
        lda #$08
        sta !score_sprite_queue_delay
        rep #$30
        lda !score_sprite_index
        cmp !score_sprite_count
        bne .check_slots
        sep #$30
        rts 
    .check_slots
        ldy #$0005
    ..loop
        lda !score_sprite_num,y
        and #$00FF
        beq .found_free
        dey 
        bpl ..loop
        sep #$30
        rts 
    .found_free
        lda !score_sprite_index
        inc 
        tax 
        sta !score_sprite_index
        lda !score_sprite_queue,x
        sep #$30
        sta !score_sprite_num,y
        lda $94
        sta !score_sprite_x_lo,y
        lda $95
        sta !score_sprite_x_hi,y
        lda $96
        sta !score_sprite_y_lo,y
        lda $97
        sta !score_sprite_y_hi,y
        lda #$30
        sta !score_sprite_timer,y
        lda $13F9
        sta !score_sprite_layer,y
        rts 


    add_1_coin:
        lda !score_sprite_add_1_coin
        dec 
        sta !score_sprite_add_1_coin
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$11
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_5_coins:
        lda !score_sprite_add_5_coins
        dec 
        sta !score_sprite_add_5_coins
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$12
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_10_coins:
        lda !score_sprite_add_10_coins
        dec 
        sta !score_sprite_add_10_coins
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$13
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_15_coins:
        lda !score_sprite_add_15_coins
        dec 
        sta !score_sprite_add_15_coins
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$14
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_1up:
        lda !score_sprite_add_1up
        dec 
        sta !score_sprite_add_1up
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$16
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_yoshi_egg:
        lda !score_sprite_add_yoshi_egg
        dec 
        sta !score_sprite_add_yoshi_egg
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$15
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_boss_token:
        lda !score_sprite_add_boss_token
        dec 
        sta !score_sprite_add_boss_token
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1A
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_mushroom:
        lda !score_sprite_add_mushroom
        dec 
        sta !score_sprite_add_mushroom
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$17
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_flower:
        lda !score_sprite_add_flower
        dec 
        sta !score_sprite_add_flower
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$18
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_feather:
        lda !score_sprite_add_feather
        dec 
        sta !score_sprite_add_feather
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$19
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_star:
        lda !score_sprite_add_star
        dec 
        sta !score_sprite_add_star
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1B
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_green_yoshi:
        lda !score_sprite_add_green_yoshi
        dec 
        sta !score_sprite_add_green_yoshi
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1C
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_red_yoshi:
        lda !score_sprite_add_red_yoshi
        dec 
        sta !score_sprite_add_red_yoshi
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1D
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_blue_yoshi:
        lda !score_sprite_add_blue_yoshi
        dec 
        sta !score_sprite_add_blue_yoshi
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1E
        sta !score_sprite_queue,x
        rep #$20
        rts

    add_yellow_yoshi:
        lda !score_sprite_add_yellow_yoshi
        dec 
        sta !score_sprite_add_yellow_yoshi
        lda !score_sprite_count
        inc 
        sta !score_sprite_count
        tax 
        sep #$20
        lda #$1F
        sta !score_sprite_queue,x
        rep #$20
        rts

goal_sanity_check:
        lda.l goal_setting
        and #$01
        eor #$01
        asl 
        rep #$20
        lda !score_sprite_add_yoshi_egg,x
        bne .return
    .check_queue
        lda !score_sprite_index
        cmp !score_sprite_count
        bne .return
    .check_count
        sep #$20
        lda !goal_item_count
        cmp $1F24,x
        beq .return
        sta $1F24,x
    .return
        sep #$20
        rts 