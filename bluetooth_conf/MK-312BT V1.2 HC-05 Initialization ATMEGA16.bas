$crystal = 8000000
'$baud = 38400                                               'this loader uses serial com
$regfile = "m16def.dat"


Config Com1 = 38400 , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0       '38,400 Baud N,8,1

Config Lcd = 16x2 , Chipset = Ks077
Config Lcdmode = Port
Config Lcdpin = Pin , Db4 = Portc.4 , Db5 = Portc.5 , Db6 = Portc.6 , Db7 = Portc.7 , E = Portc.2 , Rs = Portc.3

Dim Bstatus As Byte
Dim Ocal As Byte


Ocal = Cpeek(&H3fff)                                                            'Read 3FFF into memory
If Ocal = &HFF Then Ocal = &HA5
Osccal = Ocal                                                                   'Update OSCCAL with instruction read from memory


Disable Interrupts                                                              'we do not use ints


Config Pind.6 = Output
Portd.6 = 1                                                                     'Channel A Output LED Active Low

Config Pind.5 = Output
Portd.5 = 1                                                                     'Channel B Output LED Active Low

Config Pinc.0 = Output
Portc.0 = 0                                                                     '4066 Multiplexer L=LCD H=Buttons

Config Pinc.1 = Output
Portc.1 = 0                                                                     'LCD Write

Config Pind.7 = Output
Portd.7 = 0                                                                     'LCD Backlight On

Initlcd

Upperline
Lcd "                "
Lowerline
Lcd "                "

Wait 1

Upperline
Lcd "MK-312BT BL V1.2"
Lowerline
Lcd "HC-05 Initialize"
Wait 5

Upperline
Lcd "Communicating   "
Lowerline
Lcd "with HC-05      "
Wait 3

Do
 Print "AT"
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B

Upperline
Lcd "Communication   "
Lowerline
Lcd "with HC-05 is OK"
Wait 3


Upperline
Lcd "Programming     "
Lowerline
Lcd "BlueTooth Name  "
Wait 3

Print "AT+NAME=MK-312BT"
Do
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B


Upperline
Lcd "Programming     "
Lowerline
Lcd "Serial Baud Rate"
Wait 3

Print "AT+UART=19200,0,0"
Do
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B


Upperline
Lcd "Programming     "
Lowerline
Lcd "Scan Parameters "
Wait 3

Print "AT+IPSCAN=1024,1,1024,1"
Do
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B


Upperline
Lcd "Programming     "
Lowerline
Lcd "LED Polarity    "
Wait 3

Print "AT+POLAR=1,1"
Do
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B


Upperline
Lcd "Programming     "
Lowerline
Lcd "PIN Code to 1234"
Wait 3

Print "AT+PSWD=1234"
Do
   Bstatus = Waitkey()
Loop Until Bstatus = &H4B

Upperline
Lcd "Programming     "
Lowerline
Lcd "is completed    "
Wait 3

End