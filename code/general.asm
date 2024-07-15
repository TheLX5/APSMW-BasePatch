includefrom "main.asm"
;##################################################################################################
;# This file includes everything that doesn't fit into another file

;#########################################################################
;# Get the room index number

pushpc
    org $05D8B9
        jsr level_num

    org $05DC46
        level_num:
            lda $0E
            sta !current_room
            asl 
            rts 
pullpc

;#########################################################################
;# Each level gets its vertical scroll settings overwritten, that way
;# some levels are easier to navigate through.

pushpc
    org $0585BA
        jsl vertical_scroll
pullpc

vertical_scroll:
    lsr 
    lsr 
    lsr 
    lsr 
    php 
    cmp #$02
    bne +
    rep #$10
    phx 
    ldx !current_room
    lda.l vertical_scroll_levels,x
    plx 
+   
    plp
    rtl 

;#########################################################################
;# Remaps Special World cleared flag to another RAM so it isn't tied
;# to Funky's completion

pushpc
    org $00AA74
        dw !special_world_clear_flag

    org $019826
        dw !special_world_clear_flag

    org $01B9CD
        dw !special_world_clear_flag

    org $02A986
        dw !special_world_clear_flag

    org $0CAE0F
        dw !special_world_clear_flag
pullpc

;#########################################################################
;# Makes the HUD star counter go up to 255 (999 really)
;# Remaps a bunch of stuff basically

pushpc

    org $008F5B
        jmp $8F73

    org $008F94
        ldx #$08

    org $008F96
        ldy #$0C

    org $008FAB
        cpx #$02

    org $008F9D
        lda $0F1D,x

    org $008FA4
        sta $0F1D,x

    org $008FA7
        sta $0F02,x 

    org $008FAF
        lda $0F1D,x
    org $008FB7
        sta $0F02,x
    org $008FBD
        sta $0F1D,x
    org $008FC1
        cpx #$03

    ; # Move Dragon coins one spot to the left & fix tilemap
    org $008FEF
        sta $0EFE,x
    org $008C94
        db $3C
    org $008C9C
        db $38

pullpc

;#########################################################################
;# Initialize RAM

pushpc
    org $0093BB
        jml init_ram
pullpc

    init_ram:
        lda #$AA
        sta $0400
    clear_level_data:
            lda #$00
            ldx #$5F
        .loop
            sta !level_clears,x
            dex 
            bpl .loop
            rep #$10
            ldx.w #$000B
        - 
            sta !blocksanity_flags,x
            sta !yoshi_coins_flags,x
            sta !moons_flags,x
            sta !bonus_block_flags,x
            sta !checkpoints_flags,x
            dex 
            bpl -

            ldx.w #!blocksanity_locs-1
        -   
            sta !blocksanity_data_flags,x
            dex 
            bpl -

            ldx #$0422
        -   
            sta !score_sprite_count,x
            dex 
            bpl -

            sta !special_world_clear_flag
            sta !received_items_count+$00
            sta !received_items_count+$01
            sta !goal_item_count
            sta !death_counter+$00
            sta !death_counter+$01
            sta !death_counter+$02
            sta !coin_counter+$00
            sta !coin_counter+$01
            sta !coin_counter+$02
            sta !energy_link_transfer+$00
            sta !energy_link_transfer+$01
            sta !energy_link_purchase+$00
            sta !energy_link_purchase+$01
            sta !energy_link_item
            sta !energy_link_reply
            sta !energy_link_count+$00
            sta !energy_link_count+$01

            lda #$FF
            sta !thwimp_index
        
            sep #$10
            jsl clear_tilemap
            jml $0093C0

;#########################################################################
;# Rearranges Yoshi's Message ID to load messages from RAM

pushpc
    org $05B20F
        jsr yoshi_ram_message
    org $05DC60
        yoshi_ram_message:
            lda $1426
            cmp #$03
            beq .yoshi_message
            lda $A5D9,y
            rts 
        .yoshi_message
            phx 
            tyx 
            lda.l $7EC200,x
            plx 
            rts 

    ;# Disable Yoshi showing a message
    org $01EC3D
        nop #3
pullpc


;#########################################################################
;# Makes Bowser throw infinite balls on his second phase if the requirements
;# aren't met

pushpc
    org $03A509
        jml bowser_infinite_balls
pullpc

bowser_infinite_balls:
        lda.l goal_setting
        bne .nope
        lda $0F48
        cmp.l required_bosses_setting
        bcc .nope
        inc $14B8
    .nope
        lda $14B8
        jml $03A50F

