.label SCREEN_RAM = $0400
.label SCREEN_ROW_LENGTH = $28 //40
.label COLOR_RAM  = $d800
.label VIC = $d000 //53248
.label SPRITE_ENABLE = VIC+21
.label SPRITE_MC_MODE_ENABLE = VIC+28
.label SPRITE_MC_COLOR_1 = VIC+37
.label SPRITE_MC_COLOR_2 = VIC+38
.label SPRITE_0_PTR = $07f8 //2040
.label SPRITE_1_PTR = $07f9 //2041
.label SPRITE_2_PTR = $07fa //2042
.label SPRITE_3_PTR = $07fb //2043
.label SPRITE_4_PTR = $07fc //2044
.label SPRITE_5_PTR = $07fd //2045
.label SPRITE_0_PTR_VAL = $f0 //240
.label SPRITE_1_PTR_VAL = $f1 //241
.label SPRITE_2_PTR_VAL = $f2 //242
.label SPRITE_3_PTR_VAL = $f3 //243
.label SPRITE_4_PTR_VAL = $f4 //244
.label SPRITE_5_PTR_VAL = $f5 //245
.label SPRITE_PTR_BASE = $3c00 //240
// *** Color *** //
.label SPRITE_0_COLOR = VIC+39
.label SPRITE_1_COLOR = VIC+40
.label SPRITE_2_COLOR = VIC+41
.label SPRITE_3_COLOR = VIC+42
.label SPRITE_4_COLOR = VIC+43
.label SPRITE_5_COLOR = VIC+44
// *** Position RIGHT X *** //
.label SPRITE_0_POSITION_RIGHT_X_ENABLE = VIC+16
.label SPRITE_1_POSITION_RIGHT_X_ENABLE = VIC+17
.label SPRITE_2_POSITION_RIGHT_X_ENABLE = VIC+18
.label SPRITE_3_POSITION_RIGHT_X_ENABLE = VIC+19
.label SPRITE_4_POSITION_RIGHT_X_ENABLE = VIC+20
.label SPRITE_5_POSITION_RIGHT_X_ENABLE = VIC+21
// *** Position LEFT X *** //
.label SPRITE_0_POSITION_LEFT_X = VIC+0
.label SPRITE_1_POSITION_LEFT_X = VIC+2
.label SPRITE_2_POSITION_LEFT_X = VIC+4
.label SPRITE_3_POSITION_LEFT_X = VIC+6
.label SPRITE_4_POSITION_LEFT_X = VIC+8
.label SPRITE_5_POSITION_LEFT_X = VIC+10
// *** Position Y *** //
.label SPRITE_0_POSITION_Y = VIC+1
.label SPRITE_1_POSITION_Y = VIC+3
.label SPRITE_2_POSITION_Y = VIC+5
.label SPRITE_3_POSITION_Y = VIC+7
.label SPRITE_4_POSITION_Y = VIC+9
.label SPRITE_5_POSITION_Y = VIC+11
// *** Road *** //
.label ROAD_PARI = $01
.label ROAD_DISPARI = $02
.label ROAD_POSITION_LEFT = $80
.label ROAD_POSITION_RIGHT = $b8
.label ROAD_POSITION_RIGHT2 = $b8+$18
.label CAR_LANE_LEFT = $01
.label CAR_LANE_RIGHT = $02
// *** Keyboard *** //
.label KEYBOARD_DR_PORT_A_COL = $dc00
.label KEYBOARD_DR_PORT_A_ROW = $dc01
.label KEYBOARD_DDR_PORT_A_ROW = $dc02
.label KEYBOARD_DDR_PORT_A_COL = $dc03
.label KEYBOARD_BUFFER_BEGIN = $277
.label KEYBOARD_BUFFER_END = $280

// *=$0801
BasicUpstart2(Entry)

Entry: // $080e
	sei
		// Disable Kernal and Basic
		// lda #$35
		// sta $01

		// Timer Enable
		// $dc0d
		// $dd0d
		lda $7f // %01111111
		sta $dc0d
		sta $dd0d

		//Select Vic Bank
		// Vic Bank $0000-$3fff = 16K, Bank 0 Default
		// Registro: $dd00 56576

		//Screen Memory Location
		// Registro: $d018 53272: bits 7,6,5,4
		// relative to Vic Bank $dd00
		// UPPER 4 bits; bits 0,1,2,3 %0001XXXX: $0400-  default

		//Character Memory Location
		// Register: $d018 53272 = 12: bits 3,2,1
		// Location Rom $1000-$17FF e $1800-$1FFF
		// Location: XXXX001X = $0800-$0FFF
		// Location Ram: $3000 12288 default
		// 1 Character = 8 bytes (pattern)
		// 1 Character Set = 256 * 8 bytes = 2K
		lda #%00011100
		sta $d018

		// *** Sprites ***
		lda #%11111111      //sprite on
        sta SPRITE_ENABLE //$d015 //53248 53269 = 21
		
		lda #$00      //mc mode=off
        sta SPRITE_MC_MODE_ENABLE //$d01c  //53276-53248=28 

	cli

	lda #$0c
	sta $d020

	lda #$0b
	sta $d021
	
	jsr ClearScreen

	// *** Copy *** //
	jsr Car.CopyCar0
	jsr Car.CopyCar1
	jsr Car.CopyCar2
	jsr Car.CopyCar3	
	jsr Cow.CopyCow0
	jsr Cow.CopyCow1
	
	jsr Map.Draw

	// *** Init *** //
	jsr Cow.Init

