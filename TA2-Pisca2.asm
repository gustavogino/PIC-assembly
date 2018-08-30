list p=16F877A

	#include P16F877A.inc
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC


;**** Configuracion de puertos ***
	org 0x000 			; Origen del codigo

	bsf STATUS,RP0 			; Ir banco 1	
	bcf STATUS,RP1

	movlw b'11111111' 		; PORTC como entrada
	movwf TRISC
	movlw b'00000000'
	movwf TRISB
	bcf STATUS,RP0 			; Ir banco 0
	bcf STATUS,RP1

main
	
	movlw b'1'
	movwf PORTB 
	call delay
	movfw PORTC
	BTFSC STATUS, Z
	call brilha
	movlw b'0'
	movwf PORTB
	call delay
	goto main			

brilha
	movlw b'1'
	movwf PORTB
	goto main

delay
		movlw d'200'
		movwf 0x0C

aux1:
		movlw d'250'
		movwf 0x0D

aux2:
		nop
		nop
		nop
		nop				
		nop
		nop
		nop
		
		decfsz 0x0D
		goto aux2
		decfsz 0x0C
		goto aux1

return

END 