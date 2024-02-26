;##################################################################################################
;# SRAM enhancements

pushpc
    org $009CF5
        jml init_sram
    org $009C0F
        jml save_sram
pullpc

init_sram:
        bne .clear
        stz $0109
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

        lda !received_items_count_sram+$00
        sta !received_items_count+$00
        lda !received_items_count_sram+$01
        sta !received_items_count+$01
        lda !special_world_clear_sram
        sta !special_world_clear_flag
        lda !goal_item_count_sram
        sta !goal_item_count

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

        sta !special_world_clear_sram
        sta !received_items_count_sram+$00
        sta !received_items_count_sram+$01
        sta !goal_item_count_sram

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

        lda !special_world_clear_flag
        sta !special_world_clear_sram

        lda !received_items_count+$00
        sta !received_items_count_sram+$00
        lda !received_items_count+$01
        sta !received_items_count_sram+$01
        lda !goal_item_count
        sta !goal_item_count_sram

        rtl 