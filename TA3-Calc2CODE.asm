; **** Cabe?alho ****
	list p=16F877A

	#include P16F877A.inc
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC

;_CP_OFF	Recurso que protege a mem?ria de programa contra c?pias, eviata a engenharia reversa
;_WDT_OFF	Recurso que reinicia o uC caso o programa travar
;_PWRTE_ON 	Recurso que mantem o uC em Rest por 72ms ap?s a alimenta??o ser 
		;ligada, isso para que o oscilador tenha o tempo para se estabilizar 
;_XT_OSC	Cristal 1MHz a 4 MHZ ligado entre OS1 e OS0



      org 0x000 			; Origen del codigo

	bsf STATUS,RP0 			; Ir banco 1 
	bcf STATUS,RP1

	movlw b'11111111'	; PORTA como entrada move literal para w
	movwf TRISC			; move w para f
	movlw b'00000000'
	movwf TRISB

	bcf STATUS,RP0 			; Ir banco 0
	bcf STATUS,RP1
	
main  	  
	  movfw PORTC
	  addlw b'10'																																																									
	  movwf PORTB ; move de w para f 	
      goto  main

end
	
	