
pushpc
    org $0485A7
        jsl ow_inventory_main
        nop 
    org $04FB0A
            STA $0242|!addr,y
            XBA
            AND #$EF			; Disable priority bit 1 on OW sprites.
            STA $0243|!addr,y
            LDA $01
            ORA $03
            BNE +
            LDA $00
            STA $0240|!addr,y
            LDA $02
            STA $0241|!addr,y
            PHP
            TYA
            LSR
            LSR
            PLP
            PHY
            TAY
            ROL
            ASL
            AND #$03
            STA $0430|!addr,y
            PLY
            DEY
            DEY
            DEY
            DEY
        +   RTS

    org $0485F3
        -	LDA $00
            CLC
            ADC inventory_x_offsets,y
            STA $0200|!addr,x
            LDA $01
            ADC inventory_y_offsets,y
            STA $0201|!addr,x
            LDA #$E8
            STA $0202|!addr,x
            LDA #$36
            STA $0203|!addr,x
            LDA #$02
            STA $0420|!addr,y
            INY
            INX
            INX
            INX
            INX
            CPY #$04
            BNE -
            RTS
            
    inventory_x_offsets:	db $00,$00,$10,$10
            
    inventory_y_offsets:	db $00,$10,$00,$10
org $00A660
		JSL star_power
		NOP
		NOP
pullpc


!num_items = $08
!inventory_gfx_loc    = $0100			; The beginning of where the inventory graphics are written to (in the 8x8 editor).
!inventory_palette    = $04			; The inventory palette.

;#########################################################################
;# Add item routine

add_item:
        phx 
        tax 
        lda.l !inventory_sram,x
        cmp.l max_items,x
        beq .maxed_out
        inc 
        sta.l !inventory_sram,x
    .maxed_out
        plx 
        rtl 

;#########################################################################
;# Inventory handling

star_power:
        LDA !star_power
		BEQ +
		
		JSL $01C580
		LDA #$00
		STA !star_power
		
	+	LDA $13F4|!addr
		ORA $13F5|!addr
		RTL


ow_inventory_main:
	if !sa1 == 1
		wdm
		rep #$30
		tsx 
		cpx #$3000
		sep #$30
		bcc .snes
		%invoke_snes(.snes)
		REP #$20
		LDA #$001E
		rtl 
	endif
	.snes 
        LDA !star_power
		BEQ +
		STA $1490|!addr
		
	+	LDA $13D9|!addr
		CMP #$03
		BNE .return			; If we're on a level tile,
		LDA $13D4|!addr
		BNE .return			; and we're not looking around,
		
		LDA !inventory_timer
		BNE +
		LDA $16
		AND #$20
		BEQ +				; open/close the inventory if select is pressed.
		
		LDA #$1C
		STA $1DFC|!addr
		LDA !inventory_direction
		EOR #$01
		STA !inventory_direction			; Switch the inventory direction,
		LDA #$08
		STA !inventory_timer			; and set the timer.
		
	+	LDA !inventory_y_pos
		BEQ .return

		LDA !inventory_cursor
		STA $4204
		STZ $4205
		LDA #$0A
		STA $4206			; Divide the cursor position by 10.
		
		PHB
		PHK
		PLB
		JSR update_inv			; Update the inventory.
		
		LDA !inventory_y_pos
		LDX !inventory_timer
		BEQ +
		LDX !inventory_direction
		CLC
		ADC inventory_y_speeds,x
	+	STA $0C				; Offset the inventory graphics to counteract a one-frame delay.
		JSR draw_inv			; Draw the inventory.
		
		STZ $16
		STZ $17
		STZ $18				; Disable controls.
		PLB
		
	.return
		lda $0DC2|!addr
		beq +
		jsr draw_item_box
	+
		lda.l energy_link
		beq +
		jsr draw_energy_link_coins
	+

		REP #$20
		LDA #$001E
		RTL
		
