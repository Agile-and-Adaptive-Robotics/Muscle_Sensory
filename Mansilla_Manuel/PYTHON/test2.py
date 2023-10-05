import time
import numpy as np
import serial
from serial import SerialException
import struct


r_port = "\\\\.\\COM8"
r = serial.Serial(r_port, 256000,  timeout=10)#, parity=serial.PARITY_EVEN)

s_port = "\\\\.\\COM5"
s = serial.Serial(s_port, 256000,  timeout=0)#, parity=serial.PARITY_EVEN)



# def readAnimatSerial(r):
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
   
#     #loop through the rest of the data and read it in
#     for ii in range(nbr_data_points):
       
#         temp_ID = r.read(2)
#         ID = temp_ID[0]#struct.unpack('B', temp_ID)
#         # print('ID is ' + ID)
        
#         temp_data = r.read(4)
#         data = struct.unpack('f', temp_data)[0]
       
#         temp_data_nbr = r.read(1)
#         Checksum = temp_data_nbr[0]
        
#         chksum += ID
#         chksum += sum(temp_data)
       
#         if np.mod(chksum, 256) == Checksum:
#             print('ID is ' + str(ID) + '; val = ' + str(data))
            
#         return data
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

    # # if values agree perform the following:
    for ix in range(nbr_data_points):
        if chksum == Checksum:
            print('ID is '+ str(ids[ix])+ ', val ='+ str(dats[ix]/1000) + ' mV')
        
        # lst20=[]
        # while ids[ix]==20:
        #     lst20.append(ids[ix])
        
        
        

    
    
    
ID1=20
ID2=21
ID3=22
ID4=23
    
#set the end time based on test_length (ms)
end_time = (time.time()+ 25)*1000


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
T=25*1000
tau=1 # time span and step (ms)
n=int(np.round(T/tau)) # number of simulation steps
v=vr*np.ones((n,4))
u=0*v # initial values
i1=np.zeros((int(0.1*n),4))
i2=70*np.ones((int(0.9*n),4))
I=np.concatenate((i1,i2), axis=0) # pulse of input DC current

start_time=time.time()


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
        
        # print(Checksum)
        # send input message
        s.write(msg)
        # print(msg)  
        #fetch output message
        readAnimatSerial(r)        
        # print(v)
        #flush the serial ports
        s.flush()
        r.flush()
    
        toc = time.time()*1000 - tic
        # print(toc)
        if dt > toc:
            time.sleep((dt-toc)/1000)
            
vr=np.int32(-60)        
rest_pot=struct.unpack('BBBB', struct.pack('<f', vr))
respot=np.array(rest_pot, dtype=np.int32)
Checksum1=np.sum(rest_pot)*4
Checksum1=np.sum(msg_frame)+Checksum
Checksum1=np.array((Checksum%256), dtype=np.int32)


message1 = np.zeros((1, msg_frame[3]))
message1[0][0:len(msg_frame)] = msg_frame
message1[0][7:11]=respot
message1[0][13:17]=respot
message1[0][19:23]=respot
message1[0][25:29]=respot
message1[0][-1]=Checksum


msg1=list(message1.astype(int).flatten())
s.write(msg1)


r.close()
s.close()

end_time=time.time()
el_time=end_time-start_time
print('elapsed time=', el_time,'s')
    



#------------------------------------------------------------------------------


##WORKING CODE0.1
# def simpleNeuron(T, a=0.03, b=-2, c=-40, d=100, tau=int(1)):
#     """ This neuron model simulates the Izikevich simple neuron model
    
#     paramenters:
#         a=decay rate;
#         b=sensitivity;
#         c=reset voltage;
#         d=amplitude reset voltage;
#         Spiking parameters(a,b,c,d):
#             RS,IB,CH=(0.02,0.2,[-65,-55,-50],[8,4,2])
#             LTS,TC=(0,02,0,25,-65,[2,0.05])
            
