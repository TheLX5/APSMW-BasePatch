includefrom "main.asm"
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
        lda !ability_byte_1
        bpl .not_unlocked
        txa 
        sta $13E4|!addr
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
        jml lock_carry_sprites
    
    org $01F309
        jsl lock_carry_yoshi
        rts 
pullpc

lock_carry_throw_block:
        lda !ability_byte_1
        and #$40
        beq .not_unlocked
        lda $148F|!addr
        ora $187A|!addr
        rtl 
    .not_unlocked
        lda #$01
        rtl 

lock_carry_springboard:
        lda !ability_byte_1
        and #$40
        beq .not_unlocked
        lda #$0B
        sta !14C8,x
        stz !1602,x
    .not_unlocked
        rtl 

lock_carry_sprites:
        lda !ability_byte_1
        and #$40
        beq +
        lda #$0B
        sta !14C8,x
        inc $1470|!addr
        lda #$08
        sta $1498|!addr
        jml $01AA73
    +   
        jml $01AA74

lock_carry_yoshi:
        lda !ability_byte_1
        and #$40
        beq .not_unlocked
        lda #$12
        sta $14A3|!addr
        lda #$21
        sta $1DFC|!addr
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
        lda !ability_byte_1
        and #$20
        beq .not_unlocked
        lda $8B
        sta $74
        jml $00DB17
    .not_unlocked
        jml $00CD76

lock_climb_rope:
        lda !ability_byte_1
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
        lda !ability_byte_1
        and #$10
        beq .not_unlocked
        ldy #$B0
    .not_unlocked
        tya 
        ply 
        sta $14AD|!addr,y
        rtl

;#########################################################################
;# Spin Jump

pushpc
    org $00D645
        jml unlocked_spin_jump
        print "    Spin Jump SFX Call: $", pc
        lda #$04
        sta $1DFC|!addr
        rtl 

    org $00EA89
        jml lock_spin_jump_water

    org $01E693
        jml lock_spin_jump_springboard
pullpc

unlocked_spin_jump:
        lda !ability_byte_1
        and #$08
        beq .not_unlocked
        jsl $00D649
        lda #$01
        sta $140D|!addr
        ldy $76
        lda $D5F0,y
        sta $13E2|!addr
        jml $00D656
    .not_unlocked
        jml $00D65E

lock_spin_jump_water:
        lda !ability_byte_1
        and #$08
        beq .not_unlocked
        lda #$01
        sta $140D|!addr
        jml $00EA8D
    .not_unlocked
        jml $00EA92

lock_spin_jump_springboard:
        lda !ability_byte_1
        and #$08
        beq .not_unlocked
        lda #$01
        sta $140D|!addr
    .not_unlocked
        jml $01E69E

;#########################################################################
;# Swim

pushpc
    org $00DA25
        jml lock_swim
    org $00D9D7
        jsl lock_swim_with_item
        nop #2
pullpc

lock_swim:
        pha 
        lda !ability_byte_1
        and #$04
        beq .not_unlocked
        pla 
        cmp.w $D984,x
        bcs +
        lda.w $D984,x
    +   
        jml $00DA2D
    .not_unlocked
        pla 
        cmp $DEBE,x
        bcs +
        lda $DEBE,x
    +   
        jml $00DA2D

lock_swim_with_item:
        pha 
        lda !ability_byte_1
        and #$04
        beq .not_unlocked
        pla 
        cmp #$F0
        bcs +
        lda #$F0
    +   
        rtl
    .not_unlocked
        pla 
        cmp #$FF
        bcs +
        lda #$00
    +   
        rtl 

;#########################################################################
;# Yoshi

pushpc
    org $0289FB
        jsl lock_yoshi
        nop #2
    org $01A2B8
        jsl lock_baby_yoshi_block
        nop 
    org $03C05F
        jsl lock_baby_yoshi_block
        nop 
pullpc

lock_yoshi:
        lda !ability_byte_1
        and #$02
        beq .not_unlocked
        lda $88A1,y
        bra + 
    .not_unlocked
        lda $88A2,y
    +   
        sta !151C,x
        rtl

lock_baby_yoshi_block:
        stz $141E|!addr
        lda !ability_byte_1
        and #$02
        beq .not_unlocked
        lda #$35
        rtl 
    .not_unlocked
        lda #$70
        rtl

;#########################################################################
;# Midway Gate

pushpc
    org $00F2E4
        jsl midway_gate_edit
pullpc

midway_gate_edit:
        lda !ability_byte_2
        and #$01
        beq .not_unlocked
        lda #$01
        sta $19
    .not_unlocked
        rtl


;#########################################################################
;# Mushroom

pushpc 
    org $00D156
        jsl lock_mushroom
        rts 
pullpc 

lock_mushroom:
        lda !ability_byte_2
        and #$01
        beq .not_unlocked
        inc $19
    .not_unlocked
        lda #$00
        sta $71
        stz $9D
        rtl 

;#########################################################################
;# Fire Flower

pushpc 
    org $00D187
        jsl flower_palette_cycle
        rts 
    org $01C5F7
        jsl lock_fire_flower
pullpc 

flower_palette_cycle:
        dec $149B|!addr
        bne +
        lda #$00
        sta $71
        stz $9D
    +
        rtl 

lock_fire_flower:
        lda !ability_byte_2
        and #$02
        beq .not_unlocked
        lda #$03
        sta $19
    .not_unlocked
        rtl 

;#########################################################################
;# Cape

pushpc 
    org $00D168
        jml cape_transform

    org $01C598
        jsl lock_cape
pullpc 

cape_transform: 
        lda $19
        lsr 
        bne +
        jml $00D140
    +   
        lda #$00
        sta $71
        stz $9D
        jml $00D18C

lock_cape:
        lda !ability_byte_2
        and #$04
        beq .not_unlocked
        lda #$02
        sta $19
    .not_unlocked
        rtl 

;#########################################################################
;# Taking Damage

pushpc 
    org $00D142
        jsl taking_damage
        rts 
pullpc 

taking_damage:
        sta $1497|!addr
        lda #$00
        sta $71
        stz $9D
        rtl 

;#########################################################################
;# Pipe Exit

pushpc 
    org $00D26D
        jsl pipe_exit
        rts 
pullpc 

pipe_exit:
        stz $1419|!addr
        lda #$00
        sta $71
        stz $9D 
        rtl 


;#########################################################################
;# P-Balloon

pushpc 
    org $01C2FF
        jsl lock_pballoon
        nop #6
pullpc 

lock_pballoon:
        lda !ability_byte_2
        and #$08
        beq .not_unlocked
        lda #$09
        sta $13F3|!addr
        lda #$FF
        sta $1891|!addr
        rtl 
    .not_unlocked
        lda #$01
        sta $13F3|!addr
        lda #$01
        sta $1891|!addr
        rtl 

;#########################################################################
;# Star

pushpc 
    org $01C580
        jsl lock_star
        nop 
    org $00E2E3
        jsl star_timer
pullpc 

lock_star:
        lda !ability_byte_2
        and #$10
        beq .not_unlocked
        lda #$FF
        sta $1490|!addr
        rtl 
    .not_unlocked
        lda #$01
        sta $1490|!addr
        rtl 

star_timer:
        lda !ability_byte_2
        and #$10
        beq .not_unlocked
        lda $13
        cpy #$1E
        rtl 
    .not_unlocked
        lda $13
        cpy #$01
        rtl 


inventory_y_speeds:
        db $04,$FC