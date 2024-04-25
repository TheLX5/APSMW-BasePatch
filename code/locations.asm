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
