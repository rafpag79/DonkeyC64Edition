Donkey: {
	
	Init: {
		lda #$00
		sta	CowPositionY
	}

	Update: {

				// *** Speed Match *** //
	lda #$00
	cmp FrameCounter
	beq cowSpeedMatchYes
	
	lda #$20
	cmp FrameCounter
	beq cowSpeedMatchYes
	
	lda #$40
	cmp FrameCounter
	beq cowSpeedMatchYes
	
	lda #$60
	cmp FrameCounter
	beq cowSpeedMatchYes

	lda #$80
	cmp FrameCounter
	beq cowSpeedMatchYes

	lda #$a0
	cmp FrameCounter
	beq cowSpeedMatchYes

	lda #$c0
	cmp FrameCounter
	beq cowSpeedMatchYes

	lda #$e0
	cmp FrameCounter
	beq cowSpeedMatchYes


	cowSpeedMatchNo:
			rts		
	cowSpeedMatchYes:

			inc CowPositionY
			lda	CowPositionY
			cmp #$25
			beq !reset+
			bne !exit+
		!exit:
			rts
		!reset:
			lda #$00
			sta	CowPositionY        
			rts
	}
	Draw: {
		
		// *** Sprite: Color *** //
		lda #$0d    
        sta SPRITE_4_COLOR   
        lda #$0e    
        sta SPRITE_5_COLOR

        // *** Ptr *** //        
        lda #SPRITE_4_PTR_VAL  //252*64=16128  $3F00
        sta SPRITE_4_PTR //$07f8  //$07f8=2040
        lda #SPRITE_5_PTR_VAL //*64
        sta SPRITE_5_PTR //$07f8  //$07f8=2040   

        // Lane
        // *** Position LEFT X *** //
        lda CowLane
        cmp #CAR_LANE_LEFT
        beq !drawCowToLaneLeft+
        cmp #CAR_LANE_RIGHT
        beq !drawCowToLaneRight+

    !drawCowToLaneLeft:
    	lda #ROAD_POSITION_LEFT+$00
        sta SPRITE_4_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_LEFT+$18
        sta SPRITE_5_POSITION_LEFT_X   // x
        jmp !skip+

    !drawCowToLaneRight:
        lda #ROAD_POSITION_RIGHT+$00
        sta SPRITE_4_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_RIGHT+$18
        sta SPRITE_5_POSITION_LEFT_X   // x        

    !skip:

         // *** Position Y *** //
        // lda #$3f+$40  
        //.break      
        lda CowPositionY
        asl //*2
        asl //*4
        asl //*8
        sta SPRITE_4_POSITION_Y   
        //lda #$3f+$40
        sta SPRITE_5_POSITION_Y   
	}

	CopyCow0: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCow0, x			
			sta SPRITE_PTR_BASE+$40+$40+$40+$40, x
			dex
			bne !Loop-
		rts
	}

	CopyCow1: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCow1, x
			sta SPRITE_PTR_BASE+$40+$40+$40+$40+$40, x
			dex
			bne !Loop-
		rts
	}
}