#         """
#     # C=100
#     # vr=np.random.randint(-65,-55)   #Resting membrane potential
#     # vt=-40   #threshold voltage
#     # k=round(np.random.uniform(0,1),2)    # parameters used for RS
#     # a=round(np.random.uniform(0.02,0.2),2)
#     # b=round(np.random.uniform(0.02,0.2),2)
#     # c=np.random.randint(-65,-55)
#     # d=round(np.random.uniform(0,100),2) # neocortical pyramidal neurons
#     # vpeak=np.random.randint(30,40) #spike cutoff
#     # T=1000 # (ms)
#     C=100
#     vr=-60   #Resting membrane potential
#     vt=-40   #threshold voltage
#     k=0.7    # parameters used for RS
#     a=a
#     b=b
#     c=c
#     d=d # neocortical pyramidal neurons
#     vpeak=35 #spike cutoff
#     T=T*1000
#     tau=tau # time span and step (ms)
#     n=int(np.round(T/tau)) # number of simulation steps
#     v=vr*np.ones(n)
#     u=0*v # initial values
#     i1=np.zeros(int(0.025*n))
#     i2=70*np.ones(int(0.975*n))
#     I=np.append(i1,i2) # pulse of input DC current

#     # tstart=time.perf_counter()*1000
#     for i in range (1,int(n-1)): # forward Euler method
    
#         v[i+1]=v[i]+tau*(k*(v[i]-vr)*(v[i]-vt)-u[i]+I[i])/C
#         u[i+1]=u[i]+tau*a*(b*(v[i]-vr)-u[i])
    
#         if v[i+1]>=vpeak:  #a spike is fired!
#             v[i]=vpeak # padding the spike amplitude
#             v[i+1]=c # membrane voltage reset
#             u[i+1]=u[i+1]+d # recovery variable update
        
#         # ct=time.perf_counter()*1000
#         # wtime=ct-tstart
#         # time.sleep(wtime-wtime)
        
#     # tend=time.perf_counter()*1000    
#     # dt=tend-tstart
#     # print('process time=', dt, 'ms')    
#     # plt.plot(np.arange(0,n,1), v)
#     # plt.grid()
    
#     return  v #struct.pack('%sf' %len(v), *v)


# def sendAnimatData(s, r, test_length, ID1=0, ID2=0, ID3=0, ID4=0):
    
#     #set the end time based on test_length
#     end_time = time.perf_counter()*1000 + test_length*1000
    
#     ID1=np.int32(ID1)
#     ID2=np.int32(ID2)
#     ID3=np.int32(ID3)
#     ID4=np.int32(ID4)
    
#     #Finding the number of inputs 
#     num_ID=[ID1, ID2, ID3, ID4]
#     num_inputs=0
#     for i in num_ID:
#         if i > 0:
#             num_inputs += 1
           
        
#     # set the timestep length
#     dt = 0.2
    
#     msg_len=6*num_inputs
#     msg=np.zeros([msg_len], dtype=np.int32)
#     msg_frame = np.array([255, 255, 1, 0, 0, 0], dtype=np.int32) #[255 255 1 length 0 ID 0]
#     msg_frame=np.concatenate([msg_frame,msg])
#     for i in range(num_inputs):
#         msg_frame[5 +6 *i] = num_ID[i]
#         msg_frame[3] = msg_len + 6
        
#     # generating the data required to be passed through the serial port
#     data=simpleNeuron(test_length)
#     data2=simpleNeuron(test_length, 0.03, -2, -50, 100)
    
#     # while time.perf_counter()<end_time:
    
#     start_time=time.perf_counter()
    
#     for i in range(len(data)):
#         #time now
#         tic = time.perf_counter()*1000  
        
#         #motor inputs for desired number of neruons        
#         motor_input1 = struct.unpack('BBBB',struct.pack('<f', round(data[i], 4)))
#         motor_input2= struct.unpack('BBBB',struct.pack('<f', round(data2[i], 4)))
#         motor_input3= struct.unpack('BBBB',struct.pack('<f', round(data[i], 4)))
#         motor_input4= struct.unpack('BBBB',struct.pack('<f', round(data2[i], 4)))
#         motor_array=np.array([motor_input1, motor_input2, motor_input3, motor_input4])       
        