gameLoop:
		jsr WaitRaster		
		jsr Keyboard.KeyScan

		// *** Update *** //
		jsr Road.Update
		jsr Cow.Update
		jsr Car.Update		

		// *** Draw *** //
		jsr Road.Draw
		jsr Cow.Draw
		jsr Car.Draw

		inc FrameCounter
		jmp gameLoop
		rts

WaitRaster: {
	!loop:
		lda #$ff                 // Scanline -> A
    	cmp $d012              // Compare A to current raster line
    	bne !loop-               // Loop if raster line not reached 255
    	rts
}

ClearScreen: {
		lda #$00
        ldx #$00
    !:
        sta SCREEN_RAM, x
        sta SCREEN_RAM + $100, x
        sta SCREEN_RAM + $200, x
        sta SCREEN_RAM + $300, x
        dex
        bne !-
        rts
}

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
		sta KeyCaptured

		// *** Store Array *** //
				
		ldx KeyCapturedIndex
		sta KeyCapturedArray, x		
		cpx #$20
		beq !resetIndex+
		bne !exit+
	!resetIndex:
		ldx #$00
		stx KeyCapturedIndex		
	//.break
		ldx #$00
	!resetArray:		
		lda #$00
		sta KeyCapturedArray, x
		
		cpx #$20
		inx
		bne !resetArray-

		rts

	!exit:
		inc KeyCapturedIndex
		rts
	}

}

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
	 .break
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
		.break
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
		.break
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

Map: {
	Draw: {
		ldx #$00		
		!loop:
			lda MAP, x
			sta SCREEN_RAM, x
			lda #$03
			sta COLOR_RAM, x
					
			lda MAP+$100, x
			sta SCREEN_RAM+$100, x
			lda #$03
			sta COLOR_RAM+$100, x

			lda MAP+$200, x
			sta SCREEN_RAM+$200, x
			lda #$03
			sta COLOR_RAM+$200, x

			lda MAP+$300, x
			sta SCREEN_RAM+$300, x
			lda #$03
			sta COLOR_RAM+$300, x
			inx
			bne !loop-
					
		!exit:
	    	rts
	}
}

