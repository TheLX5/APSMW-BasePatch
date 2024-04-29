includefrom "main.asm"
;##################################################################################################
;# This file includes everything that's meant to prepare a way to track locations with ease
;# on the Python side.

;#########################################################################
;# Blocksanity related code
;# It's going to be always inserted as there's no reason to exclude
;# this code, it doesn't hurt the final patch.

pushpc
    org $00F1D0
        jml blocksanity_main

    org $01AD59
        jml blocksanity_flying_init
        
    org $01AE16
        jsl blocksanity_flying_main
pullpc

blocksanity_main:
    sta $05
    phb 
    lda.b #blocksanity_pointers>>16
    pha 
    plb 
    phy 
    jsr process_block
    ply 
    plb 
    lda $05
    cmp #$05
    jml $00F1D4

blocksanity_flying_init:
    lda $D8,x
    and #$F0
    sta !sprite_blocksanity_y_lo,x
    lda $14D4,x
    sta !sprite_blocksanity_y_hi,x
    lda $14E0,x
    sta !sprite_blocksanity_x_hi,x
    lda $E4,x
    and #$F0
    sta !sprite_blocksanity_x_lo,x
    jsr blocksanity_keep_collected_flying_block
    lda $E4,x
    lsr #2
    jml $01AD5D

blocksanity_flying_main:
    lda !sprite_blocksanity_y_lo,x
    sta $98
    lda !sprite_blocksanity_y_hi,x
    sta $99
    lda !sprite_blocksanity_x_lo,x
    sta $9A
    lda !sprite_blocksanity_x_hi,x
    sta $9B
    phb 
    lda.b #blocksanity_pointers>>16
    pha 
    plb 
    phy 
    phx 
    jsr process_block
    plx 
    ply 
    plb 
    lda $E4,x
    sta $9A
    rtl 
    
process_block:
    lda #$0F
    trb $98
    trb $9A

    rep #$30
    lda !shuffled_ow_level
    and #$00FF
    asl 
    clc 
    adc.w #blocksanity_pointers
    pha 
    ldy #$0000
    lda ($01,s),y
    pha 
.loop
    lda ($01,s),y
    cmp #$FFFF
    beq .return
    cmp $9A
    bne .next_block_x
    iny #2
    lda ($01,s),y
    cmp $98
    beq .valid_block
    bra .next_block_y
.next_block_x
    iny #2
.next_block_y 
    iny #4
    bra .loop
.return
    pla 
    pla 
    sep #$30
    rts 

.valid_block
    iny #2
    lda ($01,s),y
    tax 
    sep #$20
    phx 
    lda !blocksanity_data_flags,x
    bne .processed
    inc 
    sta !blocksanity_data_flags,x
    jsr blocksanity_check_flags
.processed
    plx 
    plx 
    plx 
    sep #$10
    rts 

blocksanity_check_flags:
    rep #$20
    ldy #$0000
.loop
    lda ($05,s),y
    cmp #$FFFF
    beq .check
    iny #4
    lda ($05,s),y
    tax 
    lda !blocksanity_data_flags,x
    and #$00FF
    beq .invalid
    iny #2
    bra .loop
.check
    sep #$20
    lda #$00
    xba 
    lda !shuffled_ow_level
    lsr #3
    tay 
    lda !shuffled_ow_level
    and #$07
    tax 
    lda.l $05B35B,x
    tyx 
    ora !blocksanity_flags,x
    sta !blocksanity_flags,x
    rts 
.invalid
    sep #$20
    rts 

;#########################################################################
;# Handles prizes from Bonus Blocks

pushpc
    org $00F1A5
        jml prize_from_bonus_block
pullpc

prize_from_bonus_block:
    lda #$06
    ldy $0DC0
    bne .ignore
    phx 
    lda !current_ow_level
    lsr #3
    pha 
    lda !current_ow_level
    and #$07
    tax 
    lda $05B35B,x
    plx 
    ora !bonus_block_flags,x
    sta !bonus_block_flags,x
    plx 
    lda #$05
.ignore
    jml $00F1D0

;#########################################################################
;# 

pushpc
    org $0DA92E
        jml blocksanity_keep_collected_coin_block
    org $0DA5BF
        jml blocksanity_keep_collected_item_block
    org $0DB58F
        jml blocksanity_keep_collected_switch