#         #calculate Checksum value and add the data arrays to the corresponding
#         #slots
#         Checksum=0
#         for i in range(num_inputs):
#             Checksum += np.sum(motor_array[i])
#             msg_frame[7+6*i:11+6*i]=motor_array[i]
#         Checksum =Checksum+np.sum(msg_frame)
#         Checksum=np.array(np.mod(Checksum,256)) 
#         msg_frame[-1]=Checksum
    
#         msg = list(msg_frame.astype(int).flatten())
                
#         # send input message
#         s.write(msg)
#         print(msg)
#         #fetch output message
#         # readAnimatSerial(r)        
       
#         #flush the serial ports
#         s.flush()
#         r.flush()
        
#         # toc = time.perf_counter()*1000 - tic
#         # if dt > toc:
#         #     time.sleep((dt - toc)/1000)
#     end_time=time.perf_counter()
#     dt=end_time-start_time
#     print('elapsed time=', dt,'s')






#working CODE------------------------------------------------------------------    
# def sendAnimatData(s, r, test_length, ID1=int(0), ID2=int(0),ID3=int(0),ID4=int(0)):
    
#     #set the end time based on test_length
#     end_time = time.perf_counter()*1000 + test_length*1000
    
#     ID1=np.int32(ID1)
#     ID2=np.int32(ID2)
#     ID3=np.int32(ID3)
#     ID4=np.int32(ID4)
    
#     #Finding the number of inputs 
#     num_ID=[ID1, ID2, ID3, ID4]
#     num_inputs=0
#     for i in num_ID:
#         if i > 0:
#             num_inputs += 1
           
        
#     # set the timestep length
#     dt = 0.3
    
#     msg_len=6*num_inputs
#     msg=np.zeros([msg_len], dtype=np.int32)
#     msg_frame = np.array([255, 255, 1, 0, 0, 0], dtype=np.int32) #[255 255 1 length 0 ID 0]
#     msg_frame=np.concatenate([msg_frame,msg])
#     for i in range(num_inputs):
#         msg_frame[5 +6 *i] = num_ID[i]
#         msg_frame[3] = msg_len + 6
    
#     # print(msg)
#     data=simpleNeuron(test_length)
#     data2=simpleNeuron(test_length, 0.03, -2, -50, 100)
    
#     # while time.perf_counter()<end_time:
    
#     start_time=time.perf_counter()
    
#     for i in range(len(data)):
#         #time now
#         # tic = time.perf_counter()*1000  
        
#         #motor inputs for desired number of neruons        
#         motor_input1 = struct.unpack('BBBB',struct.pack('<f', round(data[i], 4)))
#         motor_input2= struct.unpack('BBBB',struct.pack('<f', 2*round(data2[i], 4)))
#         motor_input3= struct.unpack('BBBB',struct.pack('<f', round(data[i], 4)))
#         motor_input4= struct.unpack('BBBB',struct.pack('<f', round(data2[i], 4)))
#         motor_array=np.array([motor_input1, motor_input2, motor_input3, motor_input4])       
        
#         #calculate Checksum value
#         Checksum=0
#         for i in range(num_inputs):
#             Checksum += np.sum(motor_array[i])
#         Checksum =Checksum+np.sum(msg_frame)
#         Checksum=np.array(np.mod(Checksum,256)) 
        
#         #compiling message
#         message = np.zeros((1, msg_frame[3]))
#         message[0][0:len(msg_frame)] = msg_frame
#         match num_inputs:
#             case 1:
#                 message[0][7:11] = motor_input1
#                 message[0][-1] = Checksum
                
#             case 2:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][-1]=Checksum
                
#             case 3:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][17]=ID3
#                 message[0][19:23]=motor_input3
#                 message[0][-1]=Checksum
                
#             case 4:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][17]=ID3
#                 message[0][19:23]=motor_input3
#                 message[0][23]=ID4
#                 message[0][25:29]=motor_input4
#                 message[0][-1]=Checksum
            
#         # if num_inputs == 1:
#         #     message[0][7:11] = motor_input1
#         #     message[0][-1] = Checksum
            
#         # if num_inputs ==2:
#         #     message[0][7:11]=motor_input1
#         #     message[0][11]=ID2
#         #     message[0][13:17]=motor_input2
#         #     message[0][-1]=Checksum
            
