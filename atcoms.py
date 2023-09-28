#!/usr/bin/env python3

import serial
import time

def sendat(cmd):
    print("Connecting modem")
    ser = serial.Serial('/dev/ttyUSB3', 115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS, timeout=5, exclusive = True)
    # open serial
    if(ser.isOpen() == False):
        print("opening serial port")
        ser.open()
    else:
        print("serial is open")

    if(ser.isOpen()):

        # clear buffer
        if ser.inWaiting() > 0:
            ser.flushInput()
            ser.flushOutput()
        
        time.sleep(1)
        print("sending the command")
        command = "ATI\r"
        payload = bytes(command, 'utf-8')
        ser.write( command.encode() )
        while True:
            print("reading...")
            data = ''
            time.sleep(1)
            while ser.inWaiting()>0:
                data += ser.read(1)
            if data:
                print ('Got:', data)

        print("disconnecting")
        ser.close()

sendat(b"AT+CIMI\r")