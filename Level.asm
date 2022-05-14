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

	Draw: {		
		
		// Angolo Up-Sx		
		ldx #$00
		lda #79
		sta SCREEN_RAM, x
		lda #$01
		sta COLOR_RAM, x

		// Angolo Dw-Sx		
		lda #79
		sta $0400+$03c0
		lda #$01
		sta $d800+$03c0

		// Lato Up
		ldx #$01
		lda #69
		sta SCREEN_RAM, x
		lda #$01
		sta COLOR_RAM, x

		ldx #$02
		lda #69
		sta SCREEN_RAM, x
		lda #$01
		sta COLOR_RAM, x

		ldx #$03
		lda #69
		sta SCREEN_RAM, x
		lda #$01
		sta COLOR_RAM, x

		ldx #$04
		lda #69
		sta SCREEN_RAM, x
		lda #$01
		sta COLOR_RAM, x

		// ldx #$01
		// lda #$4f
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x
					
		
	    rts
	}
}