#         # if num_inputs ==3:
#         #     message[0][7:11]=motor_input1
#         #     message[0][11]=ID2
#         #     message[0][13:17]=motor_input2
#         #     message[0][17]=ID3
#         #     message[0][19:23]=motor_input3
#         #     message[0][-1]=Checksum
            
#         # if num_inputs==4:
#         #     message[0][7:11]=motor_input1
#         #     message[0][11]=ID2
#         #     message[0][13:17]=motor_input2
#         #     message[0][17]=ID3
#         #     message[0][19:23]=motor_input3
#         #     message[0][23]=ID4
#         #     message[0][25:29]=motor_input4
#         #     message[0][-1]=Checksum
        
#         msg = list(message.astype(int).flatten())
        
                
#         # send input message
#         s.write(msg)
#         print(msg)
        
#         #fetch output message
#         # readAnimatSerial(r)        
       
#         #flush the serial ports
#         s.flush()
#         r.flush()
        
#         # toc=time.perf_counter()*1000
#         # wtime=(toc-tic)
#         # time.sleep(wtime/1000)
#         # print(msg) 
#         #pause for dt seconds
#         # toc = time.perf_counter()*1000 - tic
#         # if dt > toc:
#         #     time.sleep((dt - toc)/1000)
#     end_time=time.perf_counter()
#     dt=end_time-start_time
#     print('elapsed time=', dt,'s')
     
            
#------------------------------------------------------------------------------
# template for sending multiple data values to multiple IDs
# #generate handshake verification variable
# chksum = 0


# #verify the start of the data package. Note that the first 2 bytes should
# #hold the value of 255
# for ii in range(2):        
#     temp = r.read(1)
#     if temp[0] != 255:
#         # print('temp',temp[0])
#         pass
# print(list(temp))
#     chksum += temp[0]
# # print('temp', temp[0])
# #verify that the data type is correct (1)
# temp = r.read(1)
# if temp[0] != 1:
#     # print('temp1',temp[0])
#     pass
# chksum += temp[0]
# # print('temp1',temp[0])

# #determine the number of incoming data points
# temp =  r.read(2)
# msg_length = temp[0]#struct.unpack('B', temp)[0]
# nbr_data_points = int(msg_length/6-1)
# # print('nbr',nbr_data_points)
# # print('msg lngth', msg_length)
# temp_ID = r.read(6*nbr_data_points+1)

# chksum += msg_length

# IDs=np.zeros(nbr_data_points)
# data=np.zeros(nbr_data_points)

# #loop through the rest of the data and read it in
# for ii in range(nbr_data_points):
#     IDs[ii]=temp_ID[ii+ii*5]
#     data[ii]=struct.unpack('f', temp_ID[2+6*ii:6+6*ii])[0]
    
#     # Checksum = temp_ID[-1]
    
#     # chksum += IDs[ii]
#     # chksum += np.sum(data[ii])

#     # print(Checksum, np.mod(chksum,256))
       
#     # if np.mod(chksum, 256) == Checksum:
#     # print('ID is ' + str(IDs[ii]) + '; val = ' + str(data[ii]))           

# vals=list(r.read(len(temp_ID)+4))
# chcksum=(np.sum(vals) % 256)
# Checksum=temp_ID[-1]

# if chcksum == Checksum:
#     print('ID is ' + str(IDs[ii]) + '; val = ' + str(data[ii]))  

# r.close()
# s.close()









#==============================================================================
#==============================================================================

# ID1=21
# ID2=22
# ID3=23
# ID4=24
    
# #set the end time based on test_length (ms)
# end_time = (time.time()+ 5)*1000


# #Finding the number of inputs 
# num_ID=np.array([20, 21, 22, 23], dtype=np.int32)
# IDs=np.array([ID1, ID2, ID3, ID4], dtype=np.int32)
# num_IDs=np.count_nonzero(IDs)

# ind = []
# for value in IDs:
#     index = np.where(num_ID == value)[0]
#     if index.size == 0:
#         pass
#     else:
#         ind.append(index[0])

# # set the timestep length (ms)
# dt = 0.5      

