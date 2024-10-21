includefrom "main.asm"
;##################################################################################################
;# This file handles everything related to the level game mode

pushpc
    org $00A2E6
        jsl gm14_hijack
pullpc

gm14_hijack:
    if !sa1 == 1
        %invoke_sa1(.sa1)
        rtl
    endif
    .sa1
        phb 
        phk 
        plb 
        lda $0100|!addr
        cmp #$14
        bne .invalid
        lda $71
        beq .valid
    .invalid
        plb 
        jsl $028AB1
    
    if !sa1 == 1
        jsl fill_sprites
        jsl garbage_collector
    endif

        rtl 

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

        plb 
        jsl $028AB1
    
    if !sa1 == 1
        jsl fill_sprites
        jsl garbage_collector
    endif

        rtl 


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
        lda $13F9|!addr
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
        cmp $1F24|!addr,x
        beq .return
        sta $1F24|!addr,x
    .return
        sep #$20
        rts 

;#########################################################################
;# Dynamic Spriteset's late game routines
;# 
;# This file handles any routine that needs to run VERY late into the game.
;# The system uses it to mark tiles as unused and load graphics of recently
;# spawned sprites.

;#########################################################################
;# Load sprite GFXs
;# 
;# This routine checks if a sprite was spawned during this frame and queues
;# its ExGFX if it's not loaded to avoid an extra frame of delay on recently
;# generated sprites.

fill_sprites:
    phb
    phk
    plb


.bounce
    ldx.b #!BounceSize-1
..loop
    lda !bounce_num,x
    beq ..next
    cmp.l !dss_bounce_sprite_copy,x
    sta.l !dss_bounce_sprite_copy,x
    beq ..next
    rep #$30
    and #$00FF
    asl 
    tay 
    lda.w exgfx_ids_bounce_sprites,y
    sep #$30
    jsl find_and_queue_gfx
..next
    dex
    bpl ..loop




.regular
    ldx.b #!SprSize-1
..loop
    lda !14C8,x
    beq ..next 
..regular
    lda !9E,x
    cmp.l !dss_regular_sprite_copy,x
    sta.l !dss_regular_sprite_copy,x
    beq ..next 
    rep #$30
    and #$00FF
    asl 
    tay 
    lda.w exgfx_ids_original_sprites,y
    sep #$30
    jsl find_and_queue_gfx
..next 
    dex 
    bpl ..loop

.extended
    ldx.b #!ExtendedSize+2-1
..loop
    lda !extended_num,x
    beq ..next
    cmp.l !dss_extended_sprite_copy,x
    sta.l !dss_extended_sprite_copy,x
    beq ..next
    rep #$30
    and #$00FF
    asl 
    tay 
    lda.w exgfx_ids_extended_sprites,y
    sep #$30
    jsl find_and_queue_gfx
..next
    dex 
    bpl ..loop



.cluster
    lda $18B8|!addr
    beq ..skip
    ldx.b #!ClusterSize-1
..loop
    lda !cluster_num,x
    beq ..next
    cmp.l !dss_cluster_sprite_copy,x
    sta.l !dss_cluster_sprite_copy,x
    beq ..next
    rep #$30
    and #$00FF
    asl 
    tay 
    lda.w exgfx_ids_cluster_sprites,y
    sep #$30
    jsl find_and_queue_gfx
..next 
    dex
    bpl ..loop
..skip


    plb
    rtl


;#########################################################################
;# Garbage collector
;#
;# Marks tiles and GFX as unused when there's no sprite trying to use them
;# after a determined amount of frames (!dss_time_to_unmark_gfx)
;#
;# To protect any GFX file you should call "find_and_queue_gfx" with the
;# desired GFX file at least once during the frame.
;# UberASM, LevelASM or sprite code should be enough.

garbage_collector:

    pea $0040
    plb
    ldx.b #0
.loop_list
    lda.w !dss_list,x                   ; check if GFX is even loaded/in queue
    cmp #$FF 
    beq .skip_list_slot

    lda.w !dss_list_usage,x             ; check if GFX is being used
    bne .skip_list_slot
    lda.w !dss_list_timer,x             ; decrease timer if not being used
    dec 
    bmi .unmark                         ; if negative/zero, unmark the current file
    sta.w !dss_list_timer,x

.skip_list_slot
    stz.w !dss_list_usage,x             ; reset usage each frame

    inx
    cpx #$20                            ; loop until there are no more slots to check
    bcc .loop_list

    plb
    rtl


.unmark
    lda.w !dss_loaded_tiles             
    sec                                 ; substract tiles loaded
    sbc.w !dss_gfx_size,x
    sta.w !dss_loaded_tiles

    rep #$20
    txa
    asl #5                              ; get index to array of arrays
    adc.w #!dss_tile_buffer_complete
    sta $0D
    sep #$20

    lda !dss_list,x                     ; get GFX file
    sta $0A

    phx
    ldy #$00
    tyx
..loop
    lda ($0D),y
    cmp #$FF
    beq ..next
    ldx #$00
...loop_vram
    cmp.w !dss_vram_dest,x
    beq ..found_offset
    inx 
    bra ...loop_vram
..found_offset
    lda.w !dss_map,x                    ; failsafe: check if gfx num is the same as the one in the map
    cmp $0A
    bne ..next
    lda #$FF
    sta.w !dss_map,x                    ; clear map data

..next
    lda #$FF
    sta ($0D),y                         ; clear tile data

    iny                                 ; loop until every slot has been searched/cleared
    cpy #$20
    bcc ..loop

    plx

    lda #$FF
    sta.w !dss_list,x
    stz.w !dss_list_timer,x
    stz.w !dss_gfx_size,x
    stz.w !dss_list_gfx_loaded,x
    stz.w !dss_list_queue_index,x

    jmp .skip_list_slot


