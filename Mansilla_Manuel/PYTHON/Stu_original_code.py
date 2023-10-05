# -*- coding: utf-8 -*-
"""
Animat_pyserial.py

This code establishes a data pipeline between AnimatLab and python. The code
presumes the use of a serial port emulator connecting AnimatLab with python,
with COM ports numbered as below.

Animat_pyserial contains 3 functions:
    readAnimatSerial(r) reads data from AnimatLab from the serial port
    writeAnimatSerial(s, msg, ID:int=21) writes and sends data to AnimatLab
    sendAnimatData(s, r, ID, test_length) automates the previous two functions,
    creating a data stream between python and AnimatLab for test_length seconds.

To test the port, enter the following into a terminal window:
    python -m serial.tools.list_ports

Created on Mon Feb 6 13:30:24 2023

@author: Stu McNeal
"""

import time
import serial
import numpy as np
import struct


   
#set up the serial connection with the following:
r_port = "\\\\.\\COM8"
r = serial.Serial(r_port, 256000, timeout=10)#, parity=serial.PARITY_EVEN)

s_port = "\\\\.\\COM5"
s = serial.Serial(s_port, 256000, timeout=1)#, parity=serial.PARITY_EVEN)

#close the connections with the following:    
# r.close()
# s.close()

def readAnimatSerial(r):
    """
    readAnimatSerial reads data from AnimatLab on the serial channel r,
    verifies the integrity, and returns any indexed data received.
    **NOTE: extend to accommodate reading multiple outputs
   
    :Dependencies: pyserial
    :param r: initialized pyserial connection
    :type r: serial object
    :returns: nothing

    """
   
    #generate handshake verification variable
    chksum = 0
   
   
    #verify the start of the data package. Note that the first 2 bytes should
    #hold the value of 255
    for ii in range(2):        
        temp = r.read(1)
        if temp[0] != 255:
            return
       
        chksum += temp[0]
       
    #verify that the data type is correct (1)
    temp = r.read(1)
    if temp[0] != 1:
        return
    chksum += temp[0]
   
    #determine the number of incoming data points
    temp =  r.read(2)
   
    msg_length = temp[0]#struct.unpack('B', temp)[0]
    nbr_data_points = int(msg_length/6-1)
    # print(nbr_data_points)
   
    chksum += msg_length
   
    #loop through the rest of the data and read it in
    for ii in range(nbr_data_points):
       
        temp_ID = r.read(2)
        ID = temp_ID[0]#struct.unpack('B', temp_ID)
        # print('ID is ' + ID)
       
        temp_data = r.read(4)
        data = struct.unpack('f', temp_data)[0]
       
        temp_data_nbr = r.read(1)
        Checksum = temp_data_nbr[0]
       
        chksum += ID
        chksum += sum(temp_data)
       
        if np.mod(chksum, 256) == Checksum:
            print('ID is ' + str(ID) + '; val = ' + str(data))
            
        return data
       
           
def sendAnimatData(s, r, ID, test_length):
    """
    sendAnimatData() loops for test_length seconds alternately sending and
    receiving data from AnimatLab. Note that an unknown ID can be resolved by
    running readAnimatData() and reading the variable in the [0] index.
   
    :param s: pyserial
    :type s: initialized pyserial connection
    :param r: pyserial
    :type r: initialized pyserial connection
    :param ID: data identifier
    :type ID: int
    :param test_length: length of AnimatLab simulation [seconds]
    :type test_length: int
    :returns: nothing

    """
   
    #ensure the serial ports are clear before starting the run
    r.flush()
    s.flush()
   
    #define the messaging format (AnimatLab-specific)
    msg_frame = np.array([255, 255, 1, 12, 0, ID, 0]) #[255 255 1 length 0 ID 0]
   
    #set the timestep length
    dt = 0.0005
   
    #set the end time based on test_length
    end_time = time.time() + test_length
   
    while time.time()<end_time:
       
        #time now
        tic = time.time()        
           
        #calculate platform input
        motor_input = struct.unpack('BBBB',struct.pack('<f', round(2*np.cos(time.time()), 4)))
       
        #calculate message length
        msg_frame[3] = 8 + len(motor_input) #len(msg_frame) + len(motor_input.tobytes()) + len(Checksum)
       
        #calculate Checksum value
        Checksum = np.array(np.mod(np.sum(msg_frame) + np.sum(motor_input),256))
       
        #compile message
        msg = np.zeros((1,msg_frame[3]))
        msg[0][0:7] = msg_frame
        msg[0][7:-1] = motor_input
        msg[0][-1] = Checksum
        msg = list(msg.astype(int).flatten())
       
        #send input message
        s.write(msg)
       
        #fetch output message
        # readAnimatSerial(r)        
       
        #flush the serial ports
        s.flush()
        r.flush()
       
        #pause for dt seconds
        toc = time.time() - tic
        # print(toc)
        if dt > toc:
            time.sleep(dt - toc)

def writeAnimatSerial(s, msg, ID:int=21):
    """
    writeAnimatSerial() generates and writes serial message to AnimatLab. Upon
    task completion, the ID, timestamp, and message are echoed back as a list.
   
    :param s: pyserial
    :type s: intialized pyserial connection
    :param r: pyserial
    :type r: initialized pyserial connection
    :param ID: data identifier
    :type ID: int
    :param test_length: length of AnimatLab simulation [seconds]
    :type test_length: int
    :returns: time, ID, message from AnimatLab
    :type return: list

    """

    #ensure the serial ports are clear before starting the run
    s.flush()
   
    #define the messaging format (AnimatLab-specific)
    msg_frame = np.array([255, 255, 1, 12, 0, ID, 0]) #[255 255 1 length 0 ID 0]
   
    #calculate platform input
    motor_input = struct.unpack('BBBB',struct.pack('<f', msg))
   
    #calculate message length
    msg_frame[3] = 8 + len(motor_input) #len(msg_frame) + len(motor_input.tobytes()) + len(Checksum)
   
    #calculate Checksum value
    Checksum = np.array(np.mod(np.sum(msg_frame) + np.sum(motor_input),256))
   
    #compile message
    msg = np.zeros((1,msg_frame[3]))
    msg[0][0:7] = msg_frame
    msg[0][7:-1] = motor_input
    msg[0][-1] = Checksum
    msg = list(msg.astype(int).flatten())
   
    #send input message
    s.write(msg)
   
    return [time.time(), ID, msg]