# # Creating the message frame depending on the amount of data transmitted
# #Animatlab 12 bit message: | 0 | 1 |2| 3|4| 5|6| 7| 8|9|10|   11   |...
# #                          |255|255|1|12|0|ID|0|me|ss|a|ge|checksum|...
# #16 bit message         ...|11|12|13|14|15|   16   |...    
# #for a second Data ID   ...|ID|me|ss| a|ge|checksum|...

# msg_len=6*len(num_ID)
# msg=np.zeros([msg_len], dtype=np.int32)
# msg_frame = np.array([255, 255, 1, 0, 0, 0], dtype=np.int32) #[255 255 1 length 0 ID 0]
# msg_frame=np.concatenate([msg_frame,msg])

# # writing the ID values and length of data into message frame
# for i in range(len(IDs)):
#     msg_frame[3] = msg_len + 6
#     msg_frame[5 + 6*i] = num_ID[i]
    
# #generating spiking patterns
# #Izikevich parameters
# C=100
# vr=-60   #Resting membrane potential
# vt=-40   #threshold voltage
# k=0.7    # parameters used for RS
# a=np.array([0.03,0.03,0.03, 0.03])#np.random.randint(0,5, size=num_IDs)
# b=np.array([-2,-2,-2,-2])#np.random.randint(0,10, size=num_IDs)
# c=np.array([-50,-40,-70, -10])#np.random.randint(1,45, size=num_IDs)
# d=np.array([100,30,50, 600])#np.random.randint(1,100, size=num_IDs) # neocortical pyramidal neurons
# vpeak=np.array([35,35,45, 50])#np.random.randint(35,50, size=num_IDs) #spike cutoff
# T=5*1000
# tau=dt # time span and step (ms)
# n=int(np.round(T/tau)) # number of simulation steps
# v=vr*np.ones((n,4))
# u=0*v # initial values
# i1=np.zeros((int(0.1*n),4))
# i2=70*np.ones((int(0.9*n),4))
# I=np.concatenate((i1,i2), axis=0) # pulse of input DC current

# start_time=time.time()


# while time.time()*1000 < end_time:
    
#     #time now
#     tic = time.time()*1000
    
#     for i in range(0, n-1):
        
#         for ii in range(len(ind)):
#             # print(v[i+1][ind[ii]])
#             v[i+1][ind[ii]]=v[i][ind[ii]]+tau*(k*(v[i][ind[ii]]- vr)*(v[i][ind[ii]]-vt)-u[i][ind[ii]]+I[i][ind[ii]])/C
#             u[i+1][ind[ii]]=u[i][ind[ii]]+tau*a[ind[ii]]*(b[ind[ii]]*(v[i][ind[ii]]-vr)-u[i][ind[ii]])
            
#             if v[i+1][ind[ii]] >= vpeak[ind[ii]]:  #a spike is fired!
#                 v[i][ind[ii]]=vpeak[ind[ii]] # padding the spike amplitude
#                 v[i+1][ind[ii]]=c[ind[ii]] # membrane voltage reset
#                 u[i+1][ind[ii]]=u[i+1][ind[ii]]+d[ind[ii]] # recovery variable update

        
#         motor_input1= struct.unpack('BBBB',struct.pack('<f', np.round(v[i][0],4)))
#         motor_input2= struct.unpack('BBBB',struct.pack('<f', np.round(v[i][1],4)))
#         motor_input3= struct.unpack('BBBB',struct.pack('<f', np.round(v[i][2],4)))
#         motor_input4= struct.unpack('BBBB',struct.pack('<f', np.round(v[i][3],4)))
        
#         #calculate Checksum value and add the data arrays to the corresponding       
#         Checksum=np.sum(motor_input1)+np.sum(motor_input2)+np.sum(motor_input3)+np.sum(motor_input4)
#         Checksum=Checksum+np.sum(msg_frame)
#         Checksum=np.array((Checksum % 256), dtype=np.int32)
        
#         # message=msg_frame
#         # compiling message
#         message = np.zeros((1, msg_frame[3]))
#         message[0][0:len(msg_frame)] = msg_frame
#         message[0][7:11]=motor_input1
#         message[0][13:17]=motor_input2
#         message[0][19:23]=motor_input3
#         message[0][25:29]=motor_input4
#         message[0][-1]=Checksum
        
