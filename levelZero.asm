Map: {
	Init: {
		ldx #$00		
		!loop:
			lda MAP, x
			sta SCREEN_RAM, x
			lda #$03
			sta COLOR_RAM, x
					
			lda MAP+$100, x
			sta SCREEN_RAM+$100, x
			lda #$03
			sta COLOR_RAM+$100, x

			lda MAP+$200, x
			sta SCREEN_RAM+$200, x
			lda #$03
			sta COLOR_RAM+$200, x

			lda MAP+$300, x
			sta SCREEN_RAM+$300, x
			lda #$03
			sta COLOR_RAM+$300, x
			inx
			bne !loop-
					
		!exit:
	    	rts
	}
}