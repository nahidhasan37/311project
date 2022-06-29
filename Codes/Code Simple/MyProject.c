// LCD module connections
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
// End LCD module connections

//sbit BUZZER at RB6_bit;

void main()
{
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);          // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);     // Cursor off

  TRISB0_bit=1;                 //Set RB0 as input
  TRISB4_bit=0;                 //Set RB4 as output

  Lcd_Out(1,1,"CSE 331_SEC_02");
  Lcd_Out(2,1,"RSF");

  Delay_ms(5000);
  Lcd_Cmd(_LCD_CLEAR);

  while(1)
  {
    PORTB.F0 = 1;               //TRIGGER HIGH
    Delay_us(10);               //10uS Delay for the wave to generate
    PORTB.F0 = 0;               //TRIGGER LOW

    if(PORTB.F4 = 0)          //Check if the ECHO is off(meaning) wave has recieved
    {
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1,1,"Samne Dekh Putki");
      Lcd_Out(2,1,"Mara Gelo");
//      PORTB.F4 = 0;
    }
    else
    {
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_Out(1,1,"Beche Geli Mama");
//      PORTB.F4 = 1;
    }
    Delay_ms(5000);
  }
}