#         #writing the message array and compressing it 
#         msg = list(message.astype(int).flatten())
        
#         # print(Checksum)
#         # send input message
#         s.write(msg)
#         # print(msg)  
#         #fetch output message
#         readAnimatSerial(r)        
#         # print(v)
#         #flush the serial ports
#         # s.flush()
#         # r.flush()
    
#         toc = time.time()*1000 - tic
#         # print(toc)
#         if dt > toc:
#             time.sleep((dt-toc)/1000)
            
# r.close()
# s.close()

# end_time=time.time()
# el_time=end_time-start_time
# print('elapsed time=', el_time,'s')

#==============================================================================
#==============================================================================



# #set the end time based on test_length (ms)
# end_time = (time.time()+ 10)*1000

# # ID1=np.int32(22)
# # ID2=np.int32(0)
# # ID3=np.int32(0)
# # ID4=np.int32(0)

# ID1=22
# ID2=0
# ID3=0
# ID4=0

# #Finding the number of inputs 
# num_ID=np.array([20, 21, 22, 23], dtype=np.int32)
# IDs=np.array([ID1,ID2,ID3, ID4], dtype=np.int32)
# num_IDs=np.count_nonzero(num_ID)

# ind = []
# for value in IDs:
#     index = np.where(num_ID == value)[0]
#     if index.size == 0:
#         pass
#     else:
#         ind.append(index[0])    
        
# # set the timestep length (ms)
# dt = 0.5      

# # Creating the message frame depending on the amount of data transmitted
# msg_len=6*num_IDs
# msg=np.zeros([msg_len], dtype=np.int32)
# msg_frame = np.array([255, 255, 1, 0, 0, 0], dtype=np.int32) #[255 255 1 length 0 ID 0]
# msg_frame=np.concatenate([msg_frame,msg])

# # writing the ID values and length of data into message frame
# for i in range(num_IDs):
#     msg_frame[5 +6 *i] = num_ID[i]
#     msg_frame[3] = msg_len + 6
    
# #generating spiking patterns
# #Izikevich parameters
# C=100
# vr=-60   #Resting membrane potential
# vt=-40   #threshold voltage
# k=0.7    # parameters used for RS
# a=np.array([0.03,0.03,0.03, 0.03])#np.random.randint(0,5, size=num_IDs)
# b=np.array([-2,-2,-2,-2])#np.random.randint(0,10, size=num_IDs)
# c=np.array([-50,-40,-70, -10])#np.random.randint(1,45, size=num_IDs)
# d=np.array([100,30,50, 600])#np.random.randint(1,100, size=num_IDs) # neocortical pyramidal neurons
# vpeak=np.array([35,35,45, 50])#np.random.randint(35,50, size=num_IDs) #spike cutoff
# T=10*1000
# tau=dt # time span and step (ms)
# n=int(np.round(T/tau)) # number of simulation steps
# v=vr*np.ones((n,4))
# u=0*v # initial values
# i1=np.zeros((int(0.1*n),4))
# i2=70*np.ones((int(0.9*n),4))
# I=np.concatenate((i1,i2), axis=0) # pulse of input DC current

# start_time=time.time()

# while time.time()*1000 < end_time:
    
#     #time now
#     tic = time.time()*1000
    
#     for i in range(0, n-1):
        
#         if num_IDs == 1:
            
#             v[i+1][0]=v[i][0]+tau*(k*(v[i][0]-vr)*(v[i][0]-vt)-u[i][0]+I[i][0])/C
#             u[i+1][0]=u[i][0]+tau*a[0]*(b[0]*(v[i][0]-vr)-u[i][0])
            
#             if v[i+1][0] >= vpeak[0]:  #a spike is fired!
#                 v[i][0]=vpeak[0] # padding the spike amplitude
#                 v[i+1][0]=c[0] # membrane voltage reset
#                 u[i+1][0]=u[i+1][0]+d[0] # recovery variable update
            
            
#         if num_IDs == 2:
#             v[i+1][0]=v[i][0]+tau*(k*(v[i][0]-vr)*(v[i][0]-vt)-u[i][0]+I[i][0])/C
#             u[i+1][0]=u[i][0]+tau*a[0]*(b[0]*(v[i][0]-vr)-u[i][0])
#             v[i+1][1]=v[i][1]+tau*(k*(v[i][1]-vr)*(v[i][1]-vt)-u[i][1]+I[i][1])/C
#             u[i+1][1]=u[i][1]+tau*a[1]*(b[1]*(v[i][1]-vr)-u[i][1])
            
