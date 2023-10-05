import time
import serial
from serial import SerialException
import numpy as np
import struct

# import matplotlib.pyplot as plt
   
s_port = "\\\\.\\COM5" #python    (COM5) <=> Animatlab (COM6)
s = serial.Serial(s_port, 256000, timeout=1)#, parity=serial.PARITY_EVEN)

r_port = "\\\\.\\COM8" #Animatlab (COM7)  => Python    (COM8)
r = serial.Serial(r_port, 256000, timeout=10)#, parity=serial.PARITY_EVEN) 

# r_port1 = "\\\\.\\COM23" #Animatlab (COM22)  => Python    (COM23)
# r1 = serial.Serial(r_port1, 256000, timeout=10)#, parity=serial.PARITY_EVEN) 

#close the connections with the following:    
# r.close()
# s.close()


def runSim(t, m, k=3):
    
    ''' This function utilizes sendAnimatData(), To send data values to
    Animatlab as well as readAnimatSerial() to read the output values in python.
    It uses a randomized ternary sequence to send current inputs with arbitrary 
    run time.
    Parameters:
        simulation time = t
        range of randomness = m
        sequence multiplier = k (default k=3 for a ternary sequence)
        '''

    t_end=(time.time()+t)*1000
    dtt=0.25
    tstart=time.time()
    
    while time.time()*1000 <= t_end:
        
        tic=time.time()*1000
        #randomizing the ID values
        ID=[20,21,22,23]
        ID=np.random.choice(ID,np.random.randint(1,4), replace=False)
        
        # selects a value of x
        x = np.random.randint(m) % k
        match x:
            case 0:
                print('0')
                t=np.random.uniform(1, 3)
                sendAnimatData(s,r,t,20,23)
            case 1:
                print('1')
                t=np.random.uniform(1, 3)
                sendAnimatData(s,r,t,21,23)
        
            case 2:
                print('2')
                t=np.random.uniform(1, 3)
                sendAnimatData(s,r,t,20,22,23)
                
        toc = time.time()*1000 - tic
        # print(toc)
        if dtt > toc:
            time.sleep((dtt - toc)/1000)
            
    end_time=time.time()
    el_time=end_time-tstart
    print('elapsed time=', el_time,'s')
        
    
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
    
    ids=[]
    dats=[]
    tempdat=[]
    #loop through the rest of the data and read it in
    for ii in range(nbr_data_points):
       
        temp_ID = r.read(2)
        ids.append(temp_ID[0])#struct.unpack('B', temp_ID)
        # print('ID is ' + ID)
        
        temp_data= r.read(4)
        tempdat.append(list(temp_data))
        dats.append(struct.unpack('f', temp_data)[0])
        
    #calculating checksum and making sure it agrees
    temp_data_nbr = r.read(1)
    Checksum = temp_data_nbr[0]
    chksum = chksum + np.sum(ids) + np.sum(tempdat)
    chksum=chksum %256

    # if values agree perform the following:
    for ix in range(nbr_data_points):
        if chksum == Checksum:
            print('ID is '+ str(ids[ix])+ ', val ='+ str(dats[ix]/1000) + ' mV')
        
            
        
