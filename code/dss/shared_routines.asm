includeonce

find_and_queue_gfx:

.check_null
    cmp #!dss_id_null
    bne .init
..premature_return
    clc
    rtl

.init
    phy
    phx
    php
    phb
    pea $4040                       ; set data bank $40 for easy access purposes
    plb
    plb
    sep #$10

.search_gfx
    ldx #$00
..loop
    cmp.w !dss_list,x               ; search if the gfx is already loaded
    beq .found_gfx
    inx 
    cpx #$20
    bne ..loop
    bra .setup_gfx_queue
    
.found_gfx
    inc.w !dss_list_usage,x         ; increase gfx reference count
    lda.b #!dss_time_to_unmark_gfx
    sta.w !dss_list_timer,x

    lda.w !dss_list_gfx_loaded,x
    bne ..tiles_in_vram
    rep #$20
    txa
    asl
    tay
    lda.w !dss_list_queue_index,y
    sec 
    sbc.w #!dss_queue_tiles*8
    sec
    sbc.w !dss_gfx_queue_index_nmi
    sep #$20
    beq ..tiles_in_vram
    bmi ..tiles_in_vram
    jmp .abort_queue

..tiles_in_vram
    lda #$01
    sta.w !dss_list_gfx_loaded,x

    rep #$20
    txa                             ; get correct index for the array location in the other array
    asl #5
    adc.w #!dss_tile_buffer_complete
    sta $0D
    sep #$20

    lda.b #!dss_tile_buffer_complete/$10000
    sta $0F                         ; unused, but could be useful for someone else...?

    ldy.w !dss_gfx_size,x
    dey
    sty $0C

    lda.w !dss_list,x
    ldy #$00
    tyx
..loop
    cmp.w !dss_map,x
    bne ..next_tile
    pha 
    lda.w !dss_vram_dest,x
    sta.w !dss_tile_buffer,y
    sta ($0D),y
    iny
    pla
    dec $0C 
    bmi ..tiles_loaded
..next_tile
    inx 
    bpl ..loop

..tiles_loaded
    plb
    plp
    plx
    ply
    sec
    rtl

.setup_gfx_queue                    ; no gfx loaded, proceed to load it
    tax
    lda.l exgfx_lenght,x            ; check if the current gfx has a valid tile lenght
    beq .abort_queue
    lda.w !dss_maximum_tiles        ; check if there's enough space to upload graphics
    sec 
    sbc.w !dss_loaded_tiles
    cmp.l exgfx_lenght,x            ; if there aren't enough free tiles, abort filling up the queue
    bcs .get_unused_gfx_slot
.abort_queue
    plb
    plp
    plx
    ply
    clc
    rtl

.get_unused_gfx_slot
    ldy #$00
..loop
    lda.w !dss_list,y               ; search for the first unused gfx slot
    cmp #$FF                        ; $FF = free gfx slot
    beq .fill_data
    iny 
    cpy.b #32
    bcc ..loop
    bra .abort_queue                ; end the routine and don't fill up the queue if there aren't any free gfx slots

.fill_data
    txa
    sta.w !dss_list,y               ; save exgfx id into list

    lda.b #!dss_time_to_unmark_gfx
    sta.w !dss_list_timer,y

    lda.l exgfx_lenght,x            ; add up tile numbers
    sta.w !dss_gfx_size,y
    phy
    phx 
    clc 
    adc.w !dss_loaded_tiles
    sta.w !dss_loaded_tiles

    rep #$30
    txa 
    asl 
    tax 
    stz $05
    lda.l exgfx_offset,x
    ora.w #sprite_graphics>>8
    sta $06
    sep #$30

.find_free_tiles
    ply                             ; Y = ExGFX ID
    plx                             ; X = List index
    sty $01 
    stx $02

    lda !dss_gfx_size,x             ; loop Z times
    dec
    sta $03
    sta $08
    stz $09

    rep #$20
    txa                             ; get correct index for the array location in the other array
    asl #5
    adc.w #!dss_tile_buffer_complete
    sta $0D
    sep #$20

    lda.b #!dss_tile_buffer_complete/$10000
    sta $0F                         ; unused, but could be useful for someone else...?

    ldy #$00
    tyx
..loop
    lda.w !dss_map,x
    cmp #$FF                        ; check if tile is unused
    beq ..store_tile
    inx                             ; keep searching if it's used
    bra ..loop

..store_tile
    lda $01                         ; save exgfx id to the tile usage map
    sta.w !dss_map,x
    lda.w !dss_vram_dest,x          ; load proper tile number to an array
    sta.w !dss_tile_buffer,y
    sta ($0D),y                     ; also save it to the array of arrays
    iny                             ; increase pointer to the array of tiles
    inx
    dec $03                         ; loop until we're done copying tile numbers, shouldn't be over 32 times
    bpl ..loop

.queue_tiles
    rep #$20
    ldx.w !dss_gfx_queue_index_game ; get last unused index in queue buffer
    ldy #$00
..loop
    lda.w !dss_tile_buffer,y        ; calculate tile column in vram
    and #$00FF
    asl #4
    ora #$7000                      ; OR $7000 to get the actual tile vram address
    sta.w !dss_gfx_queue_vram,x
    lda $07
    sta.w !dss_gfx_queue_source_row_1+$02,x

    tya 
    and #$0007                      ; grab loop number and multiply it by 32
    xba 
    lsr #2
    sta $00
    tya 
    and #$00F8
    xba 
    lsr #1
    ora $00
    clc
    adc $05                         ; add frame index
    sta.w !dss_gfx_queue_source_row_1,x
    clc 
    adc #$0200
    sta.w !dss_gfx_queue_source_row_2,x

    txa
    clc
    adc #$0008
    sta.w !dss_gfx_queue_index_game
    tax
    iny                             ; increase queue index by 4 and tile index by 1
    dec $08                         ; decrease loop index by 1
    bpl ..loop

    lda $02
    and #$00FF
    asl                             ; save index to a ram
    tax
    lda.w !dss_gfx_queue_index_game
    sta.w !dss_list_queue_index,x

    sep #$20

    ldx $02
    stz.w !dss_list_gfx_loaded,x

.predictor
    rep #$20
    txa
    asl
    tay
    lda.w !dss_list_queue_index,y
    sec 
    sbc.w #!dss_queue_tiles*8
    sec
    sbc.w !dss_gfx_queue_index_nmi
    sep #$20
    beq ..tiles_uploaded_next_frame
    bmi ..tiles_uploaded_next_frame
    bra .queue_end

..tiles_uploaded_next_frame
    lda #$01
    sta.w !dss_list_gfx_loaded,x
    plb
    plp
    plx
    ply
    sec
    rtl

.queue_end
    plb
    plp
    plx
    ply
    clc
    rtl
