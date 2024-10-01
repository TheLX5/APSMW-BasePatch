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
    lda !D8,x
    and #$F0
    sta !sprite_blocksanity_y_lo,x
    lda !14D4,x
    sta !sprite_blocksanity_y_hi,x
    lda !14E0,x
    sta !sprite_blocksanity_x_hi,x
    lda !E4,x
    and #$F0
    sta !sprite_blocksanity_x_lo,x
    jsr blocksanity_keep_collected_flying_block
    lda !E4,x
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
    lda !E4,x
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
    ldy $0DC0|!addr
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
;# Makes blocks retain their collected status

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
    lda !E4,x
    lsr #4
    sta $00
    lda !D8,x
    and #$F0
    ora $00
    tay 
    lda !14D4,x
    asl #4
    sta $0A
    lda !14E0,x
    sta $1BA1|!addr
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
    db $00,$00,$00,$00,$00,$00,$00,$00  ; 10-17
    db $00,$00,$00,$00,$00,$00,$00,$00  ; 18-1F
    db $00,$00,$00,$01,$00,$00,$00,$00  ; 20-27
    db $02,$02,$02,$00,$00,$02,$02,$00  ; 28-2F
    db $02,$02,$02,$02,$00,$00,$02,$02  ; 30-37
    db $02,$02,$00,$00,$00,$00,$00,$00  ; 38-3F
    db $00,$00,$00,$00,$00,$00,$00,$00  ; 40-47
    db $00,$00,$00,$00,$00,$00,$00,$00  ; 48-4F

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
    lda $1BA1|!addr
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

;#########################################################################
;# Makes block indicate which kind of item they have inside

pushpc
    org $058B46
        jsl change_block_appareance
        nop 
    org $058A66
        jsl change_block_appareance
        nop 
    org $058C34
        jsl change_block_appareance
        nop 
    org $058D2B
        jsl change_block_appareance
        nop 

    org $0DFE9F
        new_look_question_block:
            .progressive
                dw $1489,$148B,$148A,$1482
            .useful
                dw $1889,$188B,$188A,$1882
            .filler
                dw $1C89,$1C8B,$1C8A,$1C82
        new_look_question_block_castle:
            .progressive
                dw $148E,$149E,$148F,$149F
            .useful
                dw $188E,$189E,$188F,$189F
            .filler
                dw $1C8E,$1C9E,$1C8F,$1C9F
        new_look_pswitch_question_block:
            .progressive
                dw $1499,$149B,$149A,$1492
            .useful
                dw $1899,$189B,$189A,$1892
            .filler
                dw $1C99,$1C9B,$1C9A,$1C92
        new_look_bonus_block:
            .progressive
                dw $14BE,$14F6,$14D7,$14F7
            .useful
                dw $18BE,$18F6,$18D7,$18F7
            .filler
                dw $1CBE,$1CF6,$1CD7,$1CF7
        new_look_goal_top_back:
            .progressive
                dw $14A0,$14A2,$14A1,$14A3
            .useful
                dw $18A0,$18A2,$18A1,$18A3
            .filler
                dw $1CA0,$1CA2,$1CA1,$1CA3
        new_look_goal_bottom_back:
            .progressive
                dw $14A2,$14A2,$14A3,$14A3
            .useful
                dw $18A2,$18A2,$18A3,$18A3
            .filler
                dw $1CA2,$1CA2,$1CA3,$1CA3
        new_look_goal_top_front:
            .progressive
                dw $34A0,$34A2,$34A1,$34A3
            .useful
                dw $38A0,$38A2,$38A1,$38A3
            .filler
                dw $3CA0,$3CA2,$3CA1,$3CA3
        new_look_goal_bottom_front:
            .progressive
                dw $34A2,$34A2,$34A3,$34A3
            .useful
                dw $38A2,$38A2,$38A3,$38A3
            .filler
                dw $3CA2,$3CA2,$3CA3,$3CA3
        
pullpc

change_block_appareance:
    phx 
    cpy #$0400
    bcs .invalid
    lda $0100|!addr
    and #$00FF
    cmp #$000B
    bcc .may_be_level
    cmp #$000F
    bcc .invalid
.may_be_level
    cmp #$0015
    bcs .invalid
    tyx 
    lda.l visual_remap_table,x
    tax 
    jmp (.ptrs,x)

.ptrs
    dw .invalid                 ; $0000
    dw .question_blocks         ; $0002
    dw .turn_blocks             ; $0004
    dw .note_blocks             ; $0006
    dw .switch_blocks           ; $0008
    dw .bonus_blocks            ; $000A
    dw .goal_back_1             ; $000C
    dw .goal_back_2             ; $000E
    dw .goal_back_3             ; $0010
    dw .goal_front_1            ; $0012
    dw .goal_front_2            ; $0014
    dw .goal_front_3            ; $0016
    dw .pswitch_block           ; $0018

.invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 

.note_blocks
.switch_blocks
.turn_blocks
.question_blocks
    lda.l block_visual_indicator
    and #$0010
    beq .invalid
    jsr .check_block
    bcc .invalid
..blocksanity
    tax 
    lda.l blocksanity_item_flags,x
    and #$00FF
    tax 
    lda !shuffled_ow_level
    and #$00FF
    cmp #$0025
    beq ...castle
    cmp #$000E
    beq ...castle
    lda.l new_look_question_block_ptr,x
    sta $0A
    plx 
    rtl 
...castle
    lda.l new_look_question_block_castle_ptr,x
    sta $0A
    plx 
    rtl 


.pswitch_block
    lda.l block_visual_indicator
    and #$0010
    beq .invalid
    jsr .check_block
    bcc .invalid
..blocksanity
    tax 
    lda.l blocksanity_item_flags,x
    and #$00FF
    tax 
    lda.l new_look_pswitch_question_block_ptr,x
    sta $0A
    plx 
    rtl 

.bonus_blocks
    lda.l block_visual_indicator
    and #$0008
    beq ..invalid
    ldx !current_ow_level
    lda.l bonus_block_item_flags,x
    and #$00FF
    tax 
    lda.l new_look_bonus_block_ptr,x
    sta $0A
    plx 
    rtl 
..invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 

.goal_back_1
    lda.l block_visual_indicator
    and #$0001
    beq ..invalid
    lda !shuffled_ow_level
    and #$00FF
    tax 
    lda !current_room
    cmp #$000F
    beq ..handle_same_level
    cmp #$0023
    beq ..handle_same_level
    cmp #$00EB
    beq ..force_secret_exit
    cmp #$01E7
    beq ..force_secret_exit
..normal
    lda.l normal_exit_item_flags,x
..secret
    and #$00FF
    tax 
    lda.l new_look_goal_top_back_ptr,x
    sta $0A
    plx 
    rtl 
..invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 
..handle_same_level
    phx 
    lda $55
    and #$00FF
    tax 
    lda $45,x
    plx 
    and #$00FF
    cmp #$0012
    beq ..normal
..force_secret_exit
    lda.l secret_exit_item_flags,x
    bra ..secret



.goal_back_2
.goal_back_3
    lda.l block_visual_indicator
    and #$0001
    beq ..invalid
    lda !shuffled_ow_level
    and #$00FF
    tax 
    lda !current_room
    cmp #$000F
    beq ..handle_same_level
    cmp #$0023
    beq ..handle_same_level
    cmp #$00EB
    beq ..force_secret_exit
    cmp #$01E7
    beq ..force_secret_exit
..normal
    lda.l normal_exit_item_flags,x
..secret
    and #$00FF
    tax 
    lda.l new_look_goal_bottom_back_ptr,x
    sta $0A
    plx 
    rtl 
..invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 
..handle_same_level
    phx 
    lda $55
    and #$00FF
    tax 
    lda $45,x
    plx 
    and #$00FF
    cmp #$0012
    beq ..normal
..force_secret_exit
    lda.l secret_exit_item_flags,x
    bra ..secret

.goal_front_1
    lda.l block_visual_indicator
    and #$0001
    beq ..invalid
    lda !shuffled_ow_level
    and #$00FF
    tax 
    lda !current_room
    cmp #$000F
    beq ..handle_same_level
    cmp #$0023
    beq ..handle_same_level
    cmp #$00EB
    beq ..force_secret_exit
    cmp #$01E7
    beq ..force_secret_exit
..normal
    lda.l normal_exit_item_flags,x
..secret
    and #$00FF
    tax 
    lda.l new_look_goal_top_front_ptr,x
    sta $0A
    plx 
    rtl 
..invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 
..handle_same_level
    phx 
    lda $55
    and #$00FF
    tax 
    lda $45,x
    plx 
    and #$00FF
    cmp #$0012
    beq ..normal
..force_secret_exit
    lda.l secret_exit_item_flags,x
    bra ..secret

.goal_front_2
.goal_front_3
    lda.l block_visual_indicator
    and #$0001
    beq ..invalid
    lda !shuffled_ow_level
    and #$00FF
    tax 
    lda !current_room
    cmp #$000F
    beq ..handle_same_level
    cmp #$0023
    beq ..handle_same_level
    cmp #$00EB
    beq ..force_secret_exit
    cmp #$01E7
    beq ..force_secret_exit
..normal
    lda.l normal_exit_item_flags,x
