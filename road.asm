Road: {
	Update: {
		// *** Speed *** //	
		//Search speed

	lda #$00
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #$20
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #$40
	cmp FrameCounter
	beq roadSpeedMatchYes
	
	lda #$60
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #$80
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #$a0
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #$c0
	cmp FrameCounter
	beq roadSpeedMatchYes

	lda #$e0
	cmp FrameCounter
	beq roadSpeedMatchYes

!exit:
	rts
		
roadSpeedMatchYes:
		// *** If Pari o Dispari Then *** //	 
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
		// jmp !rowOdd+
		lda RoadPariOrDispari 
		cmp #ROAD_PARI
		beq !rowEven+
		
		lda RoadPariOrDispari		
		cmp #ROAD_DISPARI
		beq !rowOdd+		
		rts

	!rowEven:		
		//.break
		// Pari: Pieno
		lda #$04
		//sta SCREEN_RAM + 0 * SCREEN_ROW_LENGTH + $13 //1
		sta $043b //1
		sta $048b //2 +$50
		sta $04db //3
		sta $052b //4
		sta $057b //5
		sta $05cb //6
		sta $061b //7
		sta $066b //8
		sta $06bb //9
		sta $070b //10
		sta $075b //11
		sta $07ab //12
		
		
		//sta SCREEN_RAM + 2 * SCREEN_ROW_LENGTH  //2
		// sta SCREEN_RAM + 4 * SCREEN_ROW_LENGTH + $13 //3
		// sta SCREEN_RAM + 6 * SCREEN_ROW_LENGTH + $13 //4
		// sta SCREEN_RAM + 8 * SCREEN_ROW_LENGTH + $13 //5
		// sta SCREEN_RAM + 10 * SCREEN_ROW_LENGTH + $13 //6
		// sta SCREEN_RAM + 12 * SCREEN_ROW_LENGTH + $13 //7
		// sta SCREEN_RAM + 14 * SCREEN_ROW_LENGTH + $13 //8
		// sta SCREEN_RAM + 16 * SCREEN_ROW_LENGTH + $13 //9
		// sta SCREEN_RAM + 18 * SCREEN_ROW_LENGTH + $13 //10
		// sta SCREEN_RAM + 20 * SCREEN_ROW_LENGTH + $13 //11
		// sta SCREEN_RAM + 22 * SCREEN_ROW_LENGTH + $13 //12
		// sta SCREEN_RAM + 24 * SCREEN_ROW_LENGTH + $13 //13
		// Dispari: Vuoto
		lda #$00 //$00
		sta $0463 //1
		sta $0463+$50 //2
		sta $0463+$50+$50 //3
		sta $0463+$50+$50+$50 //4
		sta $0463+$50+$50+$50+$50 //5
		sta $0463+$50+$50+$50+$50+$50 //6
		sta $0463+$50+$50+$50+$50+$50+$50 //7
		sta $0463+$50+$50+$50+$50+$50+$50+$50 //8
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50 //9
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50 //10
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //11
		// sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //12

		// sta SCREEN_RAM + 1 * SCREEN_ROW_LENGTH + $13 //1
		// sta SCREEN_RAM + 3 * SCREEN_ROW_LENGTH + $13 //2
		// sta SCREEN_RAM + 5 * SCREEN_ROW_LENGTH + $13 //3
		// sta SCREEN_RAM + 7 * SCREEN_ROW_LENGTH + $13 //4
		// sta SCREEN_RAM + 9 * SCREEN_ROW_LENGTH + $13 //5
		// sta SCREEN_RAM + 11 * SCREEN_ROW_LENGTH + $13 //6
		// sta SCREEN_RAM + 13 * SCREEN_ROW_LENGTH + $13 //7
		// sta SCREEN_RAM + 15 * SCREEN_ROW_LENGTH + $13 //8
		// sta SCREEN_RAM + 17 * SCREEN_ROW_LENGTH + $13 //9
		// sta SCREEN_RAM + 19 * SCREEN_ROW_LENGTH + $13 //10
		// sta SCREEN_RAM + 21 * SCREEN_ROW_LENGTH + $13 //11
		// sta SCREEN_RAM + 23 * SCREEN_ROW_LENGTH + $13 //12
		rts

	!rowOdd:		
		// .break
		// Pari: Niente
		lda #$00
			
		sta $043b //1
		sta $048b //2 +$50
		sta $04db //3
		sta $052b //4
		sta $057b //5
		sta $05cb //6
		sta $061b //7
		sta $066b //8
		sta $06bb //9
		sta $070b //10
		sta $075b //11
		sta $07ab //12
		// sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //12
		//sta SCREEN_RAM + 0 * SCREEN_ROW_LENGTH + $13 //1
		// sta SCREEN_RAM + 2 * SCREEN_ROW_LENGTH + $13 //2
		// sta SCREEN_RAM + 4 * SCREEN_ROW_LENGTH + $13 //3
		// sta SCREEN_RAM + 6 * SCREEN_ROW_LENGTH + $13 //4
		// sta SCREEN_RAM + 8 * SCREEN_ROW_LENGTH + $13 //5
		// sta SCREEN_RAM + 10 * SCREEN_ROW_LENGTH + $13 //6
		// sta SCREEN_RAM + 12 * SCREEN_ROW_LENGTH + $13 //7
		// sta SCREEN_RAM + 14 * SCREEN_ROW_LENGTH + $13 //8
		// sta SCREEN_RAM + 16 * SCREEN_ROW_LENGTH + $13 //9
		// sta SCREEN_RAM + 18 * SCREEN_ROW_LENGTH + $13 //10
		// sta SCREEN_RAM + 20 * SCREEN_ROW_LENGTH + $13 //11
		// sta SCREEN_RAM + 22 * SCREEN_ROW_LENGTH + $13 //12
		//sta SCREEN_RAM + 24 * SCREEN_ROW_LENGTH + $13 //13 
		// Dispari: Pieno
		lda #$04
		sta $0463 //1
		sta $0463+$50 //2
		sta $0463+$50+$50 //3
		sta $0463+$50+$50+$50 //4
		sta $0463+$50+$50+$50+$50 //5
		sta $0463+$50+$50+$50+$50+$50 //6
		sta $0463+$50+$50+$50+$50+$50+$50 //7
		sta $0463+$50+$50+$50+$50+$50+$50+$50 //8
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50 //9
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50 //10
		sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //11
		// sta $0463+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //12
		// sta SCREEN_RAM + 1 * SCREEN_ROW_LENGTH + $13 //1
		// sta SCREEN_RAM + 3 * SCREEN_ROW_LENGTH + $13 //2
		// sta SCREEN_RAM + 5 * SCREEN_ROW_LENGTH + $13 //3
		// sta SCREEN_RAM + 7 * SCREEN_ROW_LENGTH + $13 //4
		// sta SCREEN_RAM + 9 * SCREEN_ROW_LENGTH + $13 //5
		// sta SCREEN_RAM + 11 * SCREEN_ROW_LENGTH + $13 //6
		// sta SCREEN_RAM + 13 * SCREEN_ROW_LENGTH + $13 //7
		// sta SCREEN_RAM + 15 * SCREEN_ROW_LENGTH + $13 //8
		// sta SCREEN_RAM + 17 * SCREEN_ROW_LENGTH + $13 //9
		// sta SCREEN_RAM + 19 * SCREEN_ROW_LENGTH + $13 //10
		// sta SCREEN_RAM + 21 * SCREEN_ROW_LENGTH + $13 //11
		// sta SCREEN_RAM + 23 * SCREEN_ROW_LENGTH + $13 //12
		//sta SCREEN_RAM + 25 * SCREEN_ROW_LENGTH + $13 //13
		rts	
	}
}
