pushpc
    org $008385
        jml irq_main
        nop 
    org $00827C
        jsl nmi_main
        nop
pullpc

;#########################################################################
;# 

inventory_layer_1_offsets:
        db $FF,$1F

irq_main:
        lda $0100
        cmp #$0E
        bne .return

        ldy $0DD6
        ldx $1F1A,y
        lda.l inventory_layer_1_offsets,x
        sbc !inventory_y_pos
        ldx #$01

    -   bit $4212
        bvs -
    -   bit $4212
        bvc -

        stz $210D
        stz $210D
        sta $210E
        stx $2105
        stx $210E
        stz $212E
        stz $2131
        jml $0083B2

    .return
        lda #$81
        ldy $0D9B
        jml $00838A

;#########################################################################
;# 

inventory_end:
        db $00,$FC
		
inventory_y_speeds:
        db $04,$FC

nmi_main:
        ldy $0100
        cpy #$0E
        bne .return

        lda #$15
        sta $212E
        lda $40
        sta $2131

        lda !inventory_timer
        beq .done

        dec !inventory_timer
        ldx !inventory_direction
        lda !inventory_y_pos
        clc 
        adc.l inventory_y_speeds,x
        sta !inventory_y_pos
        cmp.l inventory_end,x
        bne .done

        jsr dma_vram

    .done

        lda #$81
        ldy !inventory_y_pos
        beq .return
        tya 
        sec 
        sbc #$20
        sta $4209
        stz $420A
        lda #$A1
    .return
        ldy $13C6
        cpy #$08
        rtl 

inventory_vram_addr:
        dw $2B80,$2000

inventory_vram_tilemap:
        dw !inventory_palette<<10|$2000|!inventory_gfx_loc
        dw !inventory_palette<<10|$6000|(!inventory_gfx_loc+1)
        dw !inventory_palette<<10|$6000|!inventory_gfx_loc
        dw !inventory_palette<<10|$2000|(!inventory_gfx_loc+2)
        dw !inventory_palette<<10|$2000|(!inventory_gfx_loc+3)
        dw !inventory_palette<<10|$6000|(!inventory_gfx_loc+2)
        dw !inventory_palette<<10|$2000|(!inventory_gfx_loc+2)
        dw !inventory_palette<<10|$2000|(!inventory_gfx_loc+3)
        dw !inventory_palette<<10|$6000|(!inventory_gfx_loc+2)
        dw !inventory_palette<<10|$A000|!inventory_gfx_loc
        dw !inventory_palette<<10|$E000|(!inventory_gfx_loc+1)
        dw !inventory_palette<<10|$E000|!inventory_gfx_loc

dma_vram:
        lda #$80
        sta $2115

        ldy $0DD6
        lda $1F1A,y
        asl 
        tax 
        rep #$20
        lda.l inventory_vram_addr,x
        ldx #$02
        sta $00
        sta $2116
        lda #$1801
        ldy !inventory_direction
        beq .write
        lda #$3981
    .write
        sta $4310
        lda.w #!vram_backup
        sta $4312
        stx $4316
        ldy.b #!vram_backup>>16
        sty $4314
        stx $420B

        ldy !inventory_direction
        beq .return

        lda.w #!inventory_gfx_loc<<4
        sta $2116
        lda #$1801
        sta $4310
        lda.w #inventory_gfx
        sta $4312
        ldy #$80
        sty $4315
        ldy.b #inventory_gfx>>16
        sty $4314
        stx $420B

        inx 

    .loop
        phx 
        txa 
        xba 
        lsr #3
        adc $00
        sta $2116

        txa 
        sta $02
        asl 
        adc $02
        asl 
        tax 
        lda.l inventory_vram_tilemap,x
        sta $2118
        lda.l inventory_vram_tilemap+$02,x
        ldy #$1D
    -   
        sta $2118
        dey 
        bpl -
        lda.l inventory_vram_tilemap+$04,x
        sta $2118
        plx 
        dex 
        bpl .loop

    .return
        sep #$20
        rts 
