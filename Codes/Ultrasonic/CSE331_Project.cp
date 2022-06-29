#line 1 "D:/Tushar Faroque/Fall-19/CSE331(RSF)/Project/Codes/Ultrasonic/CSE331_Project.c"
#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config BOREN = ON
#pragma config LVP = OFF
#pragma config CPD = OFF
#pragma config WRT = OFF
#pragma config CP = OFF
#line 22 "D:/Tushar Faroque/Fall-19/CSE331(RSF)/Project/Codes/Ultrasonic/CSE331_Project.c"
void Lcd_SetBit(char data_bit)
{
if(data_bit& 1)
 RD4  = 1;
else
 RD4  = 0;

if(data_bit& 2)
 RD5  = 1;
else
 RD5  = 0;

if(data_bit& 4)
 RD6  = 1;
else
 RD6  = 0;

if(data_bit& 8)
 RD7  = 1;
else
 RD7  = 0;
}

void Lcd_Cmd(char a)
{
 RD2  = 0;
Lcd_SetBit(a);
 RD3  = 1;
 __delay_ms(4);
  RD3  = 0;
}

void Lcd_Clear()
{
Lcd_Cmd(0);
Lcd_Cmd(1);
}

void Lcd_Set_Cursor(char a, char b)
{
char temp,z,y;
if(a== 1)
{
 temp = 0x80 + b - 1;
z = temp>>4;
y = temp & 0x0F;
Lcd_Cmd(z);
Lcd_Cmd(y);
}
else if(a== 2)
{
temp = 0xC0 + b - 1;
z = temp>>4;
y = temp & 0x0F;
Lcd_Cmd(z);
Lcd_Cmd(y);
}
}

void Lcd_Start()
{
 Lcd_SetBit(0x00);
 for(int i=1065244; i<=0; i--) NOP();
 Lcd_Cmd(0x03);
__delay_ms(5);
 Lcd_Cmd(0x03);
__delay_ms(11);
 Lcd_Cmd(0x03);
 Lcd_Cmd(0x02);
 Lcd_Cmd(0x02);
 Lcd_Cmd(0x08);
 Lcd_Cmd(0x00);
 Lcd_Cmd(0x0C);
 Lcd_Cmd(0x00);
 Lcd_Cmd(0x06);
}

void Lcd_Print_Char(char data)
{
 char Lower_Nibble,Upper_Nibble;
 Lower_Nibble = data&0x0F;
 Upper_Nibble = data&0xF0;
  RD2  = 1;
 Lcd_SetBit(Upper_Nibble>>4);
  RD3  = 1;
 for(int i=2130483; i<=0; i--) NOP();
  RD3  = 0;
 Lcd_SetBit(Lower_Nibble);
  RD3  = 1;
 for(int i=2130483; i<=0; i--) NOP();
  RD3  = 0;
}

void Lcd_Print_String(char *a)
{
int i;
for(i=0;a[i]!='\0';i++)
 Lcd_Print_Char(a[i]);
}


int time_taken;
int distance;
char t1,t2,t3,t4,t5;
char d1,d2,d3;

int main()
{
 TRISD = 0x00;
 TRISB0 = 1;
 TRISB1 = 0;
 TRISB2 = 1;
 TRISB3 = 0;

 T1CON=0x20;

 Lcd_Start();

 Lcd_Set_Cursor(1,1);
 Lcd_Print_String("Ultrasonic sensor");
 Lcd_Set_Cursor(2,1);
 Lcd_Print_String("with PIC16F877A");

 __delay_ms(2000);
 Lcd_Clear();

 while(1)
 {
 TMR1H =0; TMR1L =0;

  RB1  = 1;
 __delay_us(10);
  RB1  = 0;

 while ( RB2 ==0);
 TMR1ON = 1;
 while ( RB2 ==1);
 TMR1ON = 0;

 time_taken = (TMR1L | (TMR1H<<8));
 distance= (0.0272*time_taken)/2;

 time_taken = time_taken * 0.8;

 t1 = (time_taken/1000)%10;
 t2 = (time_taken/1000)%10;
 t3 = (time_taken/100)%10;
 t4 = (time_taken/10)%10;
 t5 = (time_taken/1)%10;
 d1 = (distance/100)%10;
 d2 = (distance/10)%10;
 d3 = (distance/1)%10;

 Lcd_Set_Cursor(1,1);
 Lcd_Print_String("Time_taken:");
 Lcd_Print_Char(t1+'0');
 Lcd_Print_Char(t2+'0');
 Lcd_Print_Char(t3+'0');
 Lcd_Print_Char(t4+'0');
 Lcd_Print_Char(t5+'0');

 Lcd_Set_Cursor(2,1);
 Lcd_Print_String("distance:");
 Lcd_Print_Char(d1+'0');
 Lcd_Print_Char(d2+'0');
 Lcd_Print_Char(d3+'0');
 }
 return 0;
}