def sendAnimatData(s, r, test_length, ID1=0, ID2=0, ID3=0, ID4=0):
    
    # try:
    #     s.open()
    #     r.open()
    #     print('ports open')
    # except SerialException:
    #     print('ports already open')
    
    
    ID1=np.int32(ID1)
    ID2=np.int32(ID2)
    ID3=np.int32(ID3)
    ID4=np.int32(ID4)
        
    #set the end time based on test_length (ms)
    end_time = (time.time()+ test_length)*1000


    #Finding the number of inputs 
    num_ID=np.array([20, 21, 22, 23], dtype=np.int32)
    IDs=np.array([ID1, ID2, ID3, ID4], dtype=np.int32)
    
    ind = []
    for value in IDs:
        index = np.where(num_ID == value)[0]
        if index.size == 0:
            pass
        else:
            ind.append(index[0])

    # set the timestep length (ms)
    dt = 0.25      

    # Creating the message frame depending on the amount of data transmitted
    #Animatlab 12 bit message: | 0 | 1 |2| 3|4| 5|6| 7| 8|9|10|   11   |...
    #                          |255|255|1|12|0|ID|0|me|ss|a|ge|checksum|...
    #16 bit message         ...|11|12|13|14|15|   16   |...    
    #for a second Data ID   ...|ID|me|ss| a|ge|checksum|...

    msg_len=6*len(num_ID)
    msg=np.zeros([msg_len], dtype=np.int32)
    msg_frame = np.array([255, 255, 1, 0, 0, 0], dtype=np.int32) #[255 255 1 length 0 ID 0]
    msg_frame=np.concatenate([msg_frame,msg])

    # writing the ID values and length of data into message frame
    for i in range(len(num_ID)):
        msg_frame[3] = msg_len + 6
        msg_frame[5 + 6*i] = num_ID[i]
        
    #generating spiking patterns
    #Izikevich parameters
    C=100
    vr=-60   #Resting membrane potential
    vt=-40   #threshold voltage
    k=0.7    # parameters used for RS
    a=np.round((np.random.uniform(0,2, size=len(num_ID))), 2)
    b=np.round((np.random.uniform(-2,2, size=len(num_ID))), 2)
    c=np.round((np.random.uniform(-70,10, size=len(num_ID))), 2)
    d=np.round((np.random.uniform(1,100, size=len(num_ID))), 2) # neocortical pyramidal neurons
    vpeak=np.round((np.random.uniform(35,40, size=len(num_ID))), 2) #spike cutoff
    T=test_length*1000
    tau=1 # time span and step (ms)
    n=int(np.round(T/tau)) # number of simulation steps
    v=vr*np.ones((n,4))
    u=0*v # initial values
    i1=np.zeros((int(0.1*n),4))
    i2=70*np.ones((int(0.9*n),4))
    I=np.concatenate((i1,i2), axis=0) # pulse of input DC current

    # start time to measure the running time for each iteration
    # start_time=time.time()

    while time.time()*1000 < end_time:
        
        #time now
        tic = time.time()*1000
        
        for i in range(0, n-1):
            
            for ii in range(len(ind)):
                # print(v[i+1][ind[ii]])
                v[i+1][ind[ii]]=v[i][ind[ii]]+tau*(k*(v[i][ind[ii]]- vr)*(v[i][ind[ii]]-vt)-u[i][ind[ii]]+I[i][ind[ii]])/C
                u[i+1][ind[ii]]=u[i][ind[ii]]+tau*a[ind[ii]]*(b[ind[ii]]*(v[i][ind[ii]]-vr)-u[i][ind[ii]])
                
                if v[i+1][ind[ii]] >= vpeak[ind[ii]]:  #a spike is fired!
                    v[i][ind[ii]]=vpeak[ind[ii]] # padding the spike amplitude
                    v[i+1][ind[ii]]=c[ind[ii]] # membrane voltage reset
                    u[i+1][ind[ii]]=u[i+1][ind[ii]]+d[ind[ii]] # recovery variable update

            
            motor_input1= struct.unpack('BBBB',struct.pack('<f', v[i][0]))
            motor_input2= struct.unpack('BBBB',struct.pack('<f', v[i][1]))
            motor_input3= struct.unpack('BBBB',struct.pack('<f', v[i][2]))
            motor_input4= struct.unpack('BBBB',struct.pack('<f', v[i][3]))
            
            #calculate Checksum value and add the data arrays to the corresponding       
            Checksum=np.sum(motor_input1)+np.sum(motor_input2)+np.sum(motor_input3)+np.sum(motor_input4)
            Checksum=Checksum+np.sum(msg_frame)
            Checksum=np.array((Checksum % 256), dtype=np.int32)
            
            # message=msg_frame
            # compiling message
            message = np.zeros((1, msg_frame[3]))
            message[0][0:len(msg_frame)] = msg_frame
            message[0][7:11]=motor_input1
            message[0][13:17]=motor_input2
            message[0][19:23]=motor_input3
            message[0][25:29]=motor_input4
            message[0][-1]=Checksum
            
            #writing the message array and compressing it 
            msg = list(message.astype(int).flatten())
            
            # send input message through s channel
            s.write(msg)
            
            #fetch output message through the r channel and read/print using
            #the function below
            readAnimatSerial(r)        
            # readAnimatReceptors(r1)
            #flush the serial ports
            s.flush()
            r.flush()
            
            #time after sending values
            toc = time.time()*1000 - tic
            
            if dt > toc:
                time.sleep((dt-toc)/1000)
                
    mem_pot=np.int32(vr)        
    rest_pot=struct.unpack('BBBB', struct.pack('<f', mem_pot))
    Checksum1=np.sum(rest_pot)*np.int32(4)
    Checksum1=np.sum(msg_frame)+Checksum1
    Checksum1=np.array((Checksum1%256), dtype=np.int32)


    message1 = np.zeros((1, msg_frame[3]))
    message1[0][0:len(msg_frame)] = msg_frame
    message1[0][7:11]=rest_pot
    message1[0][13:17]=rest_pot
    message1[0][19:23]=rest_pot
    message1[0][25:29]=rest_pot
    message1[0][-1]=Checksum1


    msg1=list(message1.astype(int).flatten())
    s.write(msg1)
     
    # end_time=time.time()
    # el_time=end_time-start_time
    # print('elapsed time=', el_time,'s')
    
    # r.close()
    # s.close()
    # print('ports closed')
    