pullpc

blocksanity_keep_collected:
.coin_block
    cpx #$09
    beq ..valid
..normal_behavior
    lda.l $0DA8B4,x
    jml $0DA932
..valid
    lda.l blocksanity_enabled_flag 
    beq ..normal_behavior
    lda.l block_collect_behavior
    and #$01
    beq ..normal_behavior
    jsr .check_block
    beq ..normal_behavior
    cmp #$FF
    beq ..normal_behavior
    lda #$32
    jml $0DA932

.flying_block
    lda.l blocksanity_enabled_flag 
    beq ..normal_behavior
    lda.l block_collect_behavior
    and #$01
    beq ..normal_behavior
    lda $E4,x
    lsr #4
    sta $00
    lda $D8,x
    and #$F0
    ora $00
    tay 
    lda $14D4,x
    asl #4
    sta $0A
    lda $14E0,x
    sta $1BA1
    jsr .check_block
    beq ..normal_behavior
    cmp #$FF
    beq ..normal_behavior
    inc $C2,x
..normal_behavior
    rts 

.item_block
    lda.l blocksanity_enabled_flag 
    beq ..normal_behavior
    lda.l block_collect_behavior
    and #$02
    beq ..normal_behavior
    lda.l ..blocks,x
    beq ..normal_behavior
    cmp #$01
    beq ..note_block
..turn_question_block
    jsr .check_block
    beq ..normal_behavior
    cmp #$FF
    beq ..normal_behavior
    lda #$32
    jml $0DA64A

..normal_behavior
    lda.l $0DA548,x
    jml $0DA5C3

..note_block
    jsr .check_block
    beq ..normal_behavior
    cmp #$FF
    beq ..normal_behavior
    lda #$13
    jml $0DA64A

..blocks
    db $00,$00,$00,$00,$00,$00,$00,$00
    db $00,$00,$00,$00,$00,$00,$00,$00
    db $00,$00,$00,$01,$00,$00,$00,$00
    db $02,$02,$02,$00,$00,$02,$02,$02
    db $02,$02,$02,$02,$00,$00,$02,$02
    db $02,$02,$00,$00,$00,$00,$00,$00
    db $00,$00,$00,$00,$00,$00,$00,$00
    db $00,$00,$00,$00,$00,$00,$00,$00

.switch
    lda.l blocksanity_enabled_flag 
    beq ..normal_behavior
    lda.l block_collect_behavior
    and #$02
    beq ..normal_behavior
    jsr .check_block
    beq ..normal_behavior
    cmp #$FF
    beq ..normal_behavior
..collected 
    lda #$01
    sta [$6E],y
    lda #$32
    jml $0DB5A5
..normal_behavior
    lda $1F27,x
    bne ..fill
    jml $0DB594
..fill
    jml $0DB59E

.check_block
    phb 
    lda.b #blocksanity_pointers>>16
    pha 
    plb 
    phy 
    phx
    php
    lda $0A
    lsr #4
    and #$01
    pha 
    tya 
    and #$F0
    pha 
    lda $1BA1
    pha 
    tya 
    asl #4
    pha 

    lda $5B
    lsr 
    bcc ..horizontal_level
..vertical_level
    lda $02,s
    tay 
    lda $04,s
    sta $02,s
    tya 
    sta $04,s 
..horizontal_level
    
    rep #$30
    lda !shuffled_ow_level
    and #$00FF
    asl 
    clc 
    adc.w #blocksanity_pointers
    pha 
    ldy #$0000
    lda ($01,s),y
    pha 
..loop
    lda ($01,s),y
    cmp #$FFFF
    beq ..return
    cmp $05,s
    bne ..next_block_x
    iny #2
    lda ($01,s),y
    cmp $07,s
    beq ..valid_block
    bra ..next_block_y
..next_block_x
    iny #2
..next_block_y 
    iny #4
    bra ..loop
..return
    plx 
    plx 
    plx 
    plx 
    plp 
    plx 
    ply
    plb 
    lda #$FF
    cmp #$FF
    rts 

..valid_block
    iny #2
    lda ($01,s),y
    tax 
    sep #$20
    lda !blocksanity_data_flags,x
..processed
    plx
    plx 
    plx 
    plx 
    plp 
    plx 
    ply
    plb
    cmp #$00
    rts 
