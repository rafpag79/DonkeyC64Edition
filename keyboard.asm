Keyboard: {
	KeyScan: {
			//76543210
		lda #%11111111
		sta KEYBOARD_DDR_PORT_A_ROW // Dir A 
			//76543210
		lda #%00000000
		sta KEYBOARD_DDR_PORT_A_COL // Dir B

		// A = $dc00   Col
		lda #%11101111     //Voglio leggere Colonna 4
		sta KEYBOARD_DR_PORT_A_COL

		// B = $dc01   Row
		lda KEYBOARD_DR_PORT_A_ROW
		//10111111 bf, key O
		// cmp Keyboard.Tasto_O
		// beq !keyO+
//		sta KeyCaptured

		// *** Store Array *** //				
		ldx FrameCounter
		
		sta KeyCapturedArray, x	   //$0b94

	!exit:
		rts
	}

	Reset: {
		ldx #$00
	!loop:
		lda #$00
		sta KeyCapturedArray, x
		inx
		cpx #$ff		
		bne !loop-		
		rts
	}

}
