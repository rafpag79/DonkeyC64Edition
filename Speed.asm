Speed: {
	WhatWindow: {
		// *** Search Window *** //
		// speed = $20 32
		// 8 parti in $FF 256
		// Range: 0-255  sono 256 valori:
		// $00-$19  0     0*32=0     31
		// $20-$3f  1     1*32=32    63
		// $40-$5f  2     2*32=64    95
		// $60-$7f  3     3*32=96    127
		// $80-$9f  4     4*32=128   159   
		// $a0-$bf  5     5*32=160   191
		// $c0-$df  6     6*32=192   223
		// $e0-$ff  7     7*32=224   255

		ldx FrameCounter
		
		cpx #$00  // A
		beq !window0+
		bcs !window0+
		cpx #$19  // B
		bcc !window0+  // A<B
		beq !window0+  // A=B

		cpx #$20  // A
		beq !window1+
		bcs !window1+
		cpx #$3f  // B
		bcc !window1+  // A<B
		beq !window1+  // A=B

		cpx #$40  // A
		beq !window2+
		bcs !window2+
		cpx #$5f  // B
		bcc !window2+  // A<B
		beq !window2+  // A=B

		cpx #$60  // A
		beq !window3+
		bcs !window3+
		cpx #$7f  // B
		bcc !window3+  // A<B
		beq !window3+  // A=B

		cpx #$80  // A
		beq !window4+
		bcs !window4+
		cpx #$9f  // B
		bcc !window4+  // A<B
		beq !window4+  // A=B

		cpx #$a0  // A
		beq !window5+
		bcs !window5+
		cpx #$bf  // B
		bcc !window5+  // A<B
		beq !window5+  // A=B

		cpx #$c0  // A
		beq !window6+
		bcs !window6+
		cpx #$df  // B
		bcc !window6+  // A<B
		beq !window6+  // A=B

		cpx #$e0  // A
		beq !window7+
		bcs !window7+
		cpx #$ff  // B
		bcc !window7+  // A<B
		beq !window7+  // A=B

		jmp !exit+

	!window0:
		ldx #$01
		stx CurWindow

		lda #$00
		sta CurWindowBegin
		lda #$19
		sta CurWindowEnd

		jmp !exit+
	!window1:
		ldx #$02
		stx CurWindow

		lda #$20
		sta CurWindowBegin
		lda #$3f
		sta CurWindowEnd

		jmp !exit+
	!window2:
		ldx #$03
		stx CurWindow

		lda #$40
		sta CurWindowBegin
		lda #$5f
		sta CurWindowEnd

		jmp !exit+
	!window3:
		ldx #$04
		stx CurWindow

		lda #$60
		sta CurWindowBegin
		lda #$7f
		sta CurWindowEnd

		jmp !exit+
	!window4:
		ldx #$05
		stx CurWindow

		lda #$80
		sta CurWindowBegin
		lda #$9f
		sta CurWindowEnd

		jmp !exit+
	!window5:
		ldx #$06
		stx CurWindow

		lda #$a0
		sta CurWindowBegin
		lda #$bf
		sta CurWindowEnd

		jmp !exit+
	!window6:
		ldx #$07
		stx CurWindow

		lda #$c0
		sta CurWindowBegin
		lda #$df
		sta CurWindowEnd

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

}