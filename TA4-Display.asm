	list p=16F877A

	#include P16F877A.inc
	__CONFIG   _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC

#DEFINE		sum		PORTC,0
#DEFINE		sub		PORTC,1

;**** Configuracion de puertos ***
	org 0x000 			; Origen del codigo
	
	bsf STATUS,RP0 			; Ir banco 1	
	bcf STATUS,RP1

	movlw b'00000011' 		
	movwf TRISC
	movlw b'00000000'	
	movwf TRISB
	movlw b'00000000'		
	movwf TRISD

	bcf STATUS,RP0 			; Ir banco 0
	bcf STATUS,RP1	

	movlw 0x0000	
	movwf PORTB
	movlw 0x0000
	movwf PORTD


main
	BTFSS sum	
	call aumenta	
			 
	BTFSS sub
	call diminui	

	goto main			
			
aumenta
	call delay 

	movf PORTB, W
	addlw d'247'
	BTFSC STATUS, Z
	call aumentaD

	movf PORTB, W 
	addlw b'01'	
	movwf PORTB
return

diminui
	call delay
	
	movf PORTB, W
	addlw 0x0000
	BTFSC STATUS, Z
	call diminuiD

	movf PORTB, W
	addlw d'255'  
	movwf PORTB
return

aumentaD
	call delay
	movlw 0x0000 
	movwf PORTB

	movf PORTD, W
	addlw d'247'
	BTFSC STATUS, Z
	call zerandoa

	movf PORTD, W
	addlw b'01'
	movwf PORTD
goto main

zerandoa
	call delay
	movlw 0x0000
	movwf PORTB
	movlw d'255'
	movwf PORTD
return

diminuiD
	call delay
	movlw b'1001' 
	movwf PORTB	

	movf PORTD, W
	addlw 0x0000
	BTFSC STATUS, Z
	call zerandob

	movf PORTD, W
	addlw d'255'  
	movwf PORTD
goto main

zerandob
	call delay
	movlw b'1001'
	movwf PORTB
	movlw b'1010'
	movwf PORTD
return

delay
		movlw d'200'
		movwf 0x0C

aux1:
		movlw d'250'
		movwf 0x0D

aux2:
		nop			
		
		decfsz 0x0D
		goto aux2
		decfsz 0x0C
		goto aux1

return

END 