# def readAnimatReceptors(r1):
#     """
#     readAnimatSerial reads data from AnimatLab on the serial channel r,
#     verifies the integrity, and returns any indexed data received.
#     **NOTE: extend to accommodate reading multiple outputs
   
#     :Dependencies: pyserial
#     :param r: initialized pyserial connection
#     :type r: serial object
#     :returns: nothing

#     """
   
#     #generate handshake verification variable
#     chksum = 0
   
   
#     #verify the start of the data package. Note that the first 2 bytes should
#     #hold the value of 255
#     for ii in range(2):        
#         temp = r.read(1)
#         if temp[0] != 255:
#             return
       
#         chksum += temp[0]
       
#     #verify that the data type is correct (1)
#     temp = r.read(1)
#     if temp[0] != 1:
#         return
#     chksum += temp[0]
   
#     #determine the number of incoming data points
#     temp =  r.read(2)
   
#     msg_length = temp[0]#struct.unpack('B', temp)[0]
#     nbr_data_points = int(msg_length/6-1)
#     # print(nbr_data_points)
   
#     chksum += msg_length
    
#     ids=[]
#     dats=[]
#     tempdat=[]
#     #loop through the rest of the data and read it in
#     for ii in range(nbr_data_points):
       
#         temp_ID = r.read(2)
#         ids.append(temp_ID[0])#struct.unpack('B', temp_ID)
#         # print('ID is ' + ID)
        
#         temp_data= r.read(4)
#         tempdat.append(list(temp_data))
#         dats.append(struct.unpack('f', temp_data)[0])
        
#     #calculating checksum and making sure it agrees
#     temp_data_nbr = r.read(1)
#     Checksum = temp_data_nbr[0]
#     chksum = chksum + np.sum(ids) + np.sum(tempdat)
#     chksum=chksum %256

