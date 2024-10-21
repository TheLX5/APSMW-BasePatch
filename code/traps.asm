includefrom "main.asm"
;##################################################################################################
;# This file makes the entire game use FastROM addressing

pushpc
    org $00A2D8
        jsl handle_traps

    org $00C9FE
        jsl reset_traps
        nop #2
pullpc

reset_traps:
        sta $0DD5|!addr
        lda #$01
        sta !reset_reverse_controls_trap
        sta !reset_fishin_boo_trap
        sta !reset_ice_trap
        lda $13C6|!addr
        rtl 

handle_traps:
        lda $0100|!addr
        cmp #$14
        bne .invalid
        lda $71
        beq .valid
    .invalid
        lda #$FF
        sta !thwimp_index
        jml $00E2BD
    .valid
        lda !reverse_controls_trap
        beq .no_reverse_controls
        jsr reverse_controls_trap
    .no_reverse_controls
    
        lda !thwimp_trap
        beq .no_thwimp
        jsr spawn_thwimp
    .no_thwimp
        jsr handle_thwimp
        
        lda !fishin_boo_trap
        and #$7F
        beq .no_fishin_boo
        jsr spawn_fishin_boo
    .no_fishin_boo

        lda !ice_trap
        beq .no_ice_trap
        jsr ice_trap
    .no_ice_trap

        jml $00E2BD

ice_trap:
        lda #$01
        sta $86
        rts 

reverse_controls_trap:
    .swap_left_and_right
        lda $15
        bit #$03
        beq ..no_swap_hold
        eor #$03
        sta $15
    ..no_swap_hold
        lda $16
        bit #$03
        beq ..no_swap_press
        eor #$03
        sta $16
    ..no_swap_press
    .swap_up_and_down
        lda $15
        bit #$0C
        beq ..no_swap_hold
        eor #$0C
        sta $15
    ..no_swap_hold
        lda $16
        bit #$0C
        beq ..no_swap_press
        eor #$0C
        sta $16
    ..no_swap_press

    .swap_a_and_b
        lda $16
        bpl ..no_swap_b
        eor #$80
        sta $16
        lda $18
        eor #$80
        sta $18
        bra .swap_l_and_r
    ..no_swap_b
        lda $18
        bpl .swap_l_and_r
        eor #$80
        sta $18
        lda $16
        eor #$80
        sta $16

    .swap_l_and_r
        lda $17
        bit #$30
        beq ..no_swap_hold
        eor #$30
        sta $17
    ..no_swap_hold
        lda $17
        bit #$30
        beq ..no_swap_press
        eor #$30
        sta $18
    ..no_swap_press
        rts

;#########################################################################

spawn_thwimp:
        lda !thwimp_index
        tax 
        bpl .return
        jsl $02A9E4
        bpl .found
    .return
        rts 
    .found
        tyx 
        lda #$00
        sta !thwimp_trap
        lda #$10
        sta $1DF9|!addr
        lda #$27
        sta !9E,x
        lda #$08
        sta !14C8,x
        jsl $07F7D2
        lda $94
        sta !E4,x
        lda $95
        sta !14E0,x
        lda $1C
        sec 
        sbc #$0F
        sta !D8,x
        lda $1D
        sbc #$00
        sta !14D4,x
        lda !1686,x
        ora #$80
        sta !1686,x
        txa 
        sta !thwimp_index
        rts 

handle_thwimp:
        lda !thwimp_index
        bmi .return
        tax 
        lda !14D4,x
        xba 
        lda !D8,x
        rep #$20
        sec 
        sbc $96
        sep #$20
        bmi .return
        lda #$FF
        sta !thwimp_index
        lda !1686,x
        and #$7F
        sta !1686,x
    .return
        rts 


;#########################################################################

spawn_fishin_boo:
        lda !fishin_boo_index
        tax 
        bpl .return
        jsl $02A9E4
        bpl .found
    .return
        rts 
    .found
        tyx
        lda #$81
        sta !fishin_boo_trap
        lda #$10
        sta $1DF9|!addr
        lda #$AE
        sta !9E,x
        lda #$08
        sta !14C8,x
        jsl $07F7D2
        rep #$20
        lda $1A
        clc 
        adc #$011D
        sep #$20
        sta !E4,x
        xba 
        sta !14E0,x
        lda $1C
        clc 
        adc #$15
        sta !D8,x
        lda $1D
        adc #$00
        sta !14D4,x
        lda !167A,x
        ora #$04
        sta !167A,x
        txa 
        sta !fishin_boo_index
        rts 
