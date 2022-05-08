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

		// Pari: Pieno
		lda #$04	
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
		
		//***Color RAM***//
		lda #$01

		sta $d83b
		sta $d88b //2 +$50
		sta $d8db //3
		sta $d92b //4
		sta $d97b //5
		sta $d9cb //6
		sta $da1b //7
		sta $da6b //8
		sta $dabb //9
		sta $db0b //10
		sta $db5b //11
		sta $dbab //12

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
		
		//***Color RAM***//
		lda #$01
		
		sta $d863 //1
		sta $d863+$50 //2
		sta $d863+$50+$50 //3
		sta $d863+$50+$50+$50 //4
		sta $d863+$50+$50+$50+$50 //5
		sta $d863+$50+$50+$50+$50+$50 //6
		sta $d863+$50+$50+$50+$50+$50+$50 //7
		sta $d863+$50+$50+$50+$50+$50+$50+$50 //8
		sta $d863+$50+$50+$50+$50+$50+$50+$50+$50 //9
		sta $d863+$50+$50+$50+$50+$50+$50+$50+$50+$50 //10
		sta $d863+$50+$50+$50+$50+$50+$50+$50+$50+$50+$50 //11


		rts	
	}
}
