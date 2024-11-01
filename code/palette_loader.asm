includefrom "main.asm"
;##################################################################################################
;# This file handles everything related to loading palettes, especifically "curated" palettes.

;#########################################################################
;# Level palettes handler

!_index = $04
!_x_span = $06
!_y_span = $08
!_ptr = $0A
!_num = $0E
!_tileset = $00

pushpc
    org $00ABED
        jml level_palettes
    org $00A310
        force_level_original_palette:
            jml level_palettes_original
    org $0093D7
        jsr force_level_original_palette
    org $0094DA
        jsr force_level_original_palette
    org $0095EC
        jsr force_level_original_palette
    org $00965B
        jsr force_level_original_palette
    org $00ADD9
        jsr force_level_original_palette
    org $00AE1F
        jsr force_level_original_palette

    ;# Edit color propierties for the filler bush tile
    ;# Handled by the apworld
    ;#org $0D8248
    ;#    db $FE,$04
    ;#    db $FE,$04
    ;#    db $FE,$04
    ;#    db $FE,$04

    ;# Fix title screen changing background colors
    org $009D30
        nop #3

    ;# Skips level intros automatically
    org $00C896
        db $80
pullpc

level_palettes:
        lda.l level_palette_setting
        cmp #$02
        beq .custom
    .original
        lda.b #level_cave_original_chocolate_global>>16
        sta !_ptr+$02
        rep #$30
        lda.w #level_cave_original_chocolate_global
        sta !_ptr
        lda.w #$0041*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda.w #$0051*$02
        sta !_index
        lda #$000E
        sta !_x_span
        lda #$0002
        sta !_y_span
        jsr load_colors

        lda #$7FDD
        jml $00ABF2
    .custom
        rep #$30
    .load_default_layer_3
        lda #$B170
        sta !_ptr
        stz !_ptr+$02
        lda.w #$0010
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0001
        sta !_y_span
        jsr load_colors
    .prepare_index
        ldx !current_room
        lda.l level_palette_tilesets,x
        and #$00FF
        xba 
        sta !_tileset
        lda.l level_palette_index,x
        and #$00FF
        ora !_tileset
        sta !_ptr
        asl 
        clc 
        adc !_ptr
        sta !_num
        tax 
    .load_back_color
        lda.l level_palette_pointers,x
        sta !_ptr
        lda.l level_palette_pointers+$02,x
        sta !_ptr+$02
        lda [!_ptr]
        sta $0701|!addr
        inc !_ptr
        inc !_ptr
    .load_background
        lda.w #$0001*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0001
        sta !_y_span
        jsr load_colors
    .load_foreground
        lda.w #$0021*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0001
        sta !_y_span
        jsr load_colors
    .load_berries
        lda.w #$0029*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0002
        sta !_y_span
        lda !_ptr
        pha 
        jsr load_colors
        pla 
        sta !_ptr
        lda.w #$0099*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0002
        sta !_y_span
        jsr load_colors
    .load_global
        lda.w #$0041*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda.w #$0051*$02
        sta !_index
        lda #$000E
        sta !_x_span
        lda #$0002
        sta !_y_span
        jsr load_colors
    .load_sprite
        lda.w #$0081*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0007
        sta !_y_span
        jsr load_colors
    .load_sprite_specific
        lda !_tileset
        cmp #$0500
        bne .end 
        lda $192E|!addr
        and #$000F
        cmp #$0002
        bne .end
        lda.w #$00E1*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0001
        sta !_y_span
        jsr load_colors
    .end
        sep #$30
        jml $00ACEC
        
load_colors:
    .y_loop
        ldx !_index
        ldy !_x_span
    .x_loop
        lda [!_ptr]
        sta $0703|!addr,x
        inc !_ptr
        inc !_ptr
        inx #2
        dey 
        bpl .x_loop
        lda !_index
        clc 
        adc #$0020
        sta !_index
        dec !_y_span
        bpl .y_loop
        rts 
    
