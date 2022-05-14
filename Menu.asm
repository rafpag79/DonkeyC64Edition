Menu: {
	Init: {
		
	   	rts
	}

	Draw: {		
			
		.for(var i=0;i<10;i++) {				
			lda TxtIstruzioni+i
			sta $0400+i
			
		}

		rts	

	}				
		
	    
}

TxtIstruzioni:
.text "Istruzioni"