;#########################################################################
;# Level shuffle setup

pushpc
    ;# Prepare second level table
    org $06F600
        shuffled_level_table:
            incbin "data/level_default_data.bin"
            ;fillbyte $00 : fill $0800

    ;# Repoint level load pointer
    org $05D89B
        jsl repoint_level_table
    ;# Repoint midway gate pointer
    org $048F45
        jsl repoint_level_table
    ;# Repoint level name pointer
    org $048E7A
        jsl repoint_level_table
    ;# Repoint another level name pointer
    org $049542
        jsl repoint_level_table
    ;# Repoint level beaten pointer
    org $048F63
        jsl repoint_level_table

    org $05D8AE
        jsl fix_ow_level_check
        nop #5
    org $05D7CB
        jsl fix_ow_level_check
        nop #5

    org $0392FB
        jsl fix_snake_blocks
        nop 
    
pullpc

repoint_level_table:
        lda.l level_shuffle_active
        beq .nope
        lda.l shuffled_level_table,x
        rtl 
    .nope
        lda $7ED000,x
        rtl 

fix_ow_level_check:
        phx 
        php 
        sep #$30
        ldx !current_ow_level
        cpx #$25
        bcc +
        ldx #$01
        bra ++
    +
        ldx #$00
    ++   
        stx $0F
        plp 
        plx 
        rtl

fix_snake_blocks:
        lda !current_ow_level
        cmp #$20
        beq +
        lda #$01
        cmp #$01
        rtl
    +   
        lda #$00
        cmp #$01
        rtl 

;#########################################################################
;# Handle collected paths

pushpc
    org $009F5B
        jsl collected_paths
        nop #2
pullpc

collected_paths:
        lda $0100
        cmp #$0B
        bne +
        jsl $04DAAD 
    +   
        inc $0100
        lda $0DAF
        rtl 

;#########################################################################
;# Fixes CI2 so people aren't locked out from entering the DC Room at the
;# end when they posses the DC checks.

pushpc
    org $05DB3E
        jml fix_choco_island_2
pullpc

fix_choco_island_2:
        lda $1F2F+$04
        and #$08
        bne .dc_room
        lda $1422
        cmp #$04
        beq .dc_room
    .rex_room
        ldx #$02
        jml $05DB49
    .dc_room
        ldx #$00
        jml $05DB49

;#########################################################################
;# Delete Routine that would copy Mario position data over repurposed Luigi save data

pushpc
    org $048F9F
        nop #61
pullpc


;#########################################################################
;# Repurpose Bonus Stars counter for Boss Token or Yoshi Eggs

pushpc
    org $07F1AA
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
        db $00,$00,$00,$00,$00,$00,$00,$00
pullpc

;#########################################################################
;# Prevent Switch Palaces setting the Switch Palace flags

pushpc
    org $0DEC9A
        nop #2
    org $00EEB1
        nop #2
    org $00EEB4
        nop #3
pullpc

;#########################################################################
;# Title Options

pushpc
    org $009E6A
        db $01
    org $009E6C
        db $01
    org $009E6E
        db $01
pullpc

;#########################################################################
;# Always allow Start+Select

pushpc
    org $00A267
        nop #2
pullpc


;#########################################################################
;# Move Thwimps tilemap to another spot in VRAM in order to make them global

pushpc
    org $019C13
        db $7E,$7E,$7F,$7F
    org $07F425
        db $32
pullpc

;#########################################################################
;# Mario Start! -> Player Start!

pushpc
    org $0090D1
        db $00,$FF,$4D,$4C,$03,$4D,$5D,$FF,$4C,$4B
        db $4A,$03,$4E,$01,$00,$02,$00,$4a,$4E,$FF
        
    org $009139
        db $34,$30,$34,$34,$34,$34,$34,$30,$34,$34
        db $34,$34,$34,$34,$34,$34,$34,$34,$34,$30

    org $009105
        db $10,$FF,$00,$5C,$13,$00,$5D,$FF,$5C,$5B
        db $00,$13,$5E,$11,$00,$12,$00,$03,$5E,$FF

    org $00916A
        db $34,$30,$b4,$34,$34,$b4,$f4,$30,$34,$34
        db $B4,$34,$34,$34,$b4,$34,$b4,$b4,$34,$30
pullpc

;#########################################################################
;# Title Screen Text