..secret
    and #$00FF
    tax 
    lda.l new_look_goal_bottom_front_ptr,x
    sta $0A
    plx 
    rtl 
..invalid
    lda $0FBE|!addr,y
    sta $0A
    plx 
    rtl 
..handle_same_level
    phx 
    lda $55
    and #$00FF
    tax 
    lda $45,x
    plx 
    and #$00FF
    cmp #$0012
    beq ..normal
..force_secret_exit
    lda.l secret_exit_item_flags,x
    bra ..secret

;###########################

.check_block
    phb 
    pea.w $1111
    plb 
    plb 
    phy 
    phx
    php
    lda $5B
    lsr 
    bcc ..horizontal_level
..vertical_level
    lda $55
    and #$00FF
    tax 
    lda $45,x
    asl #4
    pha 
    lda $08
    and #$000F
    asl #4
    pha
    lda $08
    and #$0100
    ora $01,s
    sta $01,s 
    bra ..shared
..horizontal_level
    lda $08
    and #$FFF0
    pha 
    lda $55
    and #$00FF
    tax 
    lda $45,x
    asl #4
    pha 
..shared
    rep #$20
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
    lda #$FFFF
    clc
    rts 

..valid_block
    iny #2
    lda ($01,s),y
    tax 
    lda !blocksanity_data_flags,x
    and #$00FF
    bne ..return
    txa 
    plx 
    plx  
    plx  
    plx  
    plp 
    plx 
    ply
    plb
    sec 
    rts 

new_look_question_block_ptr:
    dw new_look_question_block_filler
    dw new_look_question_block_progressive
    dw new_look_question_block_useful
    dw new_look_question_block_filler
    dw new_look_question_block_progressive
    dw new_look_question_block_progressive
    dw new_look_question_block_progressive
    dw new_look_question_block_progressive
new_look_question_block_castle_ptr:
    dw new_look_question_block_castle_filler
    dw new_look_question_block_castle_progressive
    dw new_look_question_block_castle_useful
    dw new_look_question_block_castle_filler
    dw new_look_question_block_castle_progressive
    dw new_look_question_block_castle_progressive
    dw new_look_question_block_castle_progressive
    dw new_look_question_block_castle_progressive

new_look_pswitch_question_block_ptr:
    dw new_look_pswitch_question_block_filler
    dw new_look_pswitch_question_block_progressive
    dw new_look_pswitch_question_block_useful
    dw new_look_pswitch_question_block_filler
    dw new_look_pswitch_question_block_progressive
    dw new_look_pswitch_question_block_progressive
    dw new_look_pswitch_question_block_progressive
    dw new_look_pswitch_question_block_progressive

new_look_bonus_block_ptr:
    dw new_look_bonus_block_filler
    dw new_look_bonus_block_progressive
    dw new_look_bonus_block_useful
    dw new_look_bonus_block_filler
    dw new_look_bonus_block_progressive
    dw new_look_bonus_block_progressive
    dw new_look_bonus_block_progressive
    dw new_look_bonus_block_progressive
new_look_goal_top_back_ptr:
    dw new_look_goal_top_back_filler
    dw new_look_goal_top_back_progressive
    dw new_look_goal_top_back_useful
    dw new_look_goal_top_back_filler
    dw new_look_goal_top_back_progressive
    dw new_look_goal_top_back_progressive
    dw new_look_goal_top_back_progressive
    dw new_look_goal_top_back_progressive
new_look_goal_bottom_back_ptr:
    dw new_look_goal_bottom_back_filler
    dw new_look_goal_bottom_back_progressive
    dw new_look_goal_bottom_back_useful
    dw new_look_goal_bottom_back_filler
    dw new_look_goal_bottom_back_progressive
    dw new_look_goal_bottom_back_progressive
    dw new_look_goal_bottom_back_progressive
    dw new_look_goal_bottom_back_progressive
new_look_goal_top_front_ptr:
    dw new_look_goal_top_front_filler
    dw new_look_goal_top_front_progressive
    dw new_look_goal_top_front_useful
    dw new_look_goal_top_front_filler
    dw new_look_goal_top_front_progressive
    dw new_look_goal_top_front_progressive
    dw new_look_goal_top_front_progressive
    dw new_look_goal_top_front_progressive
new_look_goal_bottom_front_ptr:
    dw new_look_goal_bottom_front_filler
    dw new_look_goal_bottom_front_progressive
    dw new_look_goal_bottom_front_useful
    dw new_look_goal_bottom_front_filler
    dw new_look_goal_bottom_front_progressive
    dw new_look_goal_bottom_front_progressive
    dw new_look_goal_bottom_front_progressive
    dw new_look_goal_bottom_front_progressive