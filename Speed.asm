Speed: {

	WhatWindow: {
		// *** Search Window *** //
		// speed = $20 32
		// 8 parti in $FF 256
		// Range: 0-255  sono 256 valori:
		//          Begin            End
		// $00-$1f  0     0*32=0     31   $1f
		// $20-$3f  1     1*32=32    63   $3f
		// $40-$5f  2     2*32=64    95   $5f
		// $60-$7f  3     3*32=96    127  $7f
		// $80-$9f  4     4*32=128   159  $9f 
		// $a0-$bf  5     5*32=160   191  $bf
		// $c0-$df  6     6*32=192   223  $df
		// $e0-$ff  7     7*32=224   255  $ff

	// *** Window 0 *** //
	!CompareWindow0A:
		ldx FrameCounter	
		cpx #$00  // A		
		bcs !CompareWindow0B+ //A>=B
		jmp !CompareWindow1A+
	!CompareWindow0B:
		cpx #$1f  // B
		bcc !window0+  // A<B
		beq !window0+  // A=B

		jmp !CompareWindow1A+

	!window0:
		ldx #$01
		stx CurWindow
		lda #$00
		sta CurWindowBegin
		lda #$1f
		sta CurWindowEnd
		jmp !exit+

	// *** Window 1 *** //
	!CompareWindow1A:
		ldx FrameCounter
		cpx #$20  // A
		bcs !CompareWindow1B+ //A>=B
		jmp !CompareWindow2A+
		cpx #$3f  // B
	!CompareWindow1B:
		bcc !window1+  // A<B
		beq !window1+  // A=B

		jmp !CompareWindow2A+

	!window1:
		ldx #$02
		stx CurWindow

		lda #$20
		sta CurWindowBegin
		lda #$3f
		sta CurWindowEnd

		jmp !exit+

	// *** Window 2 *** //	
	!CompareWindow2A:
		ldx FrameCounter
		cpx #$40  // A		
		bcs !CompareWindow2B+
		jmp !CompareWindow3A+
	!CompareWindow2B:
		cpx #$5f  // B
		bcc !window2+  // A<B
		beq !window2+  // A=B

		jmp !CompareWindow3A+

	!window2:
		ldx #$03
		stx CurWindow
		lda #$40
		sta CurWindowBegin
		lda #$5f
		sta CurWindowEnd
		jmp !exit+


	// *** Window 3 *** //
	!CompareWindow3A:
		ldx FrameCounter
		cpx #$60  // A		
		bcs !CompareWindow3B+ //A>=B
		jmp !CompareWindow4A+
	!CompareWindow3B:
		cpx #$7f  // B
		bcc !window3+  // A<B
		beq !window3+  // A=B

		jmp !CompareWindow4A+

	!window3:
		ldx #$04
		stx CurWindow
		lda #$60
		sta CurWindowBegin
		lda #$7f
		sta CurWindowEnd
		jmp !exit+

	// *** Window 4 *** //
	!CompareWindow4A:
		ldx FrameCounter
		cpx #$80  // A
		bcs !CompareWindow4B+
		jmp !CompareWindow5A+
	!CompareWindow4B:
		cpx #$9f  // B
		bcc !window4+  // A<B
		beq !window4+  // A=B

		jmp !CompareWindow5A+

	!window4:
		ldx #$05
		stx CurWindow
		lda #$80
		sta CurWindowBegin
		lda #$9f
		sta CurWindowEnd
		jmp !exit+


	// *** Window 5 *** //
	!CompareWindow5A:
		ldx FrameCounter
		cpx #$a0  // A
		bcs !CompareWindow5B+
		jmp !CompareWindow6A+
	!CompareWindow5B:
		cpx #$bf  // B
		bcc !window5+  // A<B
		beq !window5+  // A=B

		jmp !CompareWindow6A+

	!window5:
		ldx #$06
		stx CurWindow
		lda #$a0
		sta CurWindowBegin
		lda #$bf
		sta CurWindowEnd
		jmp !exit+

	// *** Window 6 *** //
	!CompareWindow6A:
		ldx FrameCounter
		cpx #$c0  // A
		bcs !CompareWindow6B+
		jmp !CompareWindow7A+
	!CompareWindow6B:
		cpx #$df  // B
		bcc !window6+  // A<B
		beq !window6+  // A=B
		jmp !CompareWindow7A+

	!window6:
		ldx #$07
		stx CurWindow
		lda #$c0
		sta CurWindowBegin
		lda #$df
		sta CurWindowEnd
		jmp !exit+

	// *** Window 7 *** //
	!CompareWindow7A:
		ldx FrameCounter
		cpx #$e0  // A		
		bcs !CompareWindow7B+		
		jmp !exit+
	!CompareWindow7B:
		cpx #$ff  // B
		bcc !window7+  // A<B
		beq !window7+  // A=B
		jmp !exit+

	!window7:
		ldx #$08
		stx CurWindow
		lda #$e0
		sta CurWindowBegin
		lda #$ff
		sta CurWindowEnd
		jmp !exit+

	!exit:
		rts

	}

	WhatWindow2: {
		// *** Speed *** //
	!speed0:
		lda #$00
		cmp FrameCounter
		beq !SetSpeed0+
		bne !speed1+
	!SetSpeed0:
		jsr SetWindow7
		jmp !exit+
	
	!speed1:
		lda #$20
		cmp FrameCounter
		beq !SetSpeed1+
		bne !speed2+
	!SetSpeed1:
		jsr SetWindow0
		jmp !exit+
		
	!speed2:
		lda #$40
		cmp FrameCounter
		beq !SetSpeed2+
		bne !speed3+
	!SetSpeed2:
		jsr SetWindow1
		jmp !exit+
		
	!speed3:
		lda #$60
		cmp FrameCounter
		beq !SetSpeed3+
		bne !speed4+
	!SetSpeed3:
		jsr SetWindow2
		jmp !exit+

	!speed4:
		lda #$80
		cmp FrameCounter
		beq !SetSpeed4+
		bne !speed5+
	!SetSpeed4:
		jsr SetWindow3
		jmp !exit+

	!speed5:
		lda #$a0
		cmp FrameCounter
		beq !SetSpeed5+
		bne !speed6+
	!SetSpeed5:
		jsr SetWindow4
		jmp !exit+

	!speed6:
		lda #$c0
		cmp FrameCounter
		beq !SetSpeed6+
		bne !speed7+
	!SetSpeed6:
		jsr SetWindow5
		jmp !exit+

	!speed7:
		lda #$e0
		cmp FrameCounter
		beq !SetSpeed7+
		bne !exit+
	!SetSpeed7:
		jsr SetWindow6
		jmp !exit+

	!exit:
		rts

	}

	SetWindow0: {
		ldx #$01
		stx CurWindow
		lda #$00
		sta CurWindowBegin
		lda #$1f
		sta CurWindowEnd
		rts
	}

	SetWindow1: {
		ldx #$02
		stx CurWindow
		lda #$20
		sta CurWindowBegin
		lda #$3f
		sta CurWindowEnd
		rts
	}

	SetWindow2: {
		ldx #$03
		stx CurWindow
		lda #$40
		sta CurWindowBegin
		lda #$5f
		sta CurWindowEnd
		rts
	}

	SetWindow3: {
		ldx #$04
		stx CurWindow
		lda #$60
		sta CurWindowBegin
		lda #$7f
		sta CurWindowEnd
		rts
	}

	SetWindow4: {
		ldx #$05
		stx CurWindow
		lda #$80
		sta CurWindowBegin
		lda #$9f
		sta CurWindowEnd
		rts
	}

	SetWindow5: {
		ldx #$06
		stx CurWindow
		lda #$a0
		sta CurWindowBegin
		lda #$bf
		sta CurWindowEnd
		rts
	}

	SetWindow6: {
		ldx #$07
		stx CurWindow
		lda #$c0
		sta CurWindowBegin
		lda #$df
		sta CurWindowEnd
		rts
	}

	SetWindow7: {
		ldx #$08
		stx CurWindow
		lda #$e0
		sta CurWindowBegin
		lda #$ff
		sta CurWindowEnd
		rts
	}

}