#             if v[i+1][0] >= vpeak[0]:  #a spike is fired!
#                 v[i][0]=vpeak[0] # padding the spike amplitude
#                 v[i+1][0]=c[0] # membrane voltage reset
#                 u[i+1][0]=u[i+1][0]+d[0] # recovery variable update
                
#             if v[i+1][1] >= vpeak[1]:
#                 v[i][1]=vpeak[1] # padding the spike amplitude
#                 v[i+1][1]=c[1] # membrane voltage reset
#                 u[i+1][1]=u[i+1][1]+d[1] # recovery variable update
            
                
#         if num_IDs == 3:
#             v[i+1][0]=v[i][0]+tau*(k*(v[i][0]-vr)*(v[i][0]-vt)-u[i][0]+I[i][0])/C
#             u[i+1][0]=u[i][0]+tau*a[0]*(b[0]*(v[i][0]-vr)-u[i][0])
#             v[i+1][1]=v[i][1]+tau*(k*(v[i][1]-vr)*(v[i][1]-vt)-u[i][1]+I[i][1])/C
#             u[i+1][1]=u[i][1]+tau*a[1]*(b[1]*(v[i][1]-vr)-u[i][1])
#             v[i+1][2]=v[i][2]+tau*(k*(v[i][2]-vr)*(v[i][2]-vt)-u[i][2]+I[i][2])/C
#             u[i+1][2]=u[i][2]+tau*a[2]*(b[2]*(v[i][2]-vr)-u[i][2])
            
#             if v[i+1][0] >= vpeak[0]:  #a spike is fired!
#                 v[i][0]=vpeak[0] # padding the spike amplitude
#                 v[i+1][0]=c[0] # membrane voltage reset
#                 u[i+1][0]=u[i+1][0]+d[0] # recovery variable update
                
#             if v[i+1][1] >= vpeak[1]:
#                 v[i][1]=vpeak[1] # padding the spike amplitude
#                 v[i+1][1]=c[1] # membrane voltage reset
#                 u[i+1][1]=u[i+1][1]+d[1] # recovery variable update
                
#             if v[i+1][2] >= vpeak[2]:
#                 v[i][2]=vpeak[2] # padding the spike amplitude
#                 v[i+1][2]=c[2] # membrane voltage reset
#                 u[i+1][2]=u[i+1][2]+d[2] # recovery variable update
            
        
#         if num_IDs == 4:
#             v[i+1][0]=v[i][0]+tau*(k*(v[i][0]-vr)*(v[i][0]-vt)-u[i][0]+I[i][0])/C
#             u[i+1][0]=u[i][0]+tau*a[0]*(b[0]*(v[i][0]-vr)-u[i][0])
            
#             v[i+1][1]=v[i][1]+tau*(k*(v[i][1]-vr)*(v[i][1]-vt)-u[i][1]+I[i][1])/C
#             u[i+1][1]=u[i][1]+tau*a[1]*(b[1]*(v[i][1]-vr)-u[i][1])
            
#             v[i+1][2]=v[i][2]+tau*(k*(v[i][2]-vr)*(v[i][2]-vt)-u[i][2]+I[i][2])/C
#             u[i+1][2]=u[i][2]+tau*a[2]*(b[2]*(v[i][2]-vr)-u[i][2])
            
#             v[i+1][3]=v[i][3]+tau*(k*(v[i][3]-vr)*(v[i][3]-vt)-u[i][3]+I[i][3])/C
#             u[i+1][3]=u[i][3]+tau*a[3]*(b[3]*(v[i][3]-vr)-u[i][3])
        
#             if v[i+1][0] >= vpeak[0]:  #a spike is fired!
#                 v[i][0]=vpeak[0] # padding the spike amplitude
#                 v[i+1][0]=c[0] # membrane voltage reset
#                 u[i+1][0]=u[i+1][0]+d[0] # recovery variable update
                
