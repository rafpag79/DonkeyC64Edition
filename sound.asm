
Sound: {
	
    Reset: {
        lda #0
        sta S
        sta S+1
        sta S+2
        sta S+3
        sta S+4
        sta S+5
        sta S+6
        sta S+7
        sta S+8
        sta S+9
        sta S+10
        sta S+11
        sta S+12
        sta S+13
        sta S+14
        sta S+15
        sta S+16
        sta S+17
        sta S+18
        sta S+19
        sta S+20
        sta S+21
        sta S+22
        sta S+23
        sta S+24
    }

    Init: {
        lda #9
        sta S+5

        lda #0
        sta S+6

        // Volume
        lda #15
        sta S+24
    }

    Play: {
        // Play a Note
        lda #25
        sta S+1 

        lda #177
        sta S

        lda #33
        sta S+4

       
    	rts
    }
}