Car: {
	Update: {
		// *** Change Lane *** //
		 
			ldx #$00
		!next:
			lda KeyCapturedArray, x
			cmp #%10111111
			beq !trovato+

			cpx #$20			
			beq !exit+

			dex
			jmp !next-
		!trovato:
			// jsr Keyboard.Reset
			jmp !change+
		!exit:
			 // lda KeyCaptured
			 // cmp #%10111111
			 // beq !change+
			rts

		!change:
			// Reset FrameKey
			// lda $00
			// sta FrameKey

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
        lda #$3f        
        sta SPRITE_0_POSITION_Y   //$d001=53249  // y
        lda #$3f
        sta SPRITE_1_POSITION_Y   //$d001=53249  // y
        lda #$3f+$15
        sta SPRITE_2_POSITION_Y   //$d001=53249  // y
        lda #$3f+$15
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

Cow: {
	Init: {
		lda #$00
		sta	CowPositionY
	}

	Update: {

		//Speed Delay
		.for(var i=0;i<16;i++) {
			// lda #i
			// sta $0400
			lda #$10 * i
			cmp FrameCounter
			//bne !roadSpeedMatchNo+
			beq !cowSpeedMatchYes+
		}	
		!cowSpeedMatchNo:
			rts		
		!cowSpeedMatchYes:

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
        lda CarLane
        cmp #CAR_LANE_LEFT
        beq !drawCarToLaneLeft+
        cmp #CAR_LANE_RIGHT
        beq !drawCarToLaneRight+

    !drawCarToLaneLeft:
    	lda #ROAD_POSITION_LEFT+$00
        sta SPRITE_4_POSITION_LEFT_X   // x
        lda #ROAD_POSITION_LEFT+$18
        sta SPRITE_5_POSITION_LEFT_X   // x
        jmp !skip+

    !drawCarToLaneRight:
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

KeyCapturedIndex:
	.byte $00
KeyCapturedArray:
		//  1   2   3   4   5   6   7   8   9  10
	//.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.fill 32, $00
KeyCaptured:
	.byte $00
FrameKey:
	.byte $00
FrameCounter:
	.byte $00
CowPositionY:
	.byte $00
// CarPositionX:
	// .byte CAR_POSITION_RIGHT
CarLane:
	.byte CAR_LANE_LEFT
RoadSpeed:
	.byte $10
RoadPariOrDispari:
	.byte $01
RoadSpeedArray:
   //      0    1    2   3   4    5    6
 // .byte   0,  32,  64,  96, 128, 160, 192 
	.byte $00, $20, $40, $60, $80, $a0, $c0
	//.fill 64, $00
RoadSpeedArraySize:
	.byte $07
RoadSpeedArrayIndexFound:
	.byte $00	
TempMapColor:
	.byte $00

//*=$0400
MAP:
    .import binary "./map.bin"
MAP_COLORS:
    .import binary "./colors.bin"
// *=$0380 "Sprites Data"
SPRITES: {	
	// .import binary "./sprites.bin"
	//16*4=64 $40
	SpriteCar0:	
		.byte $00,$00,$07,$00,$00,$0f,$00,$00,$0f,$00,$00,$0f,$00,$00,$1f,$00
		.byte $00,$1f,$00,$00,$1f,$00,$00,$1f,$00,$07,$1f,$00,$07,$1f,$00,$07
		.byte $7f,$00,$07,$7f,$00,$07,$7f,$00,$07,$1f,$00,$07,$1f,$00,$00,$1f
		.byte $00,$00,$1f,$00,$00,$1c,$00,$00,$1b,$00,$00,$17,$00,$00,$17,$01
	SpriteCar1:
		.byte $e0,$00,$00,$f0,$00,$00,$f0,$00,$00,$f0,$00,$00,$f8,$00,$00,$f8
		.byte $00,$00,$f8,$00,$00,$f8,$00,$00,$f8,$e0,$00,$f8,$e0,$00,$fe,$e0
		.byte $00,$fe,$e0,$00,$fe,$e0,$00,$f8,$e0,$00,$f8,$e0,$00,$f8,$00,$00
		.byte $f8,$00,$00,$38,$00,$00,$d8,$00,$00,$e8,$00,$00,$e8,$00,$00,$01
	SpriteCar2:
		.byte $00,$00,$17,$00,$00,$17,$00,$00,$10,$00,$1f,$1f,$00,$1f,$11,$00
		.byte $1f,$15,$00,$1f,$11,$00,$1f,$7f,$00,$1f,$71,$00,$1f,$75,$00,$1f
		.byte $11,$00,$1f,$1f,$00,$1f,$11,$00,$1f,$15,$00,$1f,$11,$00,$00,$1f
		.byte $00,$00,$1f,$00,$00,$0f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
	SpriteCar3:
		.byte $e8,$00,$00,$e8,$00,$00,$08,$00,$00,$f8,$f8,$00,$88,$f8,$00,$a8
		.byte $f8,$00,$88,$f8,$00,$fe,$f8,$00,$8e,$f8,$00,$ae,$f8,$00,$88,$f8
		.byte $00,$f8,$f8,$00,$88,$f8,$00,$a8,$f8,$00,$88,$f8,$00,$f8,$00,$00
		.byte $f8,$00,$00,$f0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
	SpriteCow0:
		.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
		.byte $00,$00,$00,$03,$ff,$00,$07,$ff,$00,$07,$ff,$00,$0f,$ff,$00,$0f
		.byte $ff,$00,$1b,$ff,$00,$33,$ff,$00,$33,$ff,$00,$23,$bf,$00,$03,$b8
		.byte $00,$03,$b8,$00,$03,$b8,$00,$03,$b8,$00,$00,$00,$00,$00,$00,$01
	SpriteCow1:
		.byte $00,$00,$00,$00,$00,$00,$00,$82,$00,$00,$cc,$00,$00,$f8,$00,$01
		.byte $f8,$00,$ff,$b4,$00,$ff,$b4,$00,$ff,$fc,$00,$ff,$dc,$00,$ff,$dc
		.byte $00,$ff,$8c,$00,$ff,$88,$00,$ff,$80,$00,$fb,$80,$00,$3b,$80,$00
		.byte $3b,$80,$00,$3b,$80,$00,$3b,$80,$00,$00,$00,$00,$00,$00,$00,$01
}

*=$3000 "CharSet"
CHARSET:
	 .import binary "./chars.bin"