#             if v[i+1][1] >= vpeak[1]:
#                 v[i][1]=vpeak[1] # padding the spike amplitude
#                 v[i+1][1]=c[1] # membrane voltage reset
#                 u[i+1][1]=u[i+1][1]+d[1] # recovery variable update
                
#             if v[i+1][2] >= vpeak[2]:
#                 v[i][2]=vpeak[2] # padding the spike amplitude
#                 v[i+1][2]=c[2] # membrane voltage reset
#                 u[i+1][2]=u[i+1][2]+d[2] # recovery variable update
                
#             if v[i+1][3] >= vpeak[3]:
#                 v[i][3]=vpeak[3] # padding the spike amplitude
#                 v[i+1][3]=c[3] # membrane voltage reset
#                 u[i+1][3]=u[i+1][3]+d[3] # recovery variable update
            
        
#     #motor inputs for desired number of neruons
#         if num_IDs == 1:
#             motor_input1 = struct.unpack('BBBB',struct.pack('<f',v[i][0]))
#             motor_array=np.array([motor_input1])
            
#         if num_IDs == 2:
#             motor_input1 = struct.unpack('BBBB',struct.pack('<f',v[i][0]))
#             motor_input2= struct.unpack('BBBB',struct.pack('<f', v[i][1]))
#             motor_array=np.array([motor_input1, motor_input2])
            
#         if num_IDs == 3:
#             motor_input1 = struct.unpack('BBBB',struct.pack('<f',v[i][0]))
#             motor_input2= struct.unpack('BBBB',struct.pack('<f', v[i][1]))
#             motor_input3= struct.unpack('BBBB',struct.pack('<f', v[i][2]))
#             motor_array=np.array([motor_input1, motor_input2, motor_input3])
            
#         if num_IDs == 4:
#             motor_input1 = struct.unpack('BBBB',struct.pack('<f',v[i][0]))
#             motor_input2= struct.unpack('BBBB',struct.pack('<f', v[i][1]))
#             motor_input3= struct.unpack('BBBB',struct.pack('<f', v[i][2]))
#             motor_input4= struct.unpack('BBBB',struct.pack('<f', v[i][3]))
#             motor_array=np.array([motor_input1, motor_input2, motor_input3, motor_input4])       
        
#         #calculate Checksum value and add the data arrays to the corresponding
#         #slots
#         Checksum=0
#         for i in range(num_IDs):
#             Checksum += np.sum(motor_array[i])
#             # msg_frame[7+6*i:11+6*i]=motor_array[i]
#         Checksum =Checksum+np.sum(msg_frame)
#         Checksum=np.array(np.mod(Checksum,256)) 
#         # msg_frame[-1]=Checksum
#         # compiling message
#         message = np.zeros((1, msg_frame[3]))
#         message[0][0:len(msg_frame)] = msg_frame
#         match num_IDs:
#             case 1:
#                 message[0][7:11] = motor_input1
#                 message[0][-1] = Checksum
               
#             case 2:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][-1]=Checksum
               
#             case 3:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][17]=ID3
#                 message[0][19:23]=motor_input3
#                 message[0][-1]=Checksum
               
#             case 4:
#                 message[0][7:11]=motor_input1
#                 message[0][11]=ID2
#                 message[0][13:17]=motor_input2
#                 message[0][17]=ID3
#                 message[0][19:23]=motor_input3
#                 message[0][23]=ID4
#                 message[0][25:29]=motor_input4
#                 message[0][-1]=Checksum
#         msg = list(message.astype(int).flatten())
        
#         # print(Checksum)
#         # send input message
#         s.write(msg)
#         # print(msg)  
#         #fetch output message
#         # readAnimatSerial(r)        
#         # print(v)
#         #flush the serial ports
#         s.flush()
#         r.flush()
    
#         toc = time.time()*1000 - tic
#         # print(toc)
#         if dt > toc:
#             time.sleep((dt-toc)/1000)
      
        
      
        
      
        
      
        
      
        
# end_time=time.time()
# el_time=end_time-start_time
# print('elapsed time=', el_time,'s')

# r.close()
# s.close()
# print('ports closed')