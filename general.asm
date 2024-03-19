@includefrom "main.asm"
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

    org $008FF0
        sta $0EFE,x

    org $008C94
        db $3C
    org $008C9C
        db $38

    org $008C93
        db $FC,$38 ; $008C93
        db $FC,$3C ; $008C95
        db $FC,$3C ; $008C97
        db $FC,$3C ; $008C99
        db $FC,$3C ; $008C9B
        db $FC,$38 ; $008C9D
        db $FC,$38 ; $008C9F

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
            lda $A5B9,y
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
            fillbyte $00 : fill $0800

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
        nop #4
    org $05D7CB
        jsl fix_ow_level_check
        nop #4

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
;# 

pushpc
pullpc


;#########################################################################
;# 

pushpc
pullpc


;#########################################################################
;# 

pushpc
pullpc
