Intro: {
	// Init: {
	// 	ldx #$00		
	// 	!loop:
	// 		lda MAP, x
	// 		sta SCREEN_RAM, x
	// 		lda #$03
	// 		sta COLOR_RAM, x
					
	// 		lda MAP+$100, x
	// 		sta SCREEN_RAM+$100, x
	// 		lda #$03
	// 		sta COLOR_RAM+$100, x

	// 		lda MAP+$200, x
	// 		sta SCREEN_RAM+$200, x
	// 		lda #$03
	// 		sta COLOR_RAM+$200, x

	// 		lda MAP+$300, x
	// 		sta SCREEN_RAM+$300, x
	// 		lda #$03
	// 		sta COLOR_RAM+$300, x
	// 		inx
	// 		bne !loop-
					
	// 	!exit:
	//     	rts
	// }

	Update: {

		// *** Change Lane *** //
			// ldx FrameCounter
			// cpx #$00

			// sbc #$20
			// sta KeyCapturedIndexEnd

		
		// ldx CurWindowBegin
		// cpx #$01
		// beq !window1+

		// *** Speed *** //
		// jsr Speed.WhatWindow2

		// *** Speed Match *** //
		lda #$00
		cmp FrameCounter
		beq introSpeedMatchYes
		
		lda #$20
		cmp FrameCounter
		beq introSpeedMatchYes
		
		lda #$40
		cmp FrameCounter
		beq introSpeedMatchYes
		
		lda #$60
		cmp FrameCounter
		beq introSpeedMatchYes

		lda #$80
		cmp FrameCounter
		beq introSpeedMatchYes

		lda #$a0
		cmp FrameCounter
		beq introSpeedMatchYes

		lda #$c0
		cmp FrameCounter
		beq introSpeedMatchYes

		lda #$e0
		cmp FrameCounter
		beq introSpeedMatchYes

	introSpeedMatchNo:
		//jsr Intro.Draw
		rts

	introSpeedMatchYes:	
		ldx #$00
	!next:
		// .break
		lda KeyCapturedArray, x
		cmp #%10111111
		beq !trovato+

		cpx #$ff		
		beq !exit+

		inx
		jmp !next-

	!trovato:
		// .break
		jsr Keyboard.Reset
		jsr ClearScreen
		jsr Level.Init2
		//Change State
		lda #$02
		sta GameState					

	!exit:
		rts

		// !change:
			// lda #$02
			// sta GameState
			// rts		
	}

	DrawScreen: {		
		
		// Donkey		
		lda #CHAR_D
		sta SCREEN_RAM_ROW10+18
		lda #$03
		sta COLOR_RAM_ROW10+18

		lda #CHAR_O
		sta SCREEN_RAM_ROW10+19
		lda #$03
		sta COLOR_RAM_ROW10+19
		
		lda #CHAR_N
		sta SCREEN_RAM_ROW10+20
		lda #$03
		sta COLOR_RAM_ROW10+20
		
		lda #CHAR_K
		sta SCREEN_RAM_ROW10+21
		lda #$03
		sta COLOR_RAM_ROW10+21

		lda #CHAR_E
		sta SCREEN_RAM_ROW10+22
		lda #$03
		sta COLOR_RAM_ROW10+22

		lda #CHAR_Y
		sta SCREEN_RAM_ROW10+23
		lda #$03
		sta COLOR_RAM_ROW10+23


		// Window Angolo 1		
		lda #48
		sta SCREEN_RAM_ROW4+6
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW4+6

		// Window Angolo 2		
		lda #50
		sta SCREEN_RAM_ROW4_END-6
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW4_END-6

		// Window Angolo 3
		lda #51
		sta SCREEN_RAM_ROW18+6
		lda #COLOR_RED
		sta COLOR_RAM_ROW18+6

		// Window Angolo 4
		lda #53
		sta SCREEN_RAM_ROW18_END-6
		lda #COLOR_BLUE
		sta COLOR_RAM_ROW18_END-6

		// Window Lato Orizzontale 1
		ldx #$00
	!loop:
		lda #49
		sta SCREEN_RAM_ROW4+6+1, x
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW4+6+1, x
		inx
		cpx #$1a
		bne !loop-

		// Window Lato Orizzontale 2				
		ldx #$00
	!loop:
		lda #52
		sta SCREEN_RAM_ROW18+6+1, x
		lda #COLOR_VIOLET
		sta COLOR_RAM_ROW18+6+1, x
		inx
		cpx #$1a
		bne !loop-

		// Window Lato Verticale 1				
		.for(var y=0;y<13;y++) {			
			lda #54
			sta SCREEN_RAM_ROW5+[y*40]+6
			lda #COLOR_YELLOW
			sta COLOR_RAM_ROW5+[y*40]+6
		}

		// Window Lato Verticale 2
		.for(var y=0;y<13;y++) {			
			lda #55
			sta SCREEN_RAM_ROW5_END+[y*40]-6
			lda #COLOR_YELLOW
			sta COLOR_RAM_ROW5_END+[y*40]-6
		}

		// Version 1.0		
		lda #CHAR_V
		sta SCREEN_RAM_ROW12+14+1
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+1
		
		lda #CHAR_E
		sta SCREEN_RAM_ROW12+14+2
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+2

		lda #CHAR_R
		sta SCREEN_RAM_ROW12+14+3
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+3

		lda #CHAR_S
		sta SCREEN_RAM_ROW12+14+4
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+4

		lda #CHAR_I
		sta SCREEN_RAM_ROW12+14+5
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+5

		lda #CHAR_O
		sta SCREEN_RAM_ROW12+14+6
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+6

		lda #CHAR_N
		sta SCREEN_RAM_ROW12+14+7
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+7

		lda #CH_NUM_1
		sta SCREEN_RAM_ROW12+14+8+1
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+8+1

		lda #CH_NUM_DOT
		sta SCREEN_RAM_ROW12+14+9+1
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+9+1

		lda #CH_NUM_0
		sta SCREEN_RAM_ROW12+14+10+1
		lda #COLOR_GREEN
		sta COLOR_RAM_ROW12+14+10+1

		// Press space key to play
		lda #CHAR_P
		sta SCREEN_RAM_ROW22+OF1
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1

		lda #CHAR_R
		sta SCREEN_RAM_ROW22+OF1+1
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+1

		lda #CHAR_E
		sta SCREEN_RAM_ROW22+OF1+2
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+2

		lda #CHAR_S
		sta SCREEN_RAM_ROW22+OF1+3
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+3

		lda #CHAR_S
		sta SCREEN_RAM_ROW22+OF1+4
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+4


		lda #CHAR_S
		sta SCREEN_RAM_ROW22+OF1+6
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+6

		lda #CHAR_P
		sta SCREEN_RAM_ROW22+OF1+7
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+7

		lda #CHAR_A
		sta SCREEN_RAM_ROW22+OF1+8
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+8

		lda #CHAR_C
		sta SCREEN_RAM_ROW22+OF1+9
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+9

		lda #CHAR_E
		sta SCREEN_RAM_ROW22+OF1+10
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+10


		lda #CHAR_T
		sta SCREEN_RAM_ROW22+OF1+12
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+12

		lda #CHAR_O
		sta SCREEN_RAM_ROW22+OF1+13
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+13


		lda #CHAR_P
		sta SCREEN_RAM_ROW22+OF1+15
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+15

		lda #CHAR_L
		sta SCREEN_RAM_ROW22+OF1+16
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+16

		lda #CHAR_A
		sta SCREEN_RAM_ROW22+OF1+17
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+17

		lda #CHAR_Y
		sta SCREEN_RAM_ROW22+OF1+18
		lda #COLOR_RED
		sta COLOR_RAM_ROW22+OF1+18





		// // Angolo Dw-Sx		
		// lda #79
		// sta $0400+$03c0
		// lda #$01
		// sta $d800+$03c0

		// // Lato Up
		// ldx #$01
		// lda #69
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x

		// ldx #$02
		// lda #69
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x

		// ldx #$03
		// lda #69
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x

		// ldx #$04
		// lda #69
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x

		// ldx #$01
		// lda #$4f
		// sta SCREEN_RAM, x
		// lda #$01
		// sta COLOR_RAM, x
					
		
	    rts
	}
}

Titolo:
	.text "Hello World"
Press:
	.text "press space key to play"