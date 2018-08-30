
; **** Cabe?alho ****
	list p=16F877A

	#include P16F877A.inc
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC

;_CP_OFF	Recurso que protege a mem?ria de programa contra c?pias, eviata a engenharia reversa
;_WDT_OFF	Recurso que reinicia o uC caso o programa travar
;_PWRTE_ON 	Recurso que mantem o uC em Rest por 72ms ap?s a alimenta??o ser 
		;ligada, isso para que o oscilador tenha o tempo para se estabilizar 
;_XT_OSC	Cristal 1MHz a 4 MHZ ligado entre OS1 e OS0



;**** Configuracion de puertos ***
	org 0x000 			; Origen del codigo

	bsf STATUS,RP0 			; Ir banco 1	
	bcf STATUS,RP1
	movlw b'00000111' 		; PORTC como entrada
	movwf TRISD
	movlw b'11111110'
	movwf TRISB
	bcf STATUS,RP0 			; Ir banco 0
	bcf STATUS,RP1

	movlw 0x0000
	movwf PORTD

BUCLE
	movf PORTD,W 
	addlw d'250'			;6
	BTFSC STATUS, Z
	call acende	

	movf PORTD,W 
	addlw d'251'		;5
	BTFSC STATUS, Z
	call acende

	movf PORTD,W 
	addlw d'253'		;3
	BTFSC STATUS, Z
	call acende



	bcf PORTB,0	
	goto BUCLE 			; Ir bucle


acende
	bsf PORTB,0
	goto BUCLE

	END 				; Fin del programa