pushpc
    org $00A5AB
        jsl level_init
pullpc

level_init:
    jsl $05809E

    lda $0100|!addr
    cmp #$12
    bne .not_level
    jsr dss_init
    rep #$30
    lda !current_room
    asl 
    tax 
    lda.l level_init_pointers,x
    sta $00
    cmp #$FFFF
    sep #$30
    beq .not_level
    ldx #$00
    jsr (!dp,x)
.not_level
    rtl 


lemmy_wendy_init:
    rep #$30
    ldx.w #.vram_destinations_end-.vram_destinations-2
-   
    lda.l .vram_destinations,x 
    sta.l !dss_vram_dest,x
    dex #2
    bpl -
    sep #$30

    lda.b #.vram_destinations_end-.vram_destinations
    sta.l !dss_maximum_tiles
    rts 
.vram_destinations:
    db $C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
    db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
    db $80,$82,$84,$86,$88,$8A,$8C,$8E
    db $A0,$A2,$A4,$A6,$A8,$AA
..end

mode_7_fights_init:
    wdm 
    rep #$30
    ldx.w #.vram_destinations_end-.vram_destinations-2
-   
    lda.l .vram_destinations,x 
    sta.l !dss_vram_dest,x
    dex #2
    bpl -
    sep #$30

    lda.b #.vram_destinations_end-.vram_destinations
    sta.l !dss_maximum_tiles
    rts 
.vram_destinations:
    db $00,$06,$0A,$0C,$0E
    db $20,$22,$2A,$2C
    db $40,$42,$44,$46,$4E
    db $60,$62,$64,$66,$68,$6E
    db $86,$88,$8A,$8C,$8E
    db $AA,$AC,$AE
    db $C6
..end
bowser_fight_init:
    rep #$30
    ldx.w #.vram_destinations_end-.vram_destinations-2
-   
    lda.l .vram_destinations,x 
    sta.l !dss_vram_dest,x
    dex #2
    bpl -
    sep #$30

    lda.b #.vram_destinations_end-.vram_destinations
    sta.l !dss_maximum_tiles
    rts 
.vram_destinations:
    db $00,$0A,$0C,$0E
    db $40,$46,$4A,$4C
    db $60,$62,$64,$66,$6A,$6C,$6E
    db $88
    db $A2,$A4,$AC
    db $C0,$C2,$C4,$C8,$CA,$CC,$CE
    db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
..end
switch_palace_button_init:
    rep #$30
    ldx.w #.vram_destinations_end-.vram_destinations-2
-   
    lda.l .vram_destinations,x 
    sta.l !dss_vram_dest,x
    dex #2
    bpl -
    sep #$30

    lda.b #.vram_destinations_end-.vram_destinations
    sta.l !dss_maximum_tiles
    rts 
.vram_destinations:
    db $04,$06,$08,$0A,$0C,$0E
    db $20,$22,$24,$26,$28,$2A,$2C,$2E
    db $40,$42,$44,$46,$48,$4A,$4C,$4E
    db $60,$62,$64,$66,$68,$6A,$6C,$6E
    db $80,$82,$84,$86,$88,$8A,$8C,$8E
    db $A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
    db $C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
    db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
..end



dss_init:
    pea $0040
    plb
    rep #$30

    stz.w !dss_gfx_queue_index_nmi
    stz.w !dss_gfx_queue_index_game
    stz.w !dss_ram_buffer_index

    lda.w #0064
    sta.w !dss_maximum_tiles

    lda #$FFFF
    ldx.w #32-2
-   
    sta.w !dss_map,x
    sta.w !dss_map+32,x
    sta.w !dss_list,x
    stz.w !dss_gfx_size,x
    stz.w !dss_list_usage,x
    stz.w !dss_tile_buffer,x
    stz.w !dss_list_gfx_loaded,x
    stz.w !dss_list_queue_index,x
    dex #2
    bpl -

    ldx.w #256-2
-   
    stz.w !dss_gfx_queue,x
    sta.w !dss_tile_buffer_complete,x
    sta.w !dss_tile_buffer_complete+256,x
    sta.w !dss_tile_buffer_complete+512,x
    sta.w !dss_tile_buffer_complete+768,x
    dex #2
    bpl -

    ldx.w #default_vram_destinations_end-default_vram_destinations-2
-   
    lda.l default_vram_destinations,x 
    sta.w !dss_vram_dest,x
    dex #2
    bpl -

    ldx.w #22-2
-   
    stz.w !dss_regular_sprite_copy,x
    dex #2
    bpl -

    ldx.w #10-2
-   
    stz.w !dss_extended_sprite_copy,x
    stz.w !dss_cluster_sprite_copy,x
    stz.w !dss_cluster_sprite_copy+10,x
    stz.w !dss_minor_extended_sprite_copy,x
    dex #2
    bpl -

    stz.w !dss_minor_extended_sprite_copy+10,x
    stz.w !dss_bounce_sprite_copy,x
    stz.w !dss_bounce_sprite_copy+2,x

    plb
    sep #$30

    rts


default_vram_destinations:
    db $00,$02,$04,$06,$08,$0A,$0C,$0E
    db $20,$22,$24,$26,$28,$2A,$2C,$2E
    db $40,$42,$44,$46,$48,$4A,$4C,$4E
    db $60,$62,$64,$66,$68,$6A,$6C,$6E
    db $80,$82,$84,$86,$88,$8A,$8C,$8E
    db $A0,$A2,$A4,$A6,$A8,$AA,$AC,$AE
    db $C0,$C2,$C4,$C6,$C8,$CA,$CC,$CE
    db $E0,$E2,$E4,$E6,$E8,$EA,$EC,$EE
.end