draw_inv:
if !num_items > 10
		LDA $14
		ASL
		ASL
		ASL
		ROL
		LDA #$00
		PHP
		ADC $0C
		SBC #$0F
		PLP
		STA $0215|!addr
		
		LDA #$00
		SBC $0C
		EOR #$FF
		SBC #$17
		STA $0211|!addr			; Set the arrows' Y positions.
		
		LDA #$F4
		STA $0210|!addr
		STA $0214|!addr			; Set the arrows' X positions.
		
		LDY $0E
		BNE +
		LDA #$FF
	+	STA $0212|!addr
	
		LDA #$F5
		LDX $00
		CPY.b #!num_items-0.5/10
		BNE +
		LDA #$FF
	+	STA $0216|!addr			; Set the arrows' tiles.
		
		LDA #$34
		STA $0213|!addr
		STA $0217|!addr			; Set the arrows' properties.
		
		STZ $0424|!addr			; Set the arrows' size.
		STZ $0425|!addr			
endif
		LDX #$00
		TXY
	-	STX $4202
		LDA #$18
		STA $4203
		
		STX $00
		LDA $0E
		ASL
		ASL
		ADC $0E
		ASL
		ADC $00
		STA $00				; Compute the powerup index.
		CPX $0F
		BNE .no_digits			; If the current item is selected,
		
		PHY
		TYA
		LSR
		LSR
		TAY
		LDA #$00
		STA $0426|!addr,y
		STA $0427|!addr,y			; Mark the digits as 8x8 tiles.
		PLY
		LDX $00
		LDA !inventory_sram,x
		
		PHX
		JSL $00974C
		PHA
		LDA #$FB			; Hide the tens digit if it is 0.
		CPX #$00
		BEQ +
		LDA digits,x
	+	STA $021A|!addr,y			; Set the tens digit's tile.
		PLA
		TAX
		LDA digits,x
		STA $021E|!addr,y			; Set the ones digit's tile.
		PLX
		
		LDA #$3E
		STA $021B|!addr,y
		STA $021F|!addr,y			; Set the digits' properties
		
		LDA $4216
		ADC #$12
		STA $0218|!addr,y
		ADC #$06
		STA $021C|!addr,y			; Set the digits' x positions.
		
		LDA $0C
		SBC #$0B
		STA $0219|!addr,y
		STA $021D|!addr,y			; Set the digits' y positions.
		
		TYA
		CLC
		ADC #$08
		TAY
		
	.no_digits
		LDA $0C
		SEC
		SBC #$18
		STA $0219|!addr,y			; Set the item's Y position.
		LDA $4216
		ADC #$0B
		STA $0218|!addr,y			; Set the item's X position.
		
		PHX
		LDX $00
		LDA item_props,x
		STA $021B|!addr,y			; Set the item's properties.
		LDA item_tiles,x
		PLX
		CPX $0F
		BEQ +				; If the item is not selected, use the next tile.
		INC
		INC
	+	STA $021A|!addr,y			; Set the item's tiles.
		
		PHY
		TYA
		LSR
		LSR
		TAY
		LDA #$02
		STA $0426|!addr,y			; Mark the item as a 16x16 tile.
		PLY
		
		cpx $0F
		bne .skip
		lda !inventory_disabled_item
		beq .skip
		jsr inventory_disable_items
	.skip

		LDA $0E
        CMP.b #(!num_items-0.5)/10
		BNE +
		CPX #!num_items%10-1
		BRA ++
	+	CPX #$09
	++	BEQ .return
		INX
		INY
		INY
		INY
		INY
		JMP -				; Go to the next item.
	.return	RTS
	
