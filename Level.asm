Level: 
{

	// InitNo: 
	// {
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

	Draw: 
	{		
		
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

	DrawPunteggio:
	{
		// *** Punteggio *** //
		.for(var i=0;i<7;i++) {
			lda [Text.txtDonkey +i]
			sta [SCREEN_RAM_ROW5 +OFFSET3 +i]
			lda #$01
			sta [COLOR_RAM_ROW5 +OFFSET3 +i]
		}

		// .for(var i=0; i<4; i++) {
		//  	lda [Text.txtCar +i]
		//  	sta [SCREEN_RAM_ROW5 +OFFSET4 +i]
		// 	lda #$01
		// 	sta [COLOR_RAM_ROW5 +OFFSET4 +i]
		// }

		// lda #CHAR_D
		// sta [SCREEN_RAM_ROW5+1]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +1]

		// lda #CHAR_O
		// sta [SCREEN_RAM_ROW5+2]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +2]

		// lda #CHAR_N
		// sta [SCREEN_RAM_ROW5+3]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +3]

		// lda #CHAR_K
		// sta [SCREEN_RAM_ROW5+4]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +4]

		// lda #CHAR_E
		// sta [SCREEN_RAM_ROW5+5]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +5]

		// lda #CHAR_Y
		// sta [SCREEN_RAM_ROW5+6]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +6]

		// lda #CH_NUM_2DOT
		// sta [SCREEN_RAM_ROW5+7]
		// lda #$01
		// sta [COLOR_RAM_ROW5 +7]		

		rts
	}

	Init2: 
	{	
		
		// *** Linea Sinistra *** //

		// Prato
		.for(var r=0;r<25;r++) {
			.for(var i=0;i<13;i++) {
				lda #$3a
				sta $0400 +40*r + i //1 $0400+40*0
				lda #COLOR_GREEN
				sta	$d800 +40*r +i
			}
		}	

		// Linea sx
		.for(var r=0;r<25;r++) {
			lda #LANE_SX_CHAR
			sta $0400 +40*r + OFFSET2 			
		}

		// *** Linea Destra *** //
		
		// Prato
		.for(var r=0;r<25;r++) {
			.for(var i=0;i<13;i++) {
				lda #$3a
				sta $0400 +40*[r+1] - i
				lda #COLOR_GREEN
				sta	$d800 +40*[r+1] - i
			}
		}

		// Linea dx
		.for(var r=0;r<25;r++) {
			lda #LANE_DX_CHAR
			sta $0400 +40*[r+1] - OFFSET2 			
		}	

		// *** Punteggio *** //
		// .for(var i=0;i<7;i++) {
		// 	lda Text.txtDonkey +i
		// 	sta SCREEN_RAM_ROW5 +OFFSET3 +i
		// 	// .break
		// 	lda #$01
		// 	sta COLOR_RAM_ROW5 +OFFSET3 +i
		// }

		// .for(var i=0;i<1;i++) {
		//  	lda Text.txtCar +i
		//  	sta SCREEN_RAM_ROW5 +OFFSET4 +i
		// 	// .break
		// 	lda #$01
		// 	sta COLOR_RAM_ROW5 +OFFSET4 +i
		// }
		// .break

		jsr Level.DrawPunteggio
		 // rts

	}
}