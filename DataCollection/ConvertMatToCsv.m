%% Convert mat file to csv.

Data_10mm_23cm_Unkinked=load('2021Dec21_10mm23cm_Data.mat');
csvwrite('10mm_23cm_Unkinked_Test1.csv',Data_10mm_23cm_Unkinked.Test1Data);
csvwrite('10mm_23cm_Unkinked_Test2.csv',Data_10mm_23cm_Unkinked.Test2Data);
csvwrite('10mm_23cm_Unkinked_Test3.csv',Data_10mm_23cm_Unkinked.Test3Data);
csvwrite('10mm_23cm_Unkinked_Test4.csv',Data_10mm_23cm_Unkinked.Test4Data);
csvwrite('10mm_23cm_Unkinked_Test5.csv',Data_10mm_23cm_Unkinked.Test5Data);
csvwrite('10mm_23cm_Unkinked_Test6.csv',Data_10mm_23cm_Unkinked.Test6Data);
csvwrite('10mm_23cm_Unkinked_Test7.csv',Data_10mm_23cm_Unkinked.Test7Data);
csvwrite('10mm_23cm_Unkinked_Test8.csv',Data_10mm_23cm_Unkinked.Test8Data);
csvwrite('10mm_23cm_Unkinked_Test9.csv',Data_10mm_23cm_Unkinked.Test9Data);
csvwrite('10mm_23cm_Unkinked_Test10.csv',Data_10mm_23cm_Unkinked.Test10Data);

%% 2022 Jan 3: 10mm 23cm UnKinked Data. Convert .mat to csv. 
Data_10mm_23cm_Unkinked_RawOutput=load('2022Jan3_10mm23cm_Data_RawArduinoForce.mat');
csvwrite('10mm_23cm_UnkinkedRaw_Test1.csv',Data_10mm_23cm_Unkinked_RawOutput.Test1Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test2.csv',Data_10mm_23cm_Unkinked_RawOutput.Test2Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test3.csv',Data_10mm_23cm_Unkinked_RawOutput.Test3Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test4.csv',Data_10mm_23cm_Unkinked_RawOutput.Test4Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test5.csv',Data_10mm_23cm_Unkinked_RawOutput.Test5Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test6.csv',Data_10mm_23cm_Unkinked_RawOutput.Test6Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test7.csv',Data_10mm_23cm_Unkinked_RawOutput.Test7Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test8.csv',Data_10mm_23cm_Unkinked_RawOutput.Test8Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test9.csv',Data_10mm_23cm_Unkinked_RawOutput.Test9Data);
csvwrite('10mm_23cm_UnkinkedRaw_Test10.csv',Data_10mm_23cm_Unkinked_RawOutput.Test10Data);

%% 2022 Jan 3: 10mm 23cm Kinked 14mm Raw Data. Convert .mat to csv. 