update_inv:	LDA $4214
        STA $0E				; Set the cursor's page number.
        LDA $4216
        STA $0F				; Set the cursor's index.
        
        LSR $16
        BCC .no_r			; If right is pressed,
        LDA !inventory_cursor
        CMP #!num_items-1
        BEQ .no_r			; and the cursor isn't at the rightmost item,
        INC $0F				; move the cursor right.
        BRA +
        
    .no_r
        LSR $16
        BCC .no_l			; If left is pressed,
        LDA !inventory_cursor
        BEQ .no_l			; and the cursor isn't at the leftmost item,
        DEC $0F				; move the cursor left.
        BRA +

    .no_l
        LSR $16
        BCC .no_d			; If down is pressed,
        LDA $0E
        CMP.b #(!num_items-0.5)/10
        BEQ .no_d			; and the cursor isn't at the bottommost page,
        INC $0E				; move the page down.
        BRA +
        
    .no_d
        LSR $16
        BCC .no_u			; If up is pressed,
        LDA $0E
        BEQ .no_u			; and the cursor isn't at the first page,
        DEC $0E				; move the page up.
    +   LDA #$23
        STA $1DFC|!addr
        jmp .return
        
    .no_u
		lda !inventory_cursor
		asl #2
		tax 
		phb
		lda.l item_disable+$02,x
		pha 
		plb 
		lda.l item_disable+$01,x
		pha 
		lda.l item_disable+$00,x
		pha 
		ldy #$00
		lda ($01,s),y
		ldy #$00
		and.l item_disable+$03,x
		bne $01
		iny 
		tya 
		sta !inventory_disabled_item
		pla 
		pla 
		plb 

        LDA $16
        ORA $18
        AND #$CC
        BEQ .check_buttons			; If A, B, X, or Y is pressed,
        
        LDX !inventory_cursor
        LDA !inventory_sram,x
        BEQ .check_purchase			; and the item stack isn't empty,
        TXA
        ASL
        TAX
        JSR (item_actions,x)		; run the item action.
        
        LDX !inventory_cursor
        LDA !inventory_sram,x
        DEC
        STA !inventory_sram,x
        RTS

	.pre_return
		jmp .return

	.check_buttons
		lda.l energy_link
		beq .pre_return
		lda !inventory_disabled_item
		bne .pre_return

		lda !inventory_cursor
		tax 
		lda !inventory_sram,x
		bne .pre_return

		lda !inventory_cursor
		asl 
		tax 
		rep #$20
		lda.l item_cost,x
		jsr draw_energy_link_cost

		lda $18
		and #$30
		beq .return
		bra .buy
	
	.check_purchase
		lda.l energy_link
		beq .pre_return
		lda !inventory_disabled_item
		bne .pre_return
	.buy
		lda !inventory_cursor
		tax 
		lda !inventory_sram,x
		bne .return
		lda !inventory_cursor
		inc
		sta !energy_link_item
		dec 
		asl 
		tax 
		rep #$20
		lda.l item_cost,x
		sta !energy_link_purchase
		jsr draw_energy_link_cost
		lda #$00
		sta !energy_link_reply
		sei 
		lda #$00
		sta $4200
	..wait
		lda !energy_link_reply
		beq ..wait
		pha 
		lda #$A1
		sta $4200
		cli 
		pla 
		bmi ..not_enough_funds
	..actually_purchasing
		tax 
		dex 
		lda !inventory_sram,x
		inc 
		sta !inventory_sram,x
		lda #$00
		sta !energy_link_reply
		lda #$29
		sta $1DFC|!addr
		rts 

	..not_enough_funds
		lda #$2A
		sta $1DFC|!addr
		lda #$00
		sta !energy_link_reply
		rts 


    .return
        LDA $0F
        BPL +				; If the index is negative,
        DEC $0E
        LDA #$09
        STA $0F				; move a page back.
    +	CMP #$0A
        BCC +				; If the index is too large,
        INC $0E
        STZ $0F				; move a page forward.
    +	LDA $0E
        ASL
        ASL
        ADC $0E
        ASL
        ADC $0F				; Set the cursor to 10 * page + index
        CMP #!num_items
        BCC .no_max
        LDA #!num_items-1		; Set the cursor <= !num_items-1.
    .no_max
        STA !inventory_cursor
        RTS

