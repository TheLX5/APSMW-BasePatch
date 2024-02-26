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

vertical_scroll_levels:
    db $02,$01,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02 ; Levels 000-00F
    db $01,$02,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02 ; Levels 010-01F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 020-02F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 030-03F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 040-04F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 050-05F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 060-06F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 070-07F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 080-08F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 090-09F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0A0-0AF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0B0-0BF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0C0-0CF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02 ; Levels 0D0-0DF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$01,$02,$02 ; Levels 0E0-0EF
    db $02,$02,$01,$02,$02,$01,$01,$02,$02,$01,$02,$02,$02,$02,$01,$02 ; Levels 0F0-0FF
    db $02,$02,$02,$02,$02,$02,$01,$01,$02,$02,$02,$01,$02,$02,$02,$01 ; Levels 100-10F
    db $02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$02 ; Levels 110-11F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 120-12F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 130-13F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 140-14F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 150-15F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 160-16F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 170-17F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 180-18F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 190-19F
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1A0-1AF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1B0-1BF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1C0-1CF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1D0-1DF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1E0-1EF
    db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$02 ; Levels 1F0-1FF

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
;# 
;#########################################################################
;# 
