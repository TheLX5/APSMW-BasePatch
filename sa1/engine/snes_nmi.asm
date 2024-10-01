; Character Conversion DMA base macro.
; A is 16-bit, Y is 8-bit.
; X is remain CDMA slots.
macro cc1_dma_slot(slot)
	LDY.W !CCDMA_TABLE+(<slot>*8)+0		; Load CDMA value
	BMI ?normal_dma				; If is >= #$80, it's normal DMA
	STY $2231				; Otherwise store the CDMA register value.
						;
						;
	LDA.W !CCDMA_TABLE+(<slot>*8)+3		; \ Set source of bitmap in BW-RAM.
	STA $2232				;  | (Both SA-1 and CPU Register.)
	STA $4322				;  |
	LDY.W !CCDMA_TABLE+(<slot>*8)+5		;  |
	STY $2234				;  |
	STY $4324				; /
						;
	LDA.W #!CC_BUFFER			; \ Set I-RAM buffer.
	STA $2235				; / (This is used as buffer in conversion, like the echo buffer.)
						;
	LDY $318E
	BMI +
						
	CLI					; \ Wait for SA-1 CCDMA.
-	LDY $318D				;  | (probably it's doing the first character conversion)
	BEQ -					;  |
	DEY					;  |
	STY $318D				;  |
	SEI					; /
						;
+	LDA.W !CCDMA_TABLE+(<slot>*8)+6		; \ Store size of conversion+transfer
	STA $4325				; /
	LDA.W !CCDMA_TABLE+(<slot>*8)+1		; \ Store VRAM address.
	STA $2116				; /
						;
	LDY #$04				; \ Run SA-1 AND CPU DMA
	STY $420B				; /
						;
	DEX					; \ If there are no more remaining,
	BNE +					;  | jump to CCDMA_END routine, otherwise,
	JMP .cc1_end				; / continue.

?normal_dma:
	LDY #$80				; \ Make sure that CCDMA is turned off.
	STY $2231				;  |
	LDY #$82				;  |
	STY $2200				; /
						;
	LDA.W !CCDMA_TABLE+(<slot>*8)+1		; \ Set VRAM address
	STA $2116				; /
	LDA.W !CCDMA_TABLE+(<slot>*8)+3		; \ Set source address
	STA $4322				;  |
	LDY.W !CCDMA_TABLE+(<slot>*8)+5		;  |
	STY $2234				; /
	LDA.W !CCDMA_TABLE+(<slot>*8)+6		; \ Store size of conversion+transfer
	STA $4325				; /
						;
	LDY #$04				; \ Transfer.
	STY $420B				; /
						;
	LDY #$81				; \ Enable again Character Conversion DMA.
	STY $2200				; /
						;
;?end:						;
	DEX					; \ If there are no more remaining,
	BNE +					;  | jump to CCDMA End routine, otherwise,
	JMP .cc1_end				; / continue.
+
endmacro

snes_nmi:
	REP #$30				; \ Preserve A/X/Y/D/B
	PHA					;  |
	PHX					;  |
	PHY					;  |
	PHD					;  |
	PHB					;  |
	PHK					;  |
	PLB					;  |
	LDA.w #$3000				;  |
	TCD					; /
	SEP #$30				; 8-bit A/X/Y
						;
	LDA.w snes_irq_mem+3			; \ Preserve BW-RAM Mapping and
	STZ.w snes_irq_mem+3			;  | reset to default value.
	STZ $2224				;  |
	PHA					; /
						;
.main:						;
	LDA !CCDMA_SLOTS			; \ If there are no slots to transfer,
	BNE +					;  | jump to Dynamic_Sprites.
	JMP .end_1			; /
						;
+	TAX					; Put CCDMA slot count into X.
	REP #$20				; 16-bit A
	LDA #$1801				; \ Dest: $2118
	STA $4320				; / Write twice
	LDY #$81				; \ Tell SA-1 to enable Character Conversion DMA #1
	STY $2200				; /
	DEY					; \ Increase $2116/$2117 then writing to $2119
	STY $2115				; /
-	LDA $318D				; \ Make sure that Character Conversion is ON. 
	BEQ -					; |
	STZ $318D				; /
						;
	%cc1_dma_slot(0)			; \ Unrolled loop
	%cc1_dma_slot(1)			;  | to run each character conversion DMA table slot.
	%cc1_dma_slot(2)			;  |
	%cc1_dma_slot(3)			;  |
	%cc1_dma_slot(4)			;  |
	%cc1_dma_slot(5)			;  |
	%cc1_dma_slot(6)			;  |
	%cc1_dma_slot(7)			;  |
	%cc1_dma_slot(8)			;  |
	%cc1_dma_slot(9)			; /
						;
.cc1_end:					;
	LDY #$80				; \ Tell SA-1 that Character Conversion is done.
	STY $2231				; /
	LDY #$82				; \ Tell SA-1 to disable DMA/CCDMA
	STY $2200				; /
						;
	SEP #$20				; 8-bit A
	STZ !CCDMA_SLOTS			; Clear CCDMA Slots

.end_1
	JML $008172				; /
	
snes_nmi_end2:
	LDX #$81

snes_nmi_end:
	LDA.w snes_irq_mem+0
	AND #$7F
	STA.w snes_irq_mem+0
	BEQ .store
	
	TXA
	BIT #$20
	BEQ .fire
	AND #$7F
	TAX
	BRA .store
	
.fire:
	JSR.w fire_nmi_irq
	BRA .finish
	
.store:
	STX $4200

.finish:
	PLA
	STA $2224
	STA.w snes_irq_mem+3
	
	REP #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

	