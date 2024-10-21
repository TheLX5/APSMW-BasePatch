
pushpc
    org $009322
        jml CallGamemode
        rts
pullpc


CallGamemode:
    lda $0100|!addr
    asl                        ; $00-$29, an "old" mode, so jump to that
    tax
    phx 
    jsr (.ptrs,x)
    plx 
    lda $9329,x : sta $00      ; game mode routine ptr, low byte
    lda $932A,x : sta $01      ; game mode routine ptr, high byte
    stz $02
    phk
    pea .End-1
    pea $84CF-1              ; rtl
    jml [!dp]                ; game mode routines end in rts, so we need this

.End:
    jsr copy_to_ram_block
    jml $009326|!bank 


.ptrs
    dw .return      ; 00 Load Nintendo Presents
    dw .return      ; 01 Nintendo Presents
    dw .return      ; 02 Fade to Title Screen
    dw .return      ; 03 Load Title Screen
    dw .return      ; 04 Prepare Title Screen
    dw .return      ; 05 Title Screen: Fade in
    dw .return      ; 06 Title Screen: Circle effect
    dw .return      ; 07 Title Screen
    dw .return      ; 08 Title Screen: File select
    dw .return      ; 09 Title Screen: File delete
    dw .return      ; 0A Title Screen: Player select
    dw .return      ; 0B Fade to Overworld
    dw .return      ; 0C Load Overworld
    dw .return      ; 0D Overworld: Fade in
    dw gamemode_overworld_main      ; 0E Overworld
    dw .return      ; 0F Fade to Level
    dw .return      ; 10 Fade to Level (black)
    dw .return      ; 11 Load Level (Mario Start!)
    dw gamemode_level_prepare      ; 12 Prepare Level
    dw .return      ; 13 Level: Fade in
    dw .return      ; 14 Level
    dw .return      ; 15 Fade to Game Over / Time Up
    dw .return      ; 16 Load Game Over / Time Up
    dw .return      ; 17 Game Over / Time Up
    dw .return      ; 18 Load Credits/Cutscene?
    dw .return      ; 19 Load Credits/Cutscene?
    dw .return      ; 1A Load Credits/Cutscene?
    dw .return      ; 1B Ending: Credits / Cutscene
    dw .return      ; 1C Ending: Fade to Yoshi's House
    dw .return      ; 1D Ending: Load Yoshi's House
    dw .return      ; 1E Ending: Yoshi's House: Fade in
    dw .return      ; 1F Ending: Yoshi's House
    dw .return      ; 20 Fade to Enemies
    dw .return      ; 21 Fade to Enemies (black)
    dw .return      ; 22 Fade to Enemies?
    dw .return      ; 23 Fade to Enemies (black)?
    dw .return      ; 24 Ending: Enemies: Fade in
    dw .return      ; 25 Ending: Enemies
    dw .return      ; 26 Fade to The End / Go to 22
    dw .return      ; 27 Ending: Load The End
    dw .return      ; 28 Ending: The End: Fade in
    dw .return      ; 29 Ending: The End

.return
    rts 


gamemode_overworld_main:
    lda.l reset_traps_setting
    cmp #$02
    bcs .skip
    jsr force_trap_reset
.skip
    jsr save_prompt
    jsr check_trap_reset
    rts 

gamemode_level_prepare:
    lda.l reset_traps_setting
    bne .skip
    jsr force_trap_reset
.skip
    jsr check_trap_reset
    rts 


check_trap_reset:
    lda #$00
    sta !thwimp_trap
    sta !reset_thwimp_trap
    lda #$FF
    sta !thwimp_index
    sta !fishin_boo_index

    lda !reset_reverse_controls_trap
    beq +
    lda #$00
    sta !reverse_controls_trap
    sta !reset_reverse_controls_trap
+   

    lda !fishin_boo_trap
    and #$7F
    sta !fishin_boo_trap
    lda !reset_fishin_boo_trap
    beq +
    lda #$00
    sta !fishin_boo_trap
    sta !reset_fishin_boo_trap
    lda #$FF
    sta !fishin_boo_index
+   

    lda !reset_ice_trap
    beq +
    lda #$00
    sta !ice_trap
    sta !reset_ice_trap
+   
    rts

force_trap_reset:
    lda #$01
    sta !reset_reverse_controls_trap
    sta !reset_fishin_boo_trap
    rts 


;#########################################################################

!ram_block = $418000

copy_to_ram_block:
    lda $0100|!addr
    sta !ram_block+$000
    lda $71
    sta !ram_block+$001
    lda $0D9B|!addr
    sta !ram_block+$002
    lda $13FC|!addr
    sta !ram_block+$003
    lda $13BF|!addr
    sta !ram_block+$004
    lda $010B|!addr
    sta !ram_block+$005
    lda $010C|!addr
    sta !ram_block+$006
    lda $1426|!addr
    sta !ram_block+$007
    lda $0F48|!addr
    sta !ram_block+$008
    lda $13D4|!addr
    sta !ram_block+$009
    rts 


save_prompt:
    lda $13D9|!addr
    cmp #$04
    beq .reset
    lda $14C1|!addr
    cmp #$01
    beq .return 
    lda $13D9|!addr
    cmp #$03
    beq .save
.return
    rts 

.reset
    stz $14C1|!addr
    rts  

.save
    jsr .buffer
    jsl $009BC9
    lda #$01
    sta $14C1|!addr
    rts 


.buffer
    ldx #$2C
-   lda $1F02|!addr,x
    sta $1FA9|!addr,x
    dex 
    bpl -
    ldx #$5F
-   
    lda $1EA2|!addr,x
    sta $1F49|!addr,x
    dex 
    bpl -
    rts 