pushpc
    org $05B815 ;# MARIO B
        for i = 0..16
            db $FC,$38
        endfor 
    org $05B74A ;# MARIO B
        for i = 0..16
            db $FC,$38
        endfor 
    
    org $05B839 ;# MARIO C
        db $71, $31, $74, $31, $2D, $31, $84, $30
        db $82, $30, $6F, $31, $73, $31, $70, $31
        db $71, $31, $75, $31, $83, $30, $FC, $38
        db $FC, $38, $FC, $38, $FC, $38, $FC, $38
    org $05B76E ;# MARIO C
        for i = 0..16
            db $FC,$38
        endfor 

    org $05B79E ;# EMPTY
        for i = 0..5
            db $FC,$38
        endfor 
    org $05B7AE ;# EMPTY
        for i = 0..5
            db $FC,$38
        endfor 

    org $05B8A8 ;# 2 PLAYER GAME
        for i = 0..13
            db $FC,$38
        endfor 

    org $05B85D ;# ERASE
        for i = 0..10
            db $FC,$38
        endfor 

    org $05B88E ;# 1 Player Game
        db $2C, $31, $73, $31, $75, $31, $82, $30, $30, $31, $FC, $38, $31, $31, $73, $31
        db $73, $31, $7C, $30, $FC, $38, $FC, $38, $FC, $38
    org $05B6D7 ;# Mod by PoryGone + lx5
        db $16, $38, $18, $38, $0D, $38, $FC, $38, $0B, $38, $22, $38
        db $FC, $38, $19, $38, $18, $38, $1B, $38, $22, $38, $10, $38, $18, $38, $17, $38
        db $0E, $38, $FC, $38, $15, $38, $21, $38, $05, $38
pullpc



;#########################################################################
;# Prevent Title Screen Deaths

pushpc
    org $009C6A
        db $80
pullpc

;#########################################################################
;# Disable something in yoshi house related to the message

pushpc
    org $05B1D8
        db $80
pullpc

;#########################################################################
;# EnergyLink & Coin tracking

pushpc
    org $05B352
        jml single_coin_tracking
    org $05B329
        jml multiple_coin_tracking
pullpc

single_coin_tracking:
        lda $0DC0
        beq +
        dec $0DC0
    +   
        lda #$01
    .add_coins
        pha 
        php 
        sed 
        rep #$21
        adc !coin_counter+$00
        sta !coin_counter+$00
        sep #$20
        bcc .done
        lda !coin_counter+$02
        adc #$00
        sta !coin_counter+$02
        bcc .done
        lda #$99
        sta !coin_counter+$00
        sta !coin_counter+$01
        sta !coin_counter+$02
    .done
        plp
        pla 
    .add_energy
        rep #$20
        and #$00FF
        clc 
        adc !energy_link_transfer
        sta !energy_link_transfer
        sep #$20
        rtl 

multiple_coin_tracking:
        sta $0DC0
        lda $00
        bra single_coin_tracking_add_coins

;#########################################################################
;# Don't reset Star timer between pipes/doors

pushpc
    org $00A635
            lda $1490
            bne no_music_change
            lda #$00
            ora $1490
            ora $190C
            beq no_music_change
            lda $0DDA
            bpl +
            and #$7F
            ora #$40
        +   
            sta $0DDA
        no_music_change:
            stz $190C
            bra end_music_change
    org $00A660 
        end_music_change:
            lda $13F4
            ora $13F5

    org $009738
    -   
        jml level_music_hijack
        db $FB
        bra -
        nop 
    level_music_hijack_end:

    org $00E2F2
        and #$3F

    org $058551
        jsl level_music_load

    org $00C533
        jml pswitch_done

pullpc

level_music_hijack:
        lda #$00
        ora $1490
        bne +
        lda $0DDA
        and #$40
        bne +
        lda $0DDA
        and #$BF
        sta $1DFB
    +   
        jml level_music_hijack_end


level_music_load:
        lda #$40
        trb $0DDA
        lda $0584DB,x
        ldx $0DDA
        bpl +
        ora #$80
    +
        cmp $0DDA
        bne +
        ora #$40
    +   
        rtl 

pswitch_done:
        ldy $14AD
        cpy $14AE
        bcs +
        ldy $14AE
    +   
        cpy #$01
        bne .done
        ldy $190C
        bne .done
        lda $1490
        beq .not_star
        lda $0DDA
        bmi .done
        lda #$0D
        bra +
    .not_star
        lda $0DDA
        and #$BF
    +   
        sta $1DFB
    .done
        jml $00C54F


;#########################################################################
;# 

pushpc
pullpc



;#########################################################################
;# 

pushpc
pullpc