level_palette_tilesets:
       ;x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF
    db $FF,$03,$09,$01,$15,$0A,$04,$12,$19,$06,$07,$12,$09,$0F,$13,$09      ; Levels 000-00F
    db $03,$07,$FF,$15,$19,$04,$04,$FF,$17,$FF,$14,$12,$02,$05,$FF,$11      ; Levels 010-01F
    db $12,$15,$04,$02,$02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 020-02F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 030-03F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 040-04F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 050-05F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 060-06F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 070-07F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 080-08F
    db $FF,$FF,$FF,$12,$12,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 090-09F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 0A0-0AF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$19,$08,$09      ; Levels 0B0-0BF
    db $02,$08,$05,$04,$16,$1A,$04,$02,$0C,$19,$19,$09,$FF,$02,$02,$02      ; Levels 0C0-0CF
    db $04,$04,$05,$12,$14,$FF,$12,$10,$05,$FF,$19,$12,$14,$0F,$15,$FF      ; Levels 0D0-0DF
    db $12,$12,$FF,$04,$15,$FF,$19,$14,$12,$05,$05,$16,$15,$15,$15,$12      ; Levels 0E0-0EF
    db $16,$15,$15,$09,$19,$04,$04,$13,$18,$15,$15,$16,$15,$19,$15,$04      ; Levels 0F0-0FF
       ;x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF
    db $FF,$11,$08,$02,$1A,$00,$01,$15,$FF,$05,$05,$05,$FF,$11,$12,$05      ; Levels 100-10F
    db $12,$14,$FF,$0D,$15,$06,$05,$05,$05,$0C,$05,$19,$12,$15,$0E,$01      ; Levels 110-11F
    db $07,$19,$0E,$0E,$FF,$04,$0E,$02,$02,$FF,$09,$04,$0B,$02,$FF,$FF      ; Levels 120-12F
    db $07,$FF,$0C,$FF,$05,$0C,$0C,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 130-13F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 140-14F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 150-15F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 160-16F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 170-17F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 180-18F
    db $FF,$FF,$FF,$12,$12,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 190-19F
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF      ; Levels 1A0-1AF
    db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$19,$19,$12,$02,$05      ; Levels 1B0-1BF
    db $02,$07,$05,$05,$03,$03,$00,$FF,$0F,$10,$05,$05,$12,$11,$14,$14      ; Levels 1C0-1CF
    db $11,$12,$12,$12,$11,$03,$03,$19,$19,$15,$16,$15,$15,$15,$FF,$05      ; Levels 1D0-1DF
    db $10,$02,$06,$06,$19,$05,$16,$16,$15,$15,$15,$FF,$06,$05,$05,$06      ; Levels 1E0-1EF
    db $05,$05,$12,$14,$12,$05,$FF,$19,$05,$16,$15,$15,$11,$05,$12,$09      ; Levels 1F0-1FF
       ;x0  x1  x2  x3  x4  x5  x6  x7  x8  x9  xA  xB  xC  xD  xE  xF

;#########################################################################
;# Map palette handler

pushpc
    org $00AD25
        jml map_palettes
pullpc

map_palettes:
    .inventory_palettes
        rep #$30
        lda.w #inventory_colors
        sta !_ptr+$00
        lda.w #inventory_colors>>8
        sta !_ptr+$01
        lda.w #$00C8*$02
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda.w #$00D8*$02
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda.w #$00E8*$02
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda.w #$00F8*$02
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0000
        sta !_y_span
        jsr load_colors
        lda #$7FFF
        sta ($0703+($48*$02))|!addr

        lda.l map_palette_setting
        and #$00FF
        cmp #$0002
        beq .custom
    .original
        ldy #$B3D8
        jml $00AD2A
    .custom
    .prepare_index
        lda $1931|!addr
        and #$000F
        dec 
        tax 
        xba 
        sta !_num
        lda.l map_palette_index,x
        and #$00FF
        ora !_num
        sta !_ptr
        asl 
        clc 
        adc !_ptr
        tax 
        lda.l map_palette_pointers,x
        sta !_ptr
        lda.l map_palette_pointers+$02,x
        sta !_ptr+$02
    .load_back_color
        lda [!_ptr]
        sta $0701|!addr
        inc !_ptr
        inc !_ptr
    .load_layer_2
        lda.w #$0041*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0003
        sta !_y_span
        jsr load_colors
    .load_layer_1
        lda.w #$0029*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0005
        sta !_y_span
        jsr load_colors
    .load_layer_3
        lda.w #$0008*$02
        sta !_index
        lda #$0007
        sta !_x_span
        lda #$0001
        sta !_y_span
        jsr load_colors
    .load_sprites
        lda.w #$0081*$02
        sta !_index
        lda #$0006
        sta !_x_span
        lda #$0007
        sta !_y_span
        jsr load_colors
    .return
        jml $00ADA3