#     # if values agree perform the following:
#     for ix in range(nbr_data_points):
#         if chksum == Checksum:
#             print('ID is '+ str(ids[ix])+ ', val ='+ str(dats[ix]))
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
#------------------------------------------------------------------------------        
    # while time.perf_counter() <= t_end:
    #     tic=time.perf_counter()*1000
    #     # selects a value of x
    #     x = np.random.randint(m) % k
    #     match x:
    #         case 0:
    #             ID=np.random.randint(20)
                
    #             print("20")
    #         case 1:
    #             print("21")
    #         case 2:
    #             print("22")
            
    #     # if statements: if x is equal to 2 then perform the following
    #     if x == 2:
    #         print('--------------------------2-------------------------------')
    #         # find an arbitrary number for delt ranging from 5-10
    #         delt=np.random.randint(0,5)
    #         # end time is equal to the current python time 
    #         # plus  delt
    #         end_time=time.perf_counter()+delt
            
    #         while time.perf_counter()<end_time:
    #             ID=np.random.randint(20,24)
    #             if end_time > t_end:
    #                 break
    #             if ID == 20:
    #                 # print(ID)
    #                 # delt=np.random.randint(5,10)
    #                 sendAnimatData(s,r,ID, delt, 1)
    #                 # time.sleep(round(np.random.uniform(0.25,1),3))
    #                 # time.sleep(delt)
                    
    #             elif ID == 21:
    #                 # print(ID)
    #                 # delt=np.random.randint(5,10)
    #                 sendAnimatData(s,r,ID, delt, 1)
    #                 # time.sleep(round(np.random.uniform(0.25,1),3))
    #                 # time.sleep(delt)
    #             elif ID == 22:
    #                 # print(ID)
    #                 # delt=np.random.randint(5,10)
    #                 sendAnimatData(s,r,ID, delt, 1)
    #                 # time.sleep(round(np.random.uniform(0.25,1),3))
    #                 # time.sleep(delt)
    #             elif ID == 23:
    #                 # print(ID)
    #                 # delt=np.random.randint(5,10)
    #                 sendAnimatData(s,r,ID, delt, 1)
    #                 # time.sleep(round(np.random.uniform(0.25,1),3))
    #                 # time.sleep(delt)
    #             else:
    #                 pass
    #         print('--------------------------2end----------------------------')
    #     elif x == 1:
    #         print('--------------------------1-------------------------------')
    #         delt=np.random.randint(0,5)
    #         end_time=time.perf_counter()+delt
            
    #         while time.perf_counter() < end_time:
    #             ID=np.random.randint(20,24)
    #             strength=round(np.random.randint(1.25,2.25))
    #             if end_time > t_end:
    #                 break
    #             if ID == 20:         
    #                 # print(ID, strength)
    #                 sendAnimatData(s,r,ID, delt, strength)
                    
    #             elif ID == 21:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, strength)
                    
    #             elif ID == 22:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, strength)
                    
    #             elif ID == 23:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, strength)
    #             else:
    #                 pass
            
    #         print('--------------------------1end----------------------------')    
    #     elif x == 0:
    #         print('--------------------------0-------------------------------')
    #         delt=np.random.randint(0,5)
    #         end_time=time.perf_counter()+delt
            
    #         while time.perf_counter()<delt:
    #             ID=np.random.randint(20,24)
                    
    #             if end_time > t_end:
    #                 break
    #             if ID == 20:         
    #                 # print(ID, strength)
    #                 sendAnimatData(s,r,ID, delt, 0)
                    
    #             elif ID == 21:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, 0)
                    
    #             elif ID == 22:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, 0)
                    
    #             elif ID == 23:
    #                 # print(strength)
    #                 sendAnimatData(s,r,ID, delt, 0)
    #             else:
    #                 pass
    #         print('--------------------------0end----------------------------')
    #     else:
    #         break
        
    #     r.flush()
    #     s.flush()
        
    #     # ct=time.perf_counter()*1000
    #     # wtime=ct-tstart
    #     # time.sleep(wtime-wtime)
    #     toc = time.perf_counter()*1000 - tic
    #     # print(toc)
    #     if dtt > toc:
    #         time.sleep(dtt - toc)
            
    # endtime=time.perf_counter()
    # dt=endtime-stime
    # print('process time=', dt, 's')