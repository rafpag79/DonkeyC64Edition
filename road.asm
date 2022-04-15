Road: {
	Update: {
		// *** Speed *** //	
		//Search speed
		//         0   1    2    3  4   5  6
 		// .byte   0, 32, 64, 96,128,160,192, 
		// .byte $00,$20,$40,$60,$80,$a0,$c0
		//         0,  1   2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15
		// .byte $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$a0,$b0,$c0,$d0,$e0,$f0
	/*.for(var i=0;i<8;i++) {		
		lda #$20 * i
		cmp FrameCounter	
		beq !uguale+
		rts
	!uguale:
		jmp roadSpeedMatchYes		
	}*/

	lda #$00
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #CAR_SPEED*1
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #CAR_SPEED*2 
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #CAR_SPEED*3 
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #CAR_SPEED*4 
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #CAR_SPEED*5 
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #CAR_SPEED*6
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #CAR_SPEED*7 
	cmp FrameCounter
	beq roadSpeedMatchYes

!exit:
	rts
		
roadSpeedMatchYes:	
	 // .break
		// *** If Pari o Dispari Then Goto *** //	 
		lda RoadPariOrDispari 
		cmp #ROAD_PARI
		beq !rowPari+

		lda RoadPariOrDispari 
		cmp #ROAD_DISPARI
		beq !rowDispari+

		rts
		
	!rowPari:
		lda #ROAD_DISPARI
		sta RoadPariOrDispari 
		rts
	!rowDispari:
		lda #ROAD_PARI
		sta RoadPariOrDispari 
		rts
	}

	Draw: {
		// *** If Pari o Dispari Then Goto *** //
		lda RoadPariOrDispari 
		cmp #ROAD_PARI
		beq !rowEven+
		
		lda RoadPariOrDispari		
		cmp #ROAD_DISPARI
		beq !rowOdd+		
		rts

	!rowEven:		
		// .break
		// Pari: Pieno
		lda #$04
		sta SCREEN_RAM + 0 * SCREEN_ROW_LENGTH + $13 //1
		sta SCREEN_RAM + 2 * SCREEN_ROW_LENGTH + $13 //2
		sta SCREEN_RAM + 4 * SCREEN_ROW_LENGTH + $13 //3
		sta SCREEN_RAM + 6 * SCREEN_ROW_LENGTH + $13 //4
		sta SCREEN_RAM + 8 * SCREEN_ROW_LENGTH + $13 //5
		sta SCREEN_RAM + 10 * SCREEN_ROW_LENGTH + $13 //6
		sta SCREEN_RAM + 12 * SCREEN_ROW_LENGTH + $13 //7
		sta SCREEN_RAM + 14 * SCREEN_ROW_LENGTH + $13 //8
		sta SCREEN_RAM + 16 * SCREEN_ROW_LENGTH + $13 //9
		sta SCREEN_RAM + 18 * SCREEN_ROW_LENGTH + $13 //10
		sta SCREEN_RAM + 20 * SCREEN_ROW_LENGTH + $13 //11
		sta SCREEN_RAM + 22 * SCREEN_ROW_LENGTH + $13 //12
		sta SCREEN_RAM + 24 * SCREEN_ROW_LENGTH + $13 //13
		// Dispari: Vuoto
		lda #$00
		sta SCREEN_RAM + 1 * SCREEN_ROW_LENGTH + $13 //1
		sta SCREEN_RAM + 3 * SCREEN_ROW_LENGTH + $13 //2
		sta SCREEN_RAM + 5 * SCREEN_ROW_LENGTH + $13 //3
		sta SCREEN_RAM + 7 * SCREEN_ROW_LENGTH + $13 //4
		sta SCREEN_RAM + 9 * SCREEN_ROW_LENGTH + $13 //5
		sta SCREEN_RAM + 11 * SCREEN_ROW_LENGTH + $13 //6
		sta SCREEN_RAM + 13 * SCREEN_ROW_LENGTH + $13 //7
		sta SCREEN_RAM + 15 * SCREEN_ROW_LENGTH + $13 //8
		sta SCREEN_RAM + 17 * SCREEN_ROW_LENGTH + $13 //9
		sta SCREEN_RAM + 19 * SCREEN_ROW_LENGTH + $13 //10
		sta SCREEN_RAM + 21 * SCREEN_ROW_LENGTH + $13 //11
		sta SCREEN_RAM + 23 * SCREEN_ROW_LENGTH + $13 //12
		rts

	!rowOdd:		
		// .break
		// Pari: Niente
		lda #$00
		sta SCREEN_RAM + 0 * SCREEN_ROW_LENGTH + $13 //1
		sta SCREEN_RAM + 2 * SCREEN_ROW_LENGTH + $13 //2
		sta SCREEN_RAM + 4 * SCREEN_ROW_LENGTH + $13 //3
		sta SCREEN_RAM + 6 * SCREEN_ROW_LENGTH + $13 //4
		sta SCREEN_RAM + 8 * SCREEN_ROW_LENGTH + $13 //5
		sta SCREEN_RAM + 10 * SCREEN_ROW_LENGTH + $13 //6
		sta SCREEN_RAM + 12 * SCREEN_ROW_LENGTH + $13 //7
		sta SCREEN_RAM + 14 * SCREEN_ROW_LENGTH + $13 //8
		sta SCREEN_RAM + 16 * SCREEN_ROW_LENGTH + $13 //9
		sta SCREEN_RAM + 18 * SCREEN_ROW_LENGTH + $13 //10
		sta SCREEN_RAM + 20 * SCREEN_ROW_LENGTH + $13 //11
		sta SCREEN_RAM + 22 * SCREEN_ROW_LENGTH + $13 //12
		sta SCREEN_RAM + 24 * SCREEN_ROW_LENGTH + $13 //13 
		// Dispari: Pieno
		lda #$04
		sta SCREEN_RAM + 1 * SCREEN_ROW_LENGTH + $13 //1
		sta SCREEN_RAM + 3 * SCREEN_ROW_LENGTH + $13 //2
		sta SCREEN_RAM + 5 * SCREEN_ROW_LENGTH + $13 //3
		sta SCREEN_RAM + 7 * SCREEN_ROW_LENGTH + $13 //4
		sta SCREEN_RAM + 9 * SCREEN_ROW_LENGTH + $13 //5
		sta SCREEN_RAM + 11 * SCREEN_ROW_LENGTH + $13 //6
		sta SCREEN_RAM + 13 * SCREEN_ROW_LENGTH + $13 //7
		sta SCREEN_RAM + 15 * SCREEN_ROW_LENGTH + $13 //8
		sta SCREEN_RAM + 17 * SCREEN_ROW_LENGTH + $13 //9
		sta SCREEN_RAM + 19 * SCREEN_ROW_LENGTH + $13 //10
		sta SCREEN_RAM + 21 * SCREEN_ROW_LENGTH + $13 //11
		sta SCREEN_RAM + 23 * SCREEN_ROW_LENGTH + $13 //12
		//sta SCREEN_RAM + 25 * SCREEN_ROW_LENGTH + $13 //13
		rts	
	}
}