inventory_colors:
    .row_C
        dw $0000,$7FFF,$0011,$0017,$001F,$0000,$7AAB,$5981
    .row_D
        dw $0000,$7FFF,$6D08,$6DAD,$7E31,$5AD6,$6B5A,$5981
    .row_E
        dw $0000,$7FFF,$01FF,$031F,$03FF,$00B7,$023F,$5981
    .row_F
        dw $0000,$7FFF,$01E0,$02E0,$0380,$00B7,$023F,$5981


;#########################################################################
;# Edit palette upload when loading a map

pushpc
    org $00A488
        jml palette_upload_edit
pullpc

palette_upload_edit:
        lda $0100|!addr
        cmp #$0E
        beq .map
    .regular
        ldy $0680|!addr
        ldx.w $A47F+2,y
        jml $00A48E
    .map
        lda $13D9|!addr
        cmp #$0A
        bne .regular
        lda $1DE8|!addr
        cmp #$06
        bne .regular
        stz $0703|!addr
        stz $0704|!addr
        stz $2121
        ldx #$06
    .loop
        lda.w $9249,x
        sta $4320,x
        dex 
        bpl .loop
        lda #$04
        sta $420B
        jml $00A4CF

;#########################################################################
;# Include palettes

macro init_level_group(name)
    !_path = "../data/palettes/level/<name>"
    pushpc
    
    if !print_palette_info == 1
        print "------------------------------------------------"
        print "Palette group $",hex(!j, 2)," (<name>)"
    endif

    !j #= !j+1
    namespace level_<name>
        !i #= 0
        while !i != 256
            org !custom_level_palettes_ptrs+((!j-1)*256*3)+(!i*3)
                dl $FFFFFF
            !i #= !i+1
        endwhile
    !i #= 0
    pullpc
endmacro

macro init_map_group(name)
    !_path = "../data/palettes/map/<name>"
    pushpc

    if !print_palette_info == 1
        print "------------------------------------------------"
        print "Palette group $",hex(!j, 2)," (<name>)"
    endif

    !j #= !j+1
    namespace map_<name>
        !i #= 0
        while !i != 256
            org !custom_map_palettes_ptrs+((!j-1)*256*3)+(!i*3)
                dl $FFFFFF
            !i #= !i+1
        endwhile
    !i #= 0
    pullpc
endmacro