inventory_disable_items:
		lda $0218|!addr,y
		sta $021C|!addr,y
		lda $0219|!addr,y
		sta $021D|!addr,y
		lda $021A|!addr,y
		sta $021E|!addr,y
		lda #$EE
		sta $021A|!addr,y
		lda $021B|!addr,y
		sta $021F|!addr,y
		lda #$38
		sta $021B|!addr,y
		phy 
		tya 
		lsr #2
		tay 
		lda #$02
		sta $0427|!addr,y
		ply 
		iny #4
		rts 
		

digits:		db $E0,$E1,$E2,$E3,$E4,$E5,$F0,$F1
		db $F2,$F3

item_actions:
        dw mushroom			; The actions to take when using an item.
		dw flower
		dw cape
		dw star
		dw green_yoshi
		dw red_yoshi
		dw blue_yoshi
		dw yellow_yoshi

max_items:	db $63,$63,$63,$63,$63,$63,$63,$63		; The maximum amount of items that can be carried.
		
item_tiles:	db $80,$84,$88,$8C,$A0,$A4,$A8,$AC		; The item tiles.
		
item_props:	db $38,$3E,$3C,$3C,$3E,$38,$3A,$3C		; The item yxppccct properties.
		
item_disable:
		dl !ability_byte_2 : db $01
		dl !ability_byte_2 : db $02
		dl !ability_byte_2 : db $04
		dl !ability_byte_2 : db $10
		dl !ability_byte_1 : db $02
		dl !ability_byte_1 : db $02
		dl !ability_byte_1 : db $02
		dl !ability_byte_1 : db $02

item_cost:
	dw 0035
	dw 0050
	dw 0085
	dw 0035
	dw 0070
	dw 0085
	dw 0100
	dw 0085

mushroom:
		lda !ability_byte_2
		and #$01
		beq .return
        LDA #$01
        LDX $19
        BEQ powerup_shared
        ldx $0DB3|!addr
		lda $0DBC|!addr,x
		sta $00
		ldx $19
		lda.l powerup_box_lut,x
		cmp $00
		bne powerup_shared_box
	.return
        PLA
        PLA
        RTS
        
flower:
		lda !ability_byte_2
		and #$02
		beq .return
        LDA #$03
        CMP $19
        BNE powerup_shared
        ldx $0DB3|!addr
		lda $0DBC|!addr,x
		sta $00
		ldx $19
		lda.l powerup_box_lut,x
		cmp $00
		bne powerup_shared_box
	.return
        PLA
        PLA
        RTS
        
cape:
		lda !ability_byte_2
		and #$04
		beq .return
        LDA #$02
        CMP $19
        BNE powerup_shared
        ldx $0DB3|!addr
		lda $0DBC|!addr,x
		sta $00
		ldx $19
		lda.l powerup_box_lut,x
		cmp $00
		bne powerup_shared_box
	.return
        PLA
        PLA
        RTS
        
star:
		lda !ability_byte_2
		and #$10
		beq .return
        LDA $1490|!addr
        BNE +
        LDA #$FF
        STA $1490|!addr
        STA !star_power
        BRA sound_shared
        
	.return
    +	PLA
        PLA
        RTS

powerup_shared:
		ldx $19
		phx 
        LDX $0DB3|!addr
        STA $19
        STA $0DB8|!addr,x
		plx 
	.box
		lda.l powerup_box_lut,x
		beq sound_shared
        ldx $0DB3|!addr
		sta $0DC2|!addr
		sta $0DBC|!addr,x
sound_shared:
        LDA #$0A
        STA $1DF9|!addr
        RTS

powerup_box_lut:
		db $00,$01,$04,$02

green_yoshi:
		lda #$0A
		bra yoshi_shared
blue_yoshi:
		lda #$06
		bra yoshi_shared
red_yoshi:
		lda #$08
		bra yoshi_shared
yellow_yoshi:
		lda #$04
		bra yoshi_shared


yoshi_shared:
		sta $00
		lda !ability_byte_1
		and #$02
		beq .return
		lda $187A|!addr
		beq .valid
		lda $0DBA|!addr
		cmp $00
		beq .return
	.valid	
        lda $00
		sta $0DBA|!addr
		lda #$01
		sta $187A|!addr
        LDA #$0A
        STA $1DF9|!addr
        RTS
	.return	
		pla 
		pla 
		rts 

