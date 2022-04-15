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
.label CAR_SPEED = $20 //32 decimal
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
	
	jsr Map.Init

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
	!returnBasic:
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

#import "./keyboard.asm"
#import "./cow.asm"
#import "./road.asm"
#import "./car.asm"
#import "./levelZero.asm"

KeyCapturedIndexEnd:
	.byte $00
KeyCapturedArray:
		//  1   2   3   4   5   6   7   8   9  10
	//.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.fill 255, $00
// KeyCaptured:
	// .byte $00
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
// CarSpeed:
	// .byte $10
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