macro load_level_palette_file(filename)
    if !print_palette_info == 1
        print "  $", hex(!i, 2), " <filename>: "
    endif

    if !_bank_palette_count == 95
        ;# Move palettes into next bank in order to cross banks
        !custom_level_palettes #= !custom_level_palettes+$10000
        !_bank_palette_count #= 0
        org !custom_level_palettes
    endif

    if !print_palette_info == 1
        print "    Data location: $", pc
    endif

    pushpc
        org !custom_level_palettes_ptrs+((!j-1)*256*3)+(!i*3)
            dl <filename>
            if !print_palette_info == 1
                print "     Ptr location: $", pc
            endif
        !i #= !i+1
    pullpc
    

    <filename>:
        .back_color
            incbin "!{_path}/<filename>.mw3":$100*$02..$101*$02
        .background
            incbin "!{_path}/<filename>.mw3":$01*$02..$08*$02
            incbin "!{_path}/<filename>.mw3":$11*$02..$18*$02
        .foreground
            incbin "!{_path}/<filename>.mw3":$21*$02..$28*$02
            incbin "!{_path}/<filename>.mw3":$31*$02..$38*$02
        .berries
            incbin "!{_path}/<filename>.mw3":$29*$02..$30*$02
            incbin "!{_path}/<filename>.mw3":$39*$02..$40*$02
            incbin "!{_path}/<filename>.mw3":$49*$02..$50*$02
        .global
            incbin "!{_path}/<filename>.mw3":$41*$02..$48*$02
            incbin "!{_path}/<filename>.mw3":$51*$02..$60*$02
            incbin "!{_path}/<filename>.mw3":$61*$02..$70*$02
            incbin "!{_path}/<filename>.mw3":$71*$02..$80*$02
        .sprites
            incbin "!{_path}/<filename>.mw3":$81*$02..$88*$02
            incbin "!{_path}/<filename>.mw3":$91*$02..$98*$02
            incbin "!{_path}/<filename>.mw3":$A1*$02..$A8*$02
            incbin "!{_path}/<filename>.mw3":$B1*$02..$B8*$02
            incbin "!{_path}/<filename>.mw3":$C1*$02..$C8*$02
            incbin "!{_path}/<filename>.mw3":$D1*$02..$D8*$02
            incbin "!{_path}/<filename>.mw3":$E1*$02..$E8*$02
            incbin "!{_path}/<filename>.mw3":$F1*$02..$F8*$02
            incbin "!{_path}/<filename>.mw3":$E9*$02..$F0*$02
            incbin "!{_path}/<filename>.mw3":$F9*$02..$100*$02

    !_bank_palette_count #= !_bank_palette_count+$01
endmacro

macro load_map_palette_file(filename)
    if !print_palette_info == 1
        print "  $", hex(!i, 2), " <filename>: "
    endif

    if !_bank_palette_count == 113
        ;# Move palettes into next bank in order to cross banks
        !custom_map_palettes #= !custom_map_palettes+$10000
        !_bank_palette_count #= 0
        org !custom_map_palettes
    endif
    
    if !print_palette_info == 1
        print "    Data location: $", pc
    endif

    pushpc
        org !custom_map_palettes_ptrs+((!j-1)*256*3)+(!i*3)
            dl <filename>
            if !print_palette_info == 1
                print "     Ptr location: $", pc
            endif
        !i #= !i+1
    pullpc

    <filename>:
        .back_color
            incbin "!{_path}/<filename>.mw3":$100*$02..$101*$02
        .layer_2
            incbin "!{_path}/<filename>.mw3":$41*$02..$48*$02
            incbin "!{_path}/<filename>.mw3":$51*$02..$58*$02
            incbin "!{_path}/<filename>.mw3":$61*$02..$68*$02
            incbin "!{_path}/<filename>.mw3":$71*$02..$78*$02
        .layer_1
            incbin "!{_path}/<filename>.mw3":$29*$02..$30*$02
            incbin "!{_path}/<filename>.mw3":$39*$02..$40*$02
            incbin "!{_path}/<filename>.mw3":$49*$02..$50*$02
            incbin "!{_path}/<filename>.mw3":$59*$02..$60*$02
            incbin "!{_path}/<filename>.mw3":$69*$02..$70*$02
            incbin "!{_path}/<filename>.mw3":$79*$02..$80*$02
        .layer_3
            incbin "!{_path}/<filename>.mw3":$08*$02..$10*$02
            incbin "!{_path}/<filename>.mw3":$18*$02..$20*$02
        .sprite
            incbin "!{_path}/<filename>.mw3":$81*$02..$88*$02
            incbin "!{_path}/<filename>.mw3":$91*$02..$98*$02
            incbin "!{_path}/<filename>.mw3":$A1*$02..$A8*$02
            incbin "!{_path}/<filename>.mw3":$B1*$02..$B8*$02
            incbin "!{_path}/<filename>.mw3":$C1*$02..$C8*$02
            incbin "!{_path}/<filename>.mw3":$D1*$02..$D8*$02
            incbin "!{_path}/<filename>.mw3":$E1*$02..$E8*$02
            incbin "!{_path}/<filename>.mw3":$F1*$02..$F8*$02

    !_bank_palette_count #= !_bank_palette_count+$01
endmacro

incsrc "../data/palette_data.asm"

namespace off 