;##########################################################

draw_item_box:
		ldy #$00
		ldx #$00
	.loop
		lda.l .x_disp,x
		clc 
		adc #$12
		sta $0300|!addr,y
		lda.l .y_disp,x
		clc 
		adc #$29
		sta $0301|!addr,y
		lda #$EC
		sta $0302|!addr,y
		lda.l .props,x
		sta $0303|!addr,y
		phy 
		tya 
		lsr #2
		tay 
		lda #$02
		sta $0460|!addr,y
		ply 
		iny #4
		inx 
		cpx #$05
		bne .loop
		dey #4
		ldx $0DC2|!addr
		lda.l .tiles-$01,x
		sta $0302|!addr,y
		lda.l .tiles_props-$01,x
		sta $0303|!addr,y
		rts 

	.x_disp
		db $00,$10,$00,$10,$08
	.y_disp
		db $00,$00,$10,$10,$08
	.props
		db $38,$78,$B8,$F8,$38
	.tiles
		db $80,$84,$8C,$88
	.tiles_props
		db $38,$3E,$3C,$3C


draw_energy_link_coins:
		rep #$20
		lda !energy_link_count
		jsr HexToDecSuper
		sta $0A
		sty $09
		stx $08
		lda $06
		sta $07

		lda #$E4
		sta $00
		lda #$2A
		sta $01
		ldy #$E8
		jsr draw_coin_counter
		rts 

draw_energy_link_cost:
		jsr HexToDecSuper
		sta $0A
		sty $09
		stx $08
		lda $06
		sta $07

		lda #$E4
		sta $00
		lda #$34
		sta $01
		ldy #$C0
		jsr draw_coin_counter
		lda #$EB
		sta $0206|!addr,y
		rts 


draw_coin_counter:
		ldx #$03
	.loop
		lda $00
		sta $0200|!addr,y
		sec 
		sbc #$06
		sta $00
		lda $01
		sta $0201|!addr,y 
		lda $07,x
		phx 
		tax 
		lda.l digits,x
		plx 
		sta $0202|!addr,y
		lda #$3E
		sta $0203|!addr,y
		phy 
		tya 
		lsr #2
		tay 
		lda #$00
		sta $0420|!addr,y
		ply 
		iny #4
		dex 
		bpl .loop

		phy 
		tya 
		sec
		sbc #$10
		tay 

		lda $07
		bne +
		lda #$F0
		sta $020D|!addr,y
	+	
		lda $07
		ora $08
		bne +
		lda #$F0
		sta $0209|!addr,y
	+	
		lda $07
		ora $08
		ora $09
		bne +
		lda #$F0
		sta $0205|!addr,y
	+	
		ply 

	.draw_static
		lda $00
		sec 
		sbc #$02
		sta $0204|!addr,y
		sec 
		sbc #$08
		sta $0200|!addr,y
		lda $01
		sta $0201|!addr,y
		sta $0205|!addr,y
		lda #$EA
		sta $0202|!addr,y
		lda #$FA
		sta $0206|!addr,y
		lda #$38
		sta $0203|!addr,y
		lda #$38
		sta $0207|!addr,y
		phy 
		tya 
		lsr #2
		tay 
		lda #$00
		sta $0420|!addr,y
		sta $0421|!addr,y
		ply 
		rts 

;##########################################################

HexToDecSuper:

STZ $06
LDY #$00
LDX #$00

StartCompare4:
CMP #$2710
BCC StartCompare5
SBC #$2710
INC $07
BRA StartCompare4

StartCompare5:
CMP #$03E8
BCC StartCompare6
SBC #$03E8
INC $06
BRA StartCompare5

StartCompare6:
CMP.w #$0064
BCC StartCompare7
SBC.w #$0064
INX
BRA StartCompare6

StartCompare7:
CMP.w #$000A
BCC FinishHTD3
SBC.w #$000A
INY
BRA StartCompare7

FinishHTD3:

SEP #$20

rts