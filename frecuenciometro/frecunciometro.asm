
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;frecunciometro.c,25 :: 		void interrupt(void)  //ist
;frecunciometro.c,27 :: 		INTCON.GIE = 0; //Deshabilito todas las interrupciones
	BCF        INTCON+0, 7
;frecunciometro.c,28 :: 		if(INTCON.T0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;frecunciometro.c,30 :: 		INTCON.T0IF = 0; //Bajar la bandera
	BCF        INTCON+0, 2
;frecunciometro.c,31 :: 		PORTD=~PORTD;
	COMF       PORTD+0, 1
;frecunciometro.c,32 :: 		ctrl[0]++;
	INCF       _ctrl+0, 1
;frecunciometro.c,34 :: 		}
L_interrupt0:
;frecunciometro.c,35 :: 		INTCON.GIE = 1;//Habilito todas las interrupciones
	BSF        INTCON+0, 7
;frecunciometro.c,36 :: 		}
L_end_interrupt:
L__interrupt12:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;frecunciometro.c,39 :: 		int main(void)
;frecunciometro.c,41 :: 		TRISB=0x00;
	CLRF       TRISB+0
;frecunciometro.c,42 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;frecunciometro.c,43 :: 		PORTA  = 0x00;
	CLRF       PORTA+0
;frecunciometro.c,44 :: 		ANSELH = 0x00;
	CLRF       ANSELH+0
;frecunciometro.c,45 :: 		TRISD  = 0x00;
	CLRF       TRISD+0
;frecunciometro.c,46 :: 		PORTD  = 0x00;
	CLRF       PORTD+0
;frecunciometro.c,47 :: 		OPTION_REG = 0x27;
	MOVLW      39
	MOVWF      OPTION_REG+0
;frecunciometro.c,48 :: 		INTCON =   0xA0;
	MOVLW      160
	MOVWF      INTCON+0
;frecunciometro.c,49 :: 		TMR0   = 0x00;
	CLRF       TMR0+0
;frecunciometro.c,50 :: 		OPTION_REG.T0CS = 0; //HABILITO EL TIMER
	BCF        OPTION_REG+0, 5
;frecunciometro.c,52 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;frecunciometro.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;frecunciometro.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;frecunciometro.c,55 :: 		Lcd_Out(2,5,"FRECUENCIA:");                 // Write text in second row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      70
	MOVWF      ?lstr1_frecunciometro+0
	MOVLW      82
	MOVWF      ?lstr1_frecunciometro+1
	MOVLW      69
	MOVWF      ?lstr1_frecunciometro+2
	MOVLW      67
	MOVWF      ?lstr1_frecunciometro+3
	MOVLW      85
	MOVWF      ?lstr1_frecunciometro+4
	MOVLW      69
	MOVWF      ?lstr1_frecunciometro+5
	MOVLW      78
	MOVWF      ?lstr1_frecunciometro+6
	MOVLW      67
	MOVWF      ?lstr1_frecunciometro+7
	MOVLW      73
	MOVWF      ?lstr1_frecunciometro+8
	MOVLW      65
	MOVWF      ?lstr1_frecunciometro+9
	MOVLW      58
	MOVWF      ?lstr1_frecunciometro+10
	CLRF       ?lstr1_frecunciometro+11
	MOVLW      ?lstr1_frecunciometro+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;frecunciometro.c,57 :: 		while(1)
L_main1:
;frecunciometro.c,59 :: 		if (RA4_bit==1 && ctrl[1]==0)
	BTFSS      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main5
	MOVF       _ctrl+1, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main5
L__main10:
;frecunciometro.c,61 :: 		frecuencia++;
	INCF       _frecuencia+0, 1
	BTFSC      STATUS+0, 2
	INCF       _frecuencia+1, 1
;frecunciometro.c,62 :: 		RB1_bit=1;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;frecunciometro.c,63 :: 		ctrl[1]=1;
	MOVLW      1
	MOVWF      _ctrl+1
;frecunciometro.c,64 :: 		}
L_main5:
;frecunciometro.c,65 :: 		if (RA4_bit==0){
	BTFSC      RA4_bit+0, BitPos(RA4_bit+0)
	GOTO       L_main6
;frecunciometro.c,66 :: 		ctrl[1]=0;
	CLRF       _ctrl+1
;frecunciometro.c,67 :: 		RB1_bit=0;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;frecunciometro.c,68 :: 		}
L_main6:
;frecunciometro.c,71 :: 		if (ctrl[0]==4)
	MOVF       _ctrl+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;frecunciometro.c,73 :: 		ctrl[0]=0;
	CLRF       _ctrl+0
;frecunciometro.c,74 :: 		printf=1;
	MOVLW      1
	MOVWF      _printf+0
;frecunciometro.c,75 :: 		RB0_bit=0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;frecunciometro.c,76 :: 		}else {RB0_bit=0x00;}
	GOTO       L_main8
L_main7:
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
L_main8:
;frecunciometro.c,77 :: 		if (printf==1)
	MOVF       _printf+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;frecunciometro.c,79 :: 		IntToStr(frecuencia, text);
	MOVF       _frecuencia+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _frecuencia+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;frecunciometro.c,80 :: 		Lcd_Out(3,5,text);
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _text+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;frecunciometro.c,81 :: 		Lcd_Out_CP("HZ");
	MOVLW      72
	MOVWF      ?lstr2_frecunciometro+0
	MOVLW      90
	MOVWF      ?lstr2_frecunciometro+1
	CLRF       ?lstr2_frecunciometro+2
	MOVLW      ?lstr2_frecunciometro+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;frecunciometro.c,82 :: 		return -1;
	MOVLW      255
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R0+1
	GOTO       L_end_main
;frecunciometro.c,83 :: 		}
L_main9:
;frecunciometro.c,84 :: 		}
	GOTO       L_main1
;frecunciometro.c,85 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
