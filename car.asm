Car: {
	
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
	beq carSpeedMatchYes
	
	lda #$20
	cmp FrameCounter
	beq carSpeedMatchYes
	
	lda #$40
	cmp FrameCounter
	beq carSpeedMatchYes
	
	lda #$60
	cmp FrameCounter
	beq carSpeedMatchYes

	lda #$80
	cmp FrameCounter
	beq carSpeedMatchYes

	lda #$a0
	cmp FrameCounter
	beq carSpeedMatchYes

	lda #$c0
	cmp FrameCounter
	beq carSpeedMatchYes

	lda #$e0
	cmp FrameCounter
	beq carSpeedMatchYes

carSpeedMatchNo:
	rts

carSpeedMatchYes:
	
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
			// lda #$00 //delete key from array
			// sta KeyCapturedArray, x
			jsr Keyboard.Reset
			jmp !change+
		!exit:
			rts

		!change:
			lda CarLane
			cmp #CAR_LANE_LEFT
			beq !changeLaneToRight+
			cmp #CAR_LANE_RIGHT
			beq !changeLaneToLeft+
			rts		
		!changeLaneToRight:
			lda #CAR_LANE_RIGHT
			sta CarLane
			rts
		!changeLaneToLeft:
			lda #CAR_LANE_LEFT
			sta CarLane
			rts
	}

	Draw: {
		// *** Sprite: Color *** //
		lda #$02      // sprite colore
        sta SPRITE_0_COLOR   //$d027  //53287-53248=39
        lda #$04      // sprite colore
        sta SPRITE_1_COLOR   //$d027  //53287-53248=39
        lda #$05      // sprite colore
        sta SPRITE_2_COLOR   //$d027  //53287-53248=39
        lda #$06      // sprite colore
        sta SPRITE_3_COLOR   //$d027  //53287-53248=39
        
        // lda #$01         
        // sta SPRITE_MC_COLOR_1 //$d025   //53285-53248=37  // mc color 1
        // lda #$02           
        // sta SPRITE_MC_COLOR_2 //$d026 //53286-53248=    // mc color 2

        // *** Ptr *** //
        //lda #$c0      // locazione data: 192*64=12288
        lda #SPRITE_0_PTR_VAL //240*64=15360  $3C00
        sta SPRITE_0_PTR //$07f8  //$07f8=2040
        lda #SPRITE_1_PTR_VAL  //*64
        sta SPRITE_1_PTR //$07f8  //$07f8=2040
        lda #SPRITE_2_PTR_VAL  
        sta SPRITE_2_PTR //$07f8  //$07f8=2040
        lda #SPRITE_3_PTR_VAL  
        sta SPRITE_3_PTR //$07f8  //$07f8=2040

        // *** Position LEFT X *** //
        lda CarLane
        cmp #CAR_LANE_RIGHT
        beq !right+        
        cmp #CAR_LANE_LEFT
        beq !left+        

    !left:
        lda #ROAD_POSITION_LEFT
        sta SPRITE_0_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_LEFT+$18
        sta SPRITE_1_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_LEFT
        sta SPRITE_2_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_LEFT+$18
        sta SPRITE_3_POSITION_LEFT_X   // x    
        jmp !continue+

    !right:
        lda #ROAD_POSITION_RIGHT
        sta SPRITE_0_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_RIGHT+$18
        sta SPRITE_1_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_RIGHT
        sta SPRITE_2_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_RIGHT+$18
        sta SPRITE_3_POSITION_LEFT_X   // x    
        jmp !continue+

    !continue:
        // *** Position Y *** //
        lda #$af        
        sta SPRITE_0_POSITION_Y   //$d001=53249  // y
        lda #$af
        sta SPRITE_1_POSITION_Y   //$d001=53249  // y
        lda #$af+$15
        sta SPRITE_2_POSITION_Y   //$d001=53249  // y
        lda #$af+$15
        sta SPRITE_3_POSITION_Y   //$d001=53249  // y
        
        // *** Position RIGHT Y *** //
        lda #0 //#%11111111        
        sta SPRITE_0_POSITION_RIGHT_X_ENABLE
        // sta SPRITE_1_POSITION_RIGHT_X_ENABLE
        
        rts
	}	

	CopyCar0: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCar0, x
			sta SPRITE_PTR_BASE, x
			dex
			bne !Loop-
		rts
	}
	CopyCar1: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCar1, x
			sta SPRITE_PTR_BASE+$40, x
			dex
			bne !Loop-
		rts
	}
	CopyCar2: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCar2, x
			sta SPRITE_PTR_BASE+$40+$40, x
			dex
			bne !Loop-
		rts
	}
	CopyCar3: {
		ldx #$40
		!Loop:
			lda SPRITES.SpriteCar3, x
			sta SPRITE_PTR_BASE+$40+$40+$40, x
			dex
			bne !Loop-
		rts
	}
}

