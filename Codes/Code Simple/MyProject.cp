#line 1 "D:/Cse 331/Project/Codes/Code Simple/MyProject.c"

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




void main()
{
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 TRISB0_bit=1;
 TRISB4_bit=0;

 Lcd_Out(1,1,"CSE 331_SEC_02");
 Lcd_Out(2,1,"RSF");

 Delay_ms(5000);
 Lcd_Cmd(_LCD_CLEAR);

 while(1)
 {
 PORTB.F0 = 1;
 Delay_us(10);
 PORTB.F0 = 0;

 if(PORTB.F4 = 0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Samne Dekh Putki");
 Lcd_Out(2,1,"Mara Gelo");

 }
 else
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Beche Geli Mama");

 }
 Delay_ms(5000);
 }
}
