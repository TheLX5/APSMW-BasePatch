@includefrom "main.asm"
;##################################################################################################
;# This file includes everything that's related to the player's abilities

;#########################################################################
;# Run

pushpc
    org $00D977
        jsl lock_run
        rts 
pullpc

lock_run:
        phx 
        bcc +
        iny 
        lda #$70
    +
        tax 
        lda $1F2C
        bpl .not_unlocked
        txa 
        sta $13E4
    .not_unlocked
        txa 
        plx 
        rtl 

;#########################################################################
;# Carry

pushpc
    org $00F26F
        jsl lock_carry_throw_block
        nop #2
    
    org $01E6DA
        jsl lock_carry_springboard
        bra +
    org $01E6E2
    +   

    org $01AA66
        lda $1F2C
        and #$40
        beq +
        jsl lock_carry_sprites
    +   
        rts 
        warnpc $01AA74
    
    org $01F309
        jsl lock_carry_yoshi
        rts 
pullpc

lock_carry_throw_block:
        lda $1F2C
        and #$40
        beq .not_unlocked
        lda $148F
        ora $187A
        rtl 
    .not_unlocked
        lda #$01
        rtl 

lock_carry_springboard:
        lda $1F2C
        and #$40
        beq .not_unlocked
        lda #$0B
        sta $14C8,x
        stz $1602,x
    .not_unlocked
        rtl 

lock_carry_sprites:
        lda #$0B
        sta $14C8,x
        inc $1470
        lda #$08
        sta $1498
        rtl

lock_carry_yoshi:
        lda $1F2C
        and #$40
        beq .not_unlocked
        lda #$12
        sta $14A3
        lda #$21
        sta $1DFC
    .not_unlocked
        rtl 

;#########################################################################
;# Climb

pushpc
    org $00CD72
        jml lock_climb
        nop #3
    org $01DA33
        jsl lock_climb_rope
pullpc

lock_climb:
        lda $1F2C
        and #$20
        beq .not_unlocked
        lda $8B
        sta $74
        jml $00DB17
    .not_unlocked
        jml $00CD76

lock_climb_rope:
        lda $1F2C
        and #$20
        beq .not_unlocked
        lda #$B0
        sta $7D
    .not_unlocked
        rtl

;#########################################################################
;# P-Switch

pushpc
    org $01AB1A
        jsl lock_pswitch
        nop
pullpc

lock_pswitch:
    phy 
    ldy #$01
    lda $1F2C
    and #$10
    beq .not_unlocked
    ldy #$B0
.not_unlocked
    ply 
    sta $14AD,y
    rtl

;#########################################################################
;# Spin Jump

pushpc
    org $00D645
        lda $1F2C
        and #$08
        beq +
        print "   Spin Jump SFX Call: ", pc
        lda #$04
        sta $1DFC
        jsl unlocked_spin_jump
        nop 
        warnpc $00D656
    org $00D656
        +

    org $00EA89
        jml lock_spin_jump_water
pullpc

unlocked_spin_jump:
    lda #$01
    sta $140D
    ldy $76
    lda $D5F0,y
    sta $13E2
    rtl 

lock_spin_jump_water:
    lda $1F2C
    and #$08
    beq .not_unlocked
    lda #$01
    sta $140D
    jml $00EA8D
.not_unlocked
    jml $00EA92

;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
;#########################################################################
;# 
