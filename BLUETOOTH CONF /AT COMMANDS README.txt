Refer to https://www.itead.cc/wiki/Serial_Port_Bluetooth_Module_(Master/Slave)_:_HC-05

AT // Test command to check if we are communicating (expect to receive OK)
AT+NAME=MK-312BT //Name the module
AT+UART=19200,0,0 //Set baud rate to be same as the ATMEGA16
AT+PSWD=1234 //Set the pairing password
AT+POLAR=1,1 //Set the LED Indicator polarity (1 = High Drive  0 =  Low Drive)
AT+IPSCAN=1024,1,1024,1 // Reduce power consumption by increasing the scan interval. Without this it consumes ~43mA when not connected and causes the 5v regulator to get toasty (but still within operational temp range) 

To do this automatically.
0) Solder Pin32 of the HC05 module  (See HC05PINOUT.PNG for reference)
1) Flash the included bin file onto the ATMEGA16
2) Plug the HC-05 bluetooth radio into the board (ensure pin 32 is soldered to the carrier board) 
3)  Place HC-05 in command mode by holding down the button on the HC-05 module, power up MK-312BT and release button after 2 seconds. LEDs on HC-05 will blink slowly (0.5 Hz) to indicate command mode.
4) Watch GUI until it says the HC-05 configuration is finished and flash normal firmware back on to the ATMEGA16
5)If program stops on "Communicating with HC-05" make sure OSCCAL value for 8 MHz R/C position is copied to &H3FFF of bin location or use external 8 MHz crystal with appropriate fuse bits set (FFS use the external crystal)
