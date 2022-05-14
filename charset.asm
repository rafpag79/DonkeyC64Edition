

CharSet: {

	Copy: {
	// *** Step Init *** //
	// Interrupt Keyboard Off
	// lda #$fe
	// and $dc0e
	// Interrupt IO off
	// lda #$fb
	// and $01
	
	// *** Copy Src to Dst *** //	
	// @ $00 0   $d000-$d007  53248-53256,  8 bytes=1 carattere
	// A $01 1   18 3c 66 7e 66 66 66 0  $d008-$d010  53256-53264: 
	// B $02 2   7c 66 66 7c 66 66 7c 0  $d011-$d019               
	// C $03 3   3c 66 60 60 60 66 3c 0
	// D $04 4   78 6c 66 66 66 6c 78 0
	// E $05 5   7e 60 60 78 60 60 7e 0
	// F $06 6   7e 60 60 78 60 60 60 0
	// G $07 7   3c 66 60 6e 66 66 3c 0
	// H $08 8   66 66 66 7e 66 66 66 0
	// I $09 9   3c 18 18 18 18 18 3c 0
	// J $0a 10  1e c c c c 6c 38 0
	// K $0b 11  66 6c 78 70 78 6c 66 0
	// L $0c 12  60 60 60 60 60 60 7e 0
	// M $0d 13  63 77 7f 6b 63 63 63 0
	// N $0e 14  66 76 7e 7e 6e 66 66 0
	// O $0f 15  3c 66 66 66 66 66 3c 0
	// P $10 16  7c 66 66 7c 60 60 60 0
	// Q $11 17  3c 66 66 66 66 3c e 0
	// R $12 18  7c 66 66 7c 78 6c 66 0
	// S $13 19  3c 66 60 3c 6 66 3c 0
	// T $14 20  7e 18 18 18 18 18 18 0
	// U $15 21  66 66 66 66 66 66 3c 0
	// V $16 22  66 66 66 66 66 3c 18 0
	// W $17 23  63 63 63 6b 7f 77 63 0
	// X $18 24  66 66 3c 18 3c 66 66 0
	// Y $19 25  66 66 66 3c 18 18 18 0
	// Z $1a 26  7e 6 c 18 30 60 7e 0
// 122/$7A

	// Carattere Blank: @,  position 0
	lda #$00 // 0
	sta RAM_CHAR_BLANK+0
	lda #$00 // 1
	sta RAM_CHAR_BLANK+1
	lda #$00 // 2
	sta RAM_CHAR_BLANK+2
	lda #$00 // 3
	sta RAM_CHAR_BLANK+3
	lda #$00 // 4
	sta RAM_CHAR_BLANK+4
	lda #$00 // 5
	sta RAM_CHAR_BLANK+5
	lda #$00 // 6
	sta RAM_CHAR_BLANK+6
	lda #$00 // 7
	sta RAM_CHAR_BLANK+7

	// Carattere A : position 1
	// 18 3c 66 7e 66 66 66 0
	lda #$18 // 0
	sta RAM_CHAR_A+0
	lda #$3c // 1
	sta RAM_CHAR_A+1
	lda #$66 // 2
	sta RAM_CHAR_A+2
	lda #$7e // 3
	sta RAM_CHAR_A+3
	lda #$66 // 4
	sta RAM_CHAR_A+4
	lda #$66 // 5
	sta RAM_CHAR_A+5
	lda #$66 // 6
	sta RAM_CHAR_A+6
	lda #$00 // 7
	sta RAM_CHAR_A+7

	// Carattere B: position 2
	//7c 66 66 7c 66 66 7c 0 
	lda #$7c // 0
	sta RAM_CHAR_B+0
	lda #$66 // 1
	sta RAM_CHAR_B+1
	lda #$66 // 2
	sta RAM_CHAR_B+2
	lda #$7c // 3
	sta RAM_CHAR_B+3
	lda #$66 // 4
	sta RAM_CHAR_B+4
	lda #$66 // 5
	sta RAM_CHAR_B+5
	lda #$7c // 6
	sta RAM_CHAR_B+6
	lda #$00 // 7
	sta RAM_CHAR_B+7

	// Carattere C: position 3
	// 3c 66 60 60 60 66 3c 0
	lda #$3c // 0
	sta RAM_CHAR_C+0
	lda #$66 // 1
	sta RAM_CHAR_C+1
	lda #$60 // 2
	sta RAM_CHAR_C+2
	lda #$60 // 3
	sta RAM_CHAR_C+3
	lda #$60 // 4
	sta RAM_CHAR_C+4
	lda #$66 // 5
	sta RAM_CHAR_C+5
	lda #$3c // 6
	sta RAM_CHAR_C+6
	lda #$00 // 7
	sta RAM_CHAR_C+7

	// Carattere d: position 4
	// 78 6c 66 66 66 6c 78 0
	lda #$78 // 0
	sta RAM_CHAR_D+0
	lda #$6c // 1
	sta RAM_CHAR_D+1
	lda #$66 // 2
	sta RAM_CHAR_D+2
	lda #$66 // 3
	sta RAM_CHAR_D+3
	lda #$66 // 4
	sta RAM_CHAR_D+4
	lda #$6c // 5
	sta RAM_CHAR_D+5
	lda #$78 // 6
	sta RAM_CHAR_D+6
	lda #$00 // 7
	sta RAM_CHAR_D+7

	// Carattere E: position 4
	// 7e 60 60 78 60 60 7e 0
	lda #$7e // 0
	sta RAM_CHAR_E+0
	lda #$60 // 1
	sta RAM_CHAR_E+1
	lda #$60 // 2
	sta RAM_CHAR_E+2
	lda #$78 // 3
	sta RAM_CHAR_E+3
	lda #$60 // 4
	sta RAM_CHAR_E+4
	lda #$60 // 5
	sta RAM_CHAR_E+5
	lda #$7e // 6
	sta RAM_CHAR_E+6
	lda #$00 // 7
	sta RAM_CHAR_E+7

	// Carattere F: position 5
	// 7e 60 60 78 60 60 60 0
	lda #$7e // 0
	sta RAM_CHAR_F+0
	lda #$60 // 1
	sta RAM_CHAR_F+1
	lda #$60 // 2
	sta RAM_CHAR_F+2
	lda #$78 // 3
	sta RAM_CHAR_F+3
	lda #$60 // 4
	sta RAM_CHAR_F+4
	lda #$60 // 5
	sta RAM_CHAR_F+5
	lda #$60 // 6
	sta RAM_CHAR_F+6
	lda #$00 // 7
	sta RAM_CHAR_F+7

	// Carattere G: position 6
	// 3c 66 60 6e 66 66 3c 0
	lda #$3c // 0
	sta RAM_CHAR_G+0
	lda #$66 // 1
	sta RAM_CHAR_G+1
	lda #$60 // 2
	sta RAM_CHAR_G+2
	lda #$6e // 3
	sta RAM_CHAR_G+3
	lda #$66 // 4
	sta RAM_CHAR_G+4
	lda #$66 // 5
	sta RAM_CHAR_G+5
	lda #$3c // 6
	sta RAM_CHAR_G+6
	lda #$00 // 7
	sta RAM_CHAR_G+7

	// Carattere H: position 7
	// 66 66 66 7e 66 66 66 0
	lda #$66 // 0
	sta RAM_CHAR_H+0
	lda #$66 // 1
	sta RAM_CHAR_H+1
	lda #$66 // 2
	sta RAM_CHAR_H+2
	lda #$7e // 3
	sta RAM_CHAR_H+3
	lda #$66 // 4
	sta RAM_CHAR_H+4
	lda #$66 // 5
	sta RAM_CHAR_H+5
	lda #$66 // 6
	sta RAM_CHAR_H+6
	lda #$00 // 7
	sta RAM_CHAR_H+7

	// Carattere I: position 8
	// 3c 18 18 18 18 18 3c 0
	lda #$3c // 0
	sta RAM_CHAR_I+0
	lda #$18 // 1
	sta RAM_CHAR_I+1
	lda #$18 // 2
	sta RAM_CHAR_I+2
	lda #$18 // 3
	sta RAM_CHAR_I+3
	lda #$18 // 4
	sta RAM_CHAR_I+4
	lda #$18 // 5
	sta RAM_CHAR_I+5
	lda #$3c // 6
	sta RAM_CHAR_I+6
	lda #$00 // 7
	sta RAM_CHAR_I+7

	// Carattere : position 69
	// 0 ffffffff ffffffff 0 0 0 0 0
	lda #$ff // 0
	sta RAM_CHAR_69+0
	lda #$ff // 1
	sta RAM_CHAR_69+1
	lda #$00 // 2
	sta RAM_CHAR_69+2
	lda #$00 // 3
	sta RAM_CHAR_69+3
	lda #$00 // 4
	sta RAM_CHAR_69+4
	lda #$00 // 5
	sta RAM_CHAR_69+5
	lda #$00 // 6
	sta RAM_CHAR_69+6
	lda #$00 // 7
	sta RAM_CHAR_69+7

	// Carattere : position 79
	//  ffffffff ffffffff ffffffc0 ffffffc0 ffffffc0 ffffffc0 ffffffc0 ffffffc0
	lda #$ff // 0
	sta RAM_CHAR_79+0
	lda #$ff // 1
	sta RAM_CHAR_79+1
	lda #$c0 // 2
	sta RAM_CHAR_79+2
	lda #$c0 // 3
	sta RAM_CHAR_79+3
	lda #$c0 // 4
	sta RAM_CHAR_79+4
	lda #$c0 // 5
	sta RAM_CHAR_79+5
	lda #$c0 // 6
	sta RAM_CHAR_79+6
	lda #$c0 // 7
	sta RAM_CHAR_79+7

	// Carattere : position 80
	//  ffffffff ffffffff 3 3 3 3 3 3
	lda #$ff // 0
	sta RAM_CHAR_80+0
	lda #$ff // 1
	sta RAM_CHAR_80+1
	lda #$03 // 2
	sta RAM_CHAR_80+2
	lda #$03 // 3
	sta RAM_CHAR_80+3
	lda #$03 // 4
	sta RAM_CHAR_80+4
	lda #$03 // 5
	sta RAM_CHAR_80+5
	lda #$03 // 6
	sta RAM_CHAR_80+6
	lda #$03 // 7
	sta RAM_CHAR_80+7	

	// Carattere : position 122
	// 3 3 3 3 3 3 ffffffff ffffffff
	lda #$03 // 0
	sta RAM_CHAR_122+0
	lda #$03 // 1
	sta RAM_CHAR_122+1
	lda #$03 // 2
	sta RAM_CHAR_122+2
	lda #$03 // 3
	sta RAM_CHAR_122+3
	lda #$03 // 4
	sta RAM_CHAR_122+4
	lda #$03 // 5
	sta RAM_CHAR_122+5
	lda #$ff // 6
	sta RAM_CHAR_122+6
	lda #$ff // 7
	sta RAM_CHAR_122+7


	// x=26
	// 7e 6 c 18 30 60 7e 0


 // .break

	// lda $d002 // B
	// sta $3002

	// *** Step Fine *** //
	// Interrupt Keyboard Off
	// lda #$01
	// ora $dc0e
	// Interrupt IO off
	// lda #$04
	// ora $01

	rts
	}

}

