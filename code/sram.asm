includefrom "main.asm"
;##################################################################################################
;# SRAM enhancements

pushpc
    org $009CF5
        jml init_sram
    org $009C0F
        jml save_sram
    if !sa1 == 0
        org $00FFD8
            db $02
    endif
pullpc

init_sram:
        beq .load
        jmp .clear
    .load
        stz $0109|!addr
        phx 
        php
        sep #$10
        ldx.b #$5F
    -   
        lda !level_clears_sram,x
        sta !level_clears,x
        dex 
        bpl -
        ldx #$0B
    -   
        lda !blocksanity_sram,x
        sta !blocksanity_flags,x
        lda !moons_sram,x
        sta !moons_flags,x 
        lda !yoshi_coins_sram,x
        sta !yoshi_coins_flags,x
        lda !bonus_block_sram,x
        sta !bonus_block_flags,x
        lda !checkpoints_sram,x
        sta !checkpoints_flags,x
        dex 
        bpl -

        rep #$10
        ldx.w #!blocksanity_locs-1
    -   
        lda !blocksanity_data_sram,x
        sta !blocksanity_data_flags,x
        dex 
        bpl -
        sep #$10

        lda !goal_item_count_sram
        sta !goal_item_count

        lda !death_counter_sram+$00
        sta !death_counter+$00
        lda !death_counter_sram+$01
        sta !death_counter+$01
        lda !death_counter_sram+$02
        sta !death_counter+$02
        lda !coin_counter_sram+$00
        sta !coin_counter+$00
        lda !coin_counter_sram+$01
        sta !coin_counter+$01
        lda !coin_counter_sram+$02
        sta !coin_counter+$02

        plp 
        jml $009CFB

    .clear 
        phx 
        ldx.w #$005F
        lda #$00
    -   
        sta !level_clears_sram,x
        dex 
        bpl -

        ldx.w #$000B
    - 
        sta !blocksanity_sram,x
        sta !yoshi_coins_sram,x
        sta !bonus_block_sram,x
        sta !moons_sram,x
        sta !checkpoints_sram,x
        dex 
        bpl -

        ldx.w #!blocksanity_locs-1
    -   
        sta !blocksanity_data_sram,x
        dex 
        bpl -

        sta !goal_item_count_sram

        lda #$00
        sta !inventory_sram+$00
        sta !inventory_sram+$01
        sta !inventory_sram+$02
        sta !inventory_sram+$03
        sta !inventory_sram+$04
        sta !inventory_sram+$05
        sta !inventory_sram+$06
        sta !inventory_sram+$07

        sta !death_counter_sram+$00
        sta !death_counter_sram+$01
        sta !death_counter_sram+$02
        sta !coin_counter_sram+$00
        sta !coin_counter_sram+$01
        sta !coin_counter_sram+$02

        plx 
        jml $009D22

save_sram:
        sep #$30
        plb 

        ldx.b #$5F
    -   
        lda !level_clears,x
        sta !level_clears_sram,x 
        dex 
        bpl -

        ldx #$0B
    -   
        lda !blocksanity_flags,x
        sta !blocksanity_sram,x
        lda !yoshi_coins_flags,x
        sta !yoshi_coins_sram,x
        lda !moons_flags,x
        sta !moons_sram,x
        lda !bonus_block_flags,x
        sta !bonus_block_sram,x
        lda !checkpoints_flags,x
        sta !checkpoints_sram,x
        dex 
        bpl -

        rep #$10
        ldx.w #!blocksanity_locs-1
    -   
        lda !blocksanity_data_flags,x
        sta !blocksanity_data_sram,x
        dex 
        bpl -
        sep #$10

        lda !goal_item_count
        sta !goal_item_count_sram

        lda !death_counter+$00
        sta !death_counter_sram+$00
        lda !death_counter+$01
        sta !death_counter_sram+$01
        lda !death_counter+$02
        sta !death_counter_sram+$02
        lda !coin_counter+$00
        sta !coin_counter_sram+$00
        lda !coin_counter+$01
        sta !coin_counter_sram+$01
        lda !coin_counter+$02
        sta !coin_counter_sram+$02

        rtl 