Data_10mm_23cm_Kinked14mm_RawOutput=load('2022Jan3_10mm23cm_Kinked14mm_Data_RawArduino.mat');
csvwrite('10mm_23cm_Kinked14mm_Test1.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test1Data);
csvwrite('10mm_23cm_Kinked14mm_Test2.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test2Data);
csvwrite('10mm_23cm_Kinked14mm_Test3.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test3Data);
csvwrite('10mm_23cm_Kinked14mm_Test4.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test4Data);
csvwrite('10mm_23cm_Kinked14mm_Test5.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test5Data);
csvwrite('10mm_23cm_Kinked14mm_Test6.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test6Data);
csvwrite('10mm_23cm_Kinked14mm_Test7.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test7Data);
csvwrite('10mm_23cm_Kinked14mm_Test8.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test8Data);
csvwrite('10mm_23cm_Kinked14mm_Test9.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test9Data);
csvwrite('10mm_23cm_Kinked14mm_Test10.csv',Data_10mm_23cm_Kinked14mm_RawOutput.Test10Data);

%% 2022 Jan 3: 10mm 23cm Kinked 30mm Raw Data. Convert .mat to csv.

Data_10mm_23cm_Kinked30mm_RawOutput=load('2022Jan3_10mm23cm_Kinked30mm_Data_RawArduino.mat');
csvwrite('10mm_23cm_Kinked30mm_Test1.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test1Data);
csvwrite('10mm_23cm_Kinked30mm_Test2.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test2Data);
csvwrite('10mm_23cm_Kinked30mm_Test3.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test3Data);
csvwrite('10mm_23cm_Kinked30mm_Test4.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test4Data);
csvwrite('10mm_23cm_Kinked30mm_Test5.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test5Data);
csvwrite('10mm_23cm_Kinked30mm_Test6.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test6Data);
csvwrite('10mm_23cm_Kinked30mm_Test7.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test7Data);
csvwrite('10mm_23cm_Kinked30mm_Test8.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test8Data);
csvwrite('10mm_23cm_Kinked30mm_Test9.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test9Data);
csvwrite('10mm_23cm_Kinked30mm_Test10.csv',Data_10mm_23cm_Kinked30mm_RawOutput.Test10Data);
%
%######################################################################################################################%
%% 2022 Jan 3: 10mm 30cm UnKinked Raw Data. Convert .mat to csv.

Data_10mm_30cm_Unkinked=load('2022Jan3_10mm30cm_Data_RawArduino.mat');
csvwrite('10mm_30cm_Unkinked_Offset.csv',Data_10mm_30cm_Unkinked.Offset);
csvwrite('10mm_30cm_Unkinked_Test1.csv',Data_10mm_30cm_Unkinked.Test1Data);
csvwrite('10mm_30cm_Unkinked_Test2.csv',Data_10mm_30cm_Unkinked.Test2Data);
csvwrite('10mm_30cm_Unkinked_Test3.csv',Data_10mm_30cm_Unkinked.Test3Data);
csvwrite('10mm_30cm_Unkinked_Test4.csv',Data_10mm_30cm_Unkinked.Test4Data);
csvwrite('10mm_30cm_Unkinked_Test5.csv',Data_10mm_30cm_Unkinked.Test5Data);
csvwrite('10mm_30cm_Unkinked_Test6.csv',Data_10mm_30cm_Unkinked.Test6Data);
csvwrite('10mm_30cm_Unkinked_Test7.csv',Data_10mm_30cm_Unkinked.Test7Data);
csvwrite('10mm_30cm_Unkinked_Test8.csv',Data_10mm_30cm_Unkinked.Test8Data);
csvwrite('10mm_30cm_Unkinked_Test9.csv',Data_10mm_30cm_Unkinked.Test9Data);
csvwrite('10mm_30cm_Unkinked_Test10.csv',Data_10mm_30cm_Unkinked.Test10Data);

%% 2022 Jan 3: 10mm 30cm Kinked12mm Raw Data. Convert .mat to csv.

Data_10mm_30cm_Kinked12mm=load('2022Jan3_10mm30cm_Kinked12mm_Data_RawArduino.mat');
csvwrite('10mm_30cm_Kinked12mm_Offset.csv',Data_10mm_30cm_Kinked12mm.Offset);
csvwrite('10mm_30cm_Kinked12mm_Test1.csv',Data_10mm_30cm_Kinked12mm.Test1Data);
csvwrite('10mm_30cm_Kinked12mm_Test2.csv',Data_10mm_30cm_Kinked12mm.Test2Data);
csvwrite('10mm_30cm_Kinked12mm_Test3.csv',Data_10mm_30cm_Kinked12mm.Test3Data);
csvwrite('10mm_30cm_Kinked12mm_Test4.csv',Data_10mm_30cm_Kinked12mm.Test4Data);
csvwrite('10mm_30cm_Kinked12mm_Test5.csv',Data_10mm_30cm_Kinked12mm.Test5Data);
csvwrite('10mm_30cm_Kinked12mm_Test6.csv',Data_10mm_30cm_Kinked12mm.Test6Data);
csvwrite('10mm_30cm_Kinked12mm_Test7.csv',Data_10mm_30cm_Kinked12mm.Test7Data);
csvwrite('10mm_30cm_Kinked12mm_Test8.csv',Data_10mm_30cm_Kinked12mm.Test8Data);
csvwrite('10mm_30cm_Kinked12mm_Test9.csv',Data_10mm_30cm_Kinked12mm.Test9Data);
csvwrite('10mm_30cm_Kinked12mm_Test10.csv',Data_10mm_30cm_Kinked12mm.Test10Data);


%% 2022 Jan 3: 10mm 30cm Kinked22mm Raw Data. Convert .mat to csv.
Data_10mm_30cm_Kinked22mm=load('2022Jan3_10mm30cm_Kinked22mm_Data_RawArduino.mat');
%csvwrite('10mm_30cm_Kinked22mm_Offset.csv',Data_10mm_30cm_Kinked22mm.Offset);
csvwrite('10mm_30cm_Kinked22mm_Test1.csv',Data_10mm_30cm_Kinked22mm.Test1Data);
csvwrite('10mm_30cm_Kinked22mm_Test2.csv',Data_10mm_30cm_Kinked22mm.Test2Data);
csvwrite('10mm_30cm_Kinked22mm_Test3.csv',Data_10mm_30cm_Kinked22mm.Test3Data);
csvwrite('10mm_30cm_Kinked22mm_Test4.csv',Data_10mm_30cm_Kinked22mm.Test4Data);
csvwrite('10mm_30cm_Kinked22mm_Test5.csv',Data_10mm_30cm_Kinked22mm.Test5Data);
csvwrite('10mm_30cm_Kinked22mm_Test6.csv',Data_10mm_30cm_Kinked22mm.Test6Data);
csvwrite('10mm_30cm_Kinked22mm_Test7.csv',Data_10mm_30cm_Kinked22mm.Test7Data);
csvwrite('10mm_30cm_Kinked22mm_Test8.csv',Data_10mm_30cm_Kinked22mm.Test8Data);
csvwrite('10mm_30cm_Kinked22mm_Test9.csv',Data_10mm_30cm_Kinked22mm.Test9Data);
csvwrite('10mm_30cm_Kinked22mm_Test10.csv',Data_10mm_30cm_Kinked22mm.Test10Data);

%% 2022 Jan 3: 10mm 30cm Kinked33mm Raw Data. Convert .mat to csv.
Data_10mm_30cm_Kinked33mm=load('2022Jan3_10mm30cm_Kinked33mm_Data_RawArduino.mat');
csvwrite('10mm_30cm_Kinked33mm_Offset.csv',Data_10mm_30cm_Kinked33mm.Offset);
csvwrite('10mm_30cm_Kinked33mm_Test1.csv',Data_10mm_30cm_Kinked33mm.Test1Data);
csvwrite('10mm_30cm_Kinked33mm_Test2.csv',Data_10mm_30cm_Kinked33mm.Test2Data);
csvwrite('10mm_30cm_Kinked33mm_Test3.csv',Data_10mm_30cm_Kinked33mm.Test3Data);
csvwrite('10mm_30cm_Kinked33mm_Test4.csv',Data_10mm_30cm_Kinked33mm.Test4Data);
csvwrite('10mm_30cm_Kinked33mm_Test5.csv',Data_10mm_30cm_Kinked33mm.Test5Data);
csvwrite('10mm_30cm_Kinked33mm_Test6.csv',Data_10mm_30cm_Kinked33mm.Test6Data);
csvwrite('10mm_30cm_Kinked33mm_Test7.csv',Data_10mm_30cm_Kinked33mm.Test7Data);
csvwrite('10mm_30cm_Kinked33mm_Test8.csv',Data_10mm_30cm_Kinked33mm.Test8Data);
csvwrite('10mm_30cm_Kinked33mm_Test9.csv',Data_10mm_30cm_Kinked33mm.Test9Data);
csvwrite('10mm_30cm_Kinked33mm_Test10.csv',Data_10mm_30cm_Kinked33mm.Test10Data);

%%########################################################################
%% 2022 Jan 10: 10mm 29cm Unkinked Raw Data. Convert .mat to csv
Data_10mm_29cm_Unkinked = load('2022Jan10_10mm_29_data.mat');

csvwrite('10mm_29cm_Unkinked_Offset.csv',Data_10mm_29cm_Unkinked.Offset);
csvwrite('10mm_29cm_Unkinked_Test1.csv',Data_10mm_29cm_Unkinked.Test1Data);
csvwrite('10mm_29cm_Unkinked_Test2.csv',Data_10mm_29cm_Unkinked.Test2Data);
csvwrite('10mm_29cm_Unkinked_Test3.csv',Data_10mm_29cm_Unkinked.Test3Data);
csvwrite('10mm_29cm_Unkinked_Test4.csv',Data_10mm_29cm_Unkinked.Test4Data);
csvwrite('10mm_29cm_Unkinked_Test5.csv',Data_10mm_29cm_Unkinked.Test5Data);
csvwrite('10mm_29cm_Unkinked_Test6.csv',Data_10mm_29cm_Unkinked.Test6Data);
csvwrite('10mm_29cm_Unkinked_Test7.csv',Data_10mm_29cm_Unkinked.Test7Data);
csvwrite('10mm_29cm_Unkinked_Test8.csv',Data_10mm_29cm_Unkinked.Test8Data);
csvwrite('10mm_29cm_Unkinked_Test9.csv',Data_10mm_29cm_Unkinked.Test9Data);
csvwrite('10mm_29cm_Unkinked_Test10.csv',Data_10mm_29cm_Unkinked.Test10Data);
%% 2022 Jan 10: 10mm 29cm Kinked17mm Raw Data. Convert .mat to csv
Data_10mm_29cm_Kinked17mm = load('2022Jan10_10mm_29cm_Kinked17mm_Data.mat');

csvwrite('10mm_29cm_Kinked17mm_Offset.csv',Data_10mm_29cm_Kinked17mm.Offset);
csvwrite('10mm_29cm_Kinked17mm_Test1.csv',Data_10mm_29cm_Kinked17mm.Test1Data);
csvwrite('10mm_29cm_Kinked17mm_Test2.csv',Data_10mm_29cm_Kinked17mm.Test2Data);
csvwrite('10mm_29cm_Kinked17mm_Test3.csv',Data_10mm_29cm_Kinked17mm.Test3Data);
csvwrite('10mm_29cm_Kinked17mm_Test4.csv',Data_10mm_29cm_Kinked17mm.Test4Data);
csvwrite('10mm_29cm_Kinked17mm_Test5.csv',Data_10mm_29cm_Kinked17mm.Test5Data);
csvwrite('10mm_29cm_Kinked17mm_Test6.csv',Data_10mm_29cm_Kinked17mm.Test6Data);
csvwrite('10mm_29cm_Kinked17mm_Test7.csv',Data_10mm_29cm_Kinked17mm.Test7Data);
csvwrite('10mm_29cm_Kinked17mm_Test8.csv',Data_10mm_29cm_Kinked17mm.Test8Data);
csvwrite('10mm_29cm_Kinked17mm_Test9.csv',Data_10mm_29cm_Kinked17mm.Test9Data);
csvwrite('10mm_29cm_Kinked17mm_Test10.csv',Data_10mm_29cm_Kinked17mm.Test10Data);

%% 2022 Jan 10: 10mm 29cm Kinked28mm Raw Data. Convert .mat to csv
Data_10mm_29cm_Kinked28mm = load('2022Jan10_10mm_29cm_Kinked28mm_Data.mat');
csvwrite('10mm_29cm_Kinked28mm_Offset.csv',Data_10mm_29cm_Kinked28mm.Offset);
csvwrite('10mm_29cm_Kinked28mm_Test1.csv',Data_10mm_29cm_Kinked28mm.Test1Data);
csvwrite('10mm_29cm_Kinked28mm_Test2.csv',Data_10mm_29cm_Kinked28mm.Test2Data);
csvwrite('10mm_29cm_Kinked28mm_Test3.csv',Data_10mm_29cm_Kinked28mm.Test3Data);
csvwrite('10mm_29cm_Kinked28mm_Test4.csv',Data_10mm_29cm_Kinked28mm.Test4Data);
csvwrite('10mm_29cm_Kinked28mm_Test5.csv',Data_10mm_29cm_Kinked28mm.Test5Data);
csvwrite('10mm_29cm_Kinked28mm_Test6.csv',Data_10mm_29cm_Kinked28mm.Test6Data);
csvwrite('10mm_29cm_Kinked28mm_Test7.csv',Data_10mm_29cm_Kinked28mm.Test7Data);
csvwrite('10mm_29cm_Kinked28mm_Test8.csv',Data_10mm_29cm_Kinked28mm.Test8Data);
csvwrite('10mm_29cm_Kinked28mm_Test9.csv',Data_10mm_29cm_Kinked28mm.Test9Data);
csvwrite('10mm_29cm_Kinked28mm_Test10.csv',Data_10mm_29cm_Kinked28mm.Test10Data);
%% 2022 Jan 10: 10mm 29cm Kinked41mm Raw Data. Convert .mat to csv 

Data_10mm_29cm_Kinked41mm = load('2022Jan10_10mm_29cm_Kinked41mm_Data.mat');
csvwrite('10mm_29cm_Kinked41mm_Offset.csv',Data_10mm_29cm_Kinked41mm.Offset);
csvwrite('10mm_29cm_Kinked41mm_Test1.csv',Data_10mm_29cm_Kinked41mm.Test1Data);
csvwrite('10mm_29cm_Kinked41mm_Test2.csv',Data_10mm_29cm_Kinked41mm.Test2Data);
csvwrite('10mm_29cm_Kinked41mm_Test3.csv',Data_10mm_29cm_Kinked41mm.Test3Data);
csvwrite('10mm_29cm_Kinked41mm_Test4.csv',Data_10mm_29cm_Kinked41mm.Test4Data);
csvwrite('10mm_29cm_Kinked41mm_Test5.csv',Data_10mm_29cm_Kinked41mm.Test5Data);
csvwrite('10mm_29cm_Kinked41mm_Test6.csv',Data_10mm_29cm_Kinked41mm.Test6Data);
csvwrite('10mm_29cm_Kinked41mm_Test7.csv',Data_10mm_29cm_Kinked41mm.Test7Data);
csvwrite('10mm_29cm_Kinked41mm_Test8.csv',Data_10mm_29cm_Kinked41mm.Test8Data);
csvwrite('10mm_29cm_Kinked41mm_Test9.csv',Data_10mm_29cm_Kinked41mm.Test9Data);
csvwrite('10mm_29cm_Kinked41mm_Test10.csv',Data_10mm_29cm_Kinked41mm.Test10Data);
%#############################################################################################
%%  2022 Jan 10: 10mm 27cm Unkinked Raw Data. Convert .mat to csv 

Data_10mm_27cm_Unkinked = load('2022Jan10_10mm_27cm_Data.mat');

csvwrite('10mm_27cm_Unkinked_Offset.csv',Data_10mm_27cm_Unkinked.Offset);
csvwrite('10mm_27cm_Unkinked_Test1.csv',Data_10mm_27cm_Unkinked.Test1Data);
csvwrite('10mm_27cm_Unkinked_Test2.csv',Data_10mm_27cm_Unkinked.Test2Data);
csvwrite('10mm_27cm_Unkinked_Test3.csv',Data_10mm_27cm_Unkinked.Test3Data);
csvwrite('10mm_27cm_Unkinked_Test4.csv',Data_10mm_27cm_Unkinked.Test4Data);
csvwrite('10mm_27cm_Unkinked_Test5.csv',Data_10mm_27cm_Unkinked.Test5Data);
csvwrite('10mm_27cm_Unkinked_Test6.csv',Data_10mm_27cm_Unkinked.Test6Data);
csvwrite('10mm_27cm_Unkinked_Test7.csv',Data_10mm_27cm_Unkinked.Test7Data);
csvwrite('10mm_27cm_Unkinked_Test8.csv',Data_10mm_27cm_Unkinked.Test8Data);
csvwrite('10mm_27cm_Unkinked_Test9.csv',Data_10mm_27cm_Unkinked.Test9Data);
csvwrite('10mm_27cm_Unkinked_Test10.csv',Data_10mm_27cm_Unkinked.Test10Data);

%% 2022 Jan 10: 10mm 27 cm Kinked 7mm Raw Data. Convert .mat to csv. 
Data_10mm_27cm_Kinked7mm = load('2022Jan10_10mm_27cm_Data.mat');

csvwrite('10mm_27cm_Kinked7mm_Offset.csv',Data_10mm_27cm_Kinked7mm.Offset);
csvwrite('10mm_27cm_Kinked7mm_Test1.csv',Data_10mm_27cm_Kinked7mm.Test1Data);
csvwrite('10mm_27cm_Kinked7mm_Test2.csv',Data_10mm_27cm_Kinked7mm.Test2Data);
csvwrite('10mm_27cm_Kinked7mm_Test3.csv',Data_10mm_27cm_Kinked7mm.Test3Data);
csvwrite('10mm_27cm_Kinked7mm_Test4.csv',Data_10mm_27cm_Kinked7mm.Test4Data);
csvwrite('10mm_27cm_Kinked7mm_Test5.csv',Data_10mm_27cm_Kinked7mm.Test5Data);
csvwrite('10mm_27cm_Kinked7mm_Test6.csv',Data_10mm_27cm_Kinked7mm.Test6Data);
csvwrite('10mm_27cm_Kinked7mm_Test7.csv',Data_10mm_27cm_Kinked7mm.Test7Data);
csvwrite('10mm_27cm_Kinked7mm_Test8.csv',Data_10mm_27cm_Kinked7mm.Test8Data);
csvwrite('10mm_27cm_Kinked7mm_Test9.csv',Data_10mm_27cm_Kinked7mm.Test9Data);
csvwrite('10mm_27cm_Kinked7mm_Test10.csv',Data_10mm_27cm_Kinked7mm.Test10Data);

%%  2022 Jan 10: 10mm 27 cm Kinked 15mm Raw Data. Convert .mat to csv. 
Data_10mm_27cm_Kinked15mm = load('2022Jan10_10mm_27cm_Kinked15mm_Data.mat');

csvwrite('10mm_27cm_Kinked15mm_Offset.csv',Data_10mm_27cm_Kinked15mm.Offset);
csvwrite('10mm_27cm_Kinked15mm_Test1.csv',Data_10mm_27cm_Kinked15mm.Test1Data);
csvwrite('10mm_27cm_Kinked15mm_Test2.csv',Data_10mm_27cm_Kinked15mm.Test2Data);
csvwrite('10mm_27cm_Kinked15mm_Test3.csv',Data_10mm_27cm_Kinked15mm.Test3Data);
csvwrite('10mm_27cm_Kinked15mm_Test4.csv',Data_10mm_27cm_Kinked15mm.Test4Data);
csvwrite('10mm_27cm_Kinked15mm_Test5.csv',Data_10mm_27cm_Kinked15mm.Test5Data);
csvwrite('10mm_27cm_Kinked15mm_Test6.csv',Data_10mm_27cm_Kinked15mm.Test6Data);
csvwrite('10mm_27cm_Kinked15mm_Test7.csv',Data_10mm_27cm_Kinked15mm.Test7Data);
csvwrite('10mm_27cm_Kinked15mm_Test8.csv',Data_10mm_27cm_Kinked15mm.Test8Data);
csvwrite('10mm_27cm_Kinked15mm_Test9.csv',Data_10mm_27cm_Kinked15mm.Test9Data);
csvwrite('10mm_27cm_Kinked15mm_Test10.csv',Data_10mm_27cm_Kinked15mm.Test10Data);

%% 2022 Jan 10: 10mm 27 cm Kinked 31mm Raw Data. Convert .mat to csv.
Data_10mm_27cm_Kinked31mm = load('2022Jan10_10mm_27cm_Kinked31mm_Data.mat');

csvwrite('10mm_27cm_Kinked31mm_Offset.csv',Data_10mm_27cm_Kinked31mm.Offset);
csvwrite('10mm_27cm_Kinked31mm_Test1.csv',Data_10mm_27cm_Kinked31mm.Test1Data);
csvwrite('10mm_27cm_Kinked31mm_Test2.csv',Data_10mm_27cm_Kinked31mm.Test2Data);
csvwrite('10mm_27cm_Kinked31mm_Test3.csv',Data_10mm_27cm_Kinked31mm.Test3Data);
csvwrite('10mm_27cm_Kinked31mm_Test4.csv',Data_10mm_27cm_Kinked31mm.Test4Data);
csvwrite('10mm_27cm_Kinked31mm_Test5.csv',Data_10mm_27cm_Kinked31mm.Test5Data);
csvwrite('10mm_27cm_Kinked31mm_Test6.csv',Data_10mm_27cm_Kinked31mm.Test6Data);
csvwrite('10mm_27cm_Kinked31mm_Test7.csv',Data_10mm_27cm_Kinked31mm.Test7Data);
csvwrite('10mm_27cm_Kinked31mm_Test8.csv',Data_10mm_27cm_Kinked31mm.Test8Data);
csvwrite('10mm_27cm_Kinked31mm_Test9.csv',Data_10mm_27cm_Kinked31mm.Test9Data);
csvwrite('10mm_27cm_Kinked31mm_Test10.csv',Data_10mm_27cm_Kinked31mm.Test10Data);