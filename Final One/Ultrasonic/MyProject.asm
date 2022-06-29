
_main:

;MyProject.c,18 :: 		void main()
;MyProject.c,22 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,23 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,24 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,26 :: 		TRISB = 0b00010000;           //RB4 as Input PIN (ECHO)
	MOVLW      16
	MOVWF      TRISB+0
;MyProject.c,27 :: 		TRISA = 0x00;                 //
	CLRF       TRISA+0
;MyProject.c,29 :: 		Lcd_Out(1,1,"CSE331 SEC-02");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,30 :: 		Lcd_Out(2,1,"RSF");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,32 :: 		Delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;MyProject.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,35 :: 		T1CON = 0x10;                 //Initialize Timer Module
	MOVLW      16
	MOVWF      T1CON+0
;MyProject.c,37 :: 		while(1)
L_main1:
;MyProject.c,39 :: 		TMR1H = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1H+0
;MyProject.c,40 :: 		TMR1L = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1L+0
;MyProject.c,42 :: 		PORTB.F0 = 1;               //TRIGGER HIGH
	BSF        PORTB+0, 0
;MyProject.c,43 :: 		Delay_us(10);               //10uS Delay
	MOVLW      6
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	NOP
;MyProject.c,44 :: 		PORTB.F0 = 0;               //TRIGGER LOW
	BCF        PORTB+0, 0
;MyProject.c,48 :: 		while(!PORTB.F4);           //Waiting for Echo
L_main4:
	BTFSC      PORTB+0, 4
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;MyProject.c,49 :: 		T1CON.F0 = 1;               //Timer Starts
	BSF        T1CON+0, 0
;MyProject.c,50 :: 		while(PORTB.F4);            //Waiting for Echo goes LOW
L_main6:
	BTFSS      PORTB+0, 4
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;MyProject.c,51 :: 		T1CON.F0 = 0;               //Timer Stops
	BCF        T1CON+0, 0
;MyProject.c,53 :: 		a = (TMR1L | (TMR1H<<8));   //Reads Timer Value
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;MyProject.c,54 :: 		a = a/58.82;                //Converts Time to Distance
	CALL       _Int2Double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;MyProject.c,55 :: 		a = a + 1;                  //Distance Calibration
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      main_a_L0+0
	MOVF       R2+1, 0
	MOVWF      main_a_L0+1
;MyProject.c,56 :: 		if(a>=2 && a<=100)          //Check whether the result is valid or not
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      2
	SUBWF      R2+0, 0
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main10
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVF       main_a_L0+0, 0
	SUBLW      100
L__main16:
	BTFSS      STATUS+0, 0
	GOTO       L_main10
L__main13:
;MyProject.c,58 :: 		IntToStr(a,txt);
	MOVF       main_a_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_a_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,59 :: 		Ltrim(txt);
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MyProject.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,61 :: 		Lcd_Out(1,1,"Obstacle");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,64 :: 		RA0_BIT = 1;
	BSF        RA0_bit+0, 0
;MyProject.c,65 :: 		}
	GOTO       L_main11
L_main10:
;MyProject.c,68 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,69 :: 		Lcd_Out(1,1,"Out of Range");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,70 :: 		RA0_BIT = 0;
	BCF        RA0_bit+0, 0
;MyProject.c,71 :: 		}
L_main11:
;MyProject.c,72 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
;MyProject.c,73 :: 		}
	GOTO       L_main1
;MyProject.c,74 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
