pushpc
    ;# Remap 04DD8D
    org $04E49E
        lda.l event_layer_2_data,x
    org $04E4A3
        lda.l event_layer_2_data+$02,x
    org $04E708
        lda.l event_layer_2_data,x
    org $04E70F
        lda.l event_layer_2_data+$02,x
    org $04EE3E
        lda.l event_layer_2_data+$02,x
    org $04EE59
        lda.l event_layer_2_data,x

    ;# Remap 04E359
    org $04E470
        lda.l  event_layer_2_offsets,x
    org $04E477
        lda.l  event_layer_2_offsets+$02,x
    org $04E6DD
        lda.l  event_layer_2_offsets,x
    org $04E6E4
        lda.l  event_layer_2_offsets+$02,x


pullpc

!_offset #= $0000

macro setup_event_offsets(size)
    dw !_offset, !_offset+<size>
    !_offset #= <size>
endmacro

event_layer_2_data:
    .event_00   ;# YI1 -> YSP
        dw $0900,$23CC
        dw $0904,$238C
        dw $0908,$234E
        dw $090C,$230E
        dw $0910,$22D0
        dw $0914,$2290
        dw $018C,$2202
        dw $01B0,$2202
        dw $01D4,$2202
        dw $0A44,$21C6
        dw $0A48,$2044
        dw $0A4C,$2186
        dw $0A48,$2004
        dw $0900,$23E4

event_layer_2_offsets:
    .event_00
        %setup_event_offsets($0000)