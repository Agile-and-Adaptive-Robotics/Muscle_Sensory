% This script reads csv file and convert data into proper Pressure(kPa)and
% Force(N). 10mm Data. 
Data_10mm_13cm_Unkinked_Test1 = csvread('10mm_13cm_Unkinked_Test1.csv');
Data_10mm_13cm_Unkinked_Test1([1:150],:)=[];
    Force_10mm_13cm_Unkinked_Test1_Wrong = Data_10mm_13cm_Unkinked_Test1(:,1);
    Force_10mm_13cm_Unkinked_Test1_A0=((Force_10mm_13cm_Unkinked_Test1_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test1_Offset = Force_10mm_13cm_Unkinked_Test1_A0 - min(Force_10mm_13cm_Unkinked_Test1_A0);
    Force_10mm_13cm_Unkinked_Test1 = (((Force_10mm_13cm_Unkinked_Test1_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test1 =Data_10mm_13cm_Unkinked_Test1(:,2);
    Time_10mm_13cm_Unkinked_Test1 = Data_10mm_13cm_Unkinked_Test1(:,3);
Data_10mm_13cm_Unkinked_Test2 = csvread('10mm_13cm_Unkinked_Test2.csv');
    Force_10mm_13cm_Unkinked_Test2_Wrong = Data_10mm_13cm_Unkinked_Test2(:,1);
    Force_10mm_13cm_Unkinked_Test2_A0=((Force_10mm_13cm_Unkinked_Test2_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test2_Offset = Force_10mm_13cm_Unkinked_Test2_A0 - min(Force_10mm_13cm_Unkinked_Test2_A0);
    Force_10mm_13cm_Unkinked_Test2 = (((Force_10mm_13cm_Unkinked_Test2_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test1 =Data_10mm_13cm_Unkinked_Test2(:,2);
    Time_10mm_13cm_Unkinked_Test2 = Data_10mm_13cm_Unkinked_Test2(:,3);
Data_10mm_13cm_Unkinked_Test3 = csvread('10mm_13cm_Unkinked_Test3.csv');
    Force_10mm_13cm_Unkinked_Test3_Wrong = Data_10mm_13cm_Unkinked_Test3(:,1);
    Force_10mm_13cm_Unkinked_Test3_A0=((Force_10mm_13cm_Unkinked_Test3_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test3_Offset = Force_10mm_13cm_Unkinked_Test3_A0 - min(Force_10mm_13cm_Unkinked_Test3_A0);
    Force_10mm_13cm_Unkinked_Test3 = (((Force_10mm_13cm_Unkinked_Test3_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test3 =Data_10mm_13cm_Unkinked_Test3(:,2);
    Time_10mm_13cm_Unkinked_Test3 = Data_10mm_13cm_Unkinked_Test3(:,3)
    Force_10mm_13cm_Unkinked_Test3 = (((Force_10mm_13cm_Unkinked_Test3_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test4 = csvread('10mm_13cm_Unkinked_Test4.csv');
    Force_10mm_13cm_Unkinked_Test4_Wrong = Data_10mm_13cm_Unkinked_Test4(:,1);
    Force_10mm_13cm_Unkinked_Test4_A0=((Force_10mm_13cm_Unkinked_Test4_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test4_Offset = Force_10mm_13cm_Unkinked_Test4_A0 - min(Force_10mm_13cm_Unkinked_Test3_A0);
    Force_10mm_13cm_Unkinked_Test4 = (((Force_10mm_13cm_Unkinked_Test4_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test4 =Data_10mm_13cm_Unkinked_Test4(:,2);
    Time_10mm_13cm_Unkinked_Test4 = Data_10mm_13cm_Unkinked_Test4(:,3)
    Force_10mm_13cm_Unkinked_Test4 = (((Force_10mm_13cm_Unkinked_Test4_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test5 = csvread('10mm_13cm_Unkinked_Test5.csv');
    Force_10mm_13cm_Unkinked_Test5_Wrong = Data_10mm_13cm_Unkinked_Test5(:,1);
    Force_10mm_13cm_Unkinked_Test5_A0=((Force_10mm_13cm_Unkinked_Test5_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test5_Offset = Force_10mm_13cm_Unkinked_Test5_A0 - min(Force_10mm_13cm_Unkinked_Test5_A0);
    Force_10mm_13cm_Unkinked_Test5 = (((Force_10mm_13cm_Unkinked_Test5_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test5 =Data_10mm_13cm_Unkinked_Test5(:,2);
    Time_10mm_13cm_Unkinked_Test5 = Data_10mm_13cm_Unkinked_Test5(:,3)
    Force_10mm_13cm_Unkinked_Test5 = (((Force_10mm_13cm_Unkinked_Test5_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test6 = csvread('10mm_13cm_Unkinked_Test6.csv');
    Force_10mm_13cm_Unkinked_Test6_Wrong = Data_10mm_13cm_Unkinked_Test6(:,1);
    Force_10mm_13cm_Unkinked_Test6_A0=((Force_10mm_13cm_Unkinked_Test6_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test6_Offset = Force_10mm_13cm_Unkinked_Test6_A0 - min(Force_10mm_13cm_Unkinked_Test6_A0);
    Force_10mm_13cm_Unkinked_Test6 = (((Force_10mm_13cm_Unkinked_Test6_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test6 =Data_10mm_13cm_Unkinked_Test6(:,2);
    Time_10mm_13cm_Unkinked_Test6 = Data_10mm_13cm_Unkinked_Test6(:,3)
    Force_10mm_13cm_Unkinked_Test6 = (((Force_10mm_13cm_Unkinked_Test6_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test7 = csvread('10mm_13cm_Unkinked_Test7.csv');
    Force_10mm_13cm_Unkinked_Test7_Wrong = Data_10mm_13cm_Unkinked_Test7(:,1);
    Force_10mm_13cm_Unkinked_Test7_A0=((Force_10mm_13cm_Unkinked_Test7_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test7_Offset = Force_10mm_13cm_Unkinked_Test7_A0 - min(Force_10mm_13cm_Unkinked_Test7_A0);
    Force_10mm_13cm_Unkinked_Test7 = (((Force_10mm_13cm_Unkinked_Test7_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test7 =Data_10mm_13cm_Unkinked_Test7(:,2);
    Time_10mm_13cm_Unkinked_Test7 = Data_10mm_13cm_Unkinked_Test7(:,3)
    Force_10mm_13cm_Unkinked_Test7 = (((Force_10mm_13cm_Unkinked_Test7_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test8 = csvread('10mm_13cm_Unkinked_Test8.csv');
    Force_10mm_13cm_Unkinked_Test8_Wrong = Data_10mm_13cm_Unkinked_Test8(:,1);
    Force_10mm_13cm_Unkinked_Test8_A0=((Force_10mm_13cm_Unkinked_Test8_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test8_Offset = Force_10mm_13cm_Unkinked_Test8_A0 - min(Force_10mm_13cm_Unkinked_Test8_A0);
    Force_10mm_13cm_Unkinked_Test8 = (((Force_10mm_13cm_Unkinked_Test8_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test8 =Data_10mm_13cm_Unkinked_Test8(:,2);
    Time_10mm_13cm_Unkinked_Test8 = Data_10mm_13cm_Unkinked_Test8(:,3)
    Force_10mm_13cm_Unkinked_Test8 = (((Force_10mm_13cm_Unkinked_Test8_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test9 = csvread('10mm_13cm_Unkinked_Test9.csv');
    Force_10mm_13cm_Unkinked_Test9_Wrong = Data_10mm_13cm_Unkinked_Test9(:,1);
    Force_10mm_13cm_Unkinked_Test9_A0=((Force_10mm_13cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test9_Offset = Force_10mm_13cm_Unkinked_Test9_A0 - min(Force_10mm_13cm_Unkinked_Test9_A0);
    Force_10mm_13cm_Unkinked_Test9 = (((Force_10mm_13cm_Unkinked_Test9_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test9 =Data_10mm_13cm_Unkinked_Test9(:,2);
    Time_10mm_13cm_Unkinked_Test9 = Data_10mm_13cm_Unkinked_Test9(:,3)
    Force_10mm_13cm_Unkinked_Test9 = (((Force_10mm_13cm_Unkinked_Test9_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
Data_10mm_13cm_Unkinked_Test10 = csvread('10mm_13cm_Unkinked_Test10.csv');
    Force_10mm_13cm_Unkinked_Test10_Wrong = Data_10mm_13cm_Unkinked_Test10(:,1);
    Force_10mm_13cm_Unkinked_Test10_A0=((Force_10mm_13cm_Unkinked_Test10_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test10_Offset = Force_10mm_13cm_Unkinked_Test10_A0 - min(Force_10mm_13cm_Unkinked_Test10_A0);
    Force_10mm_13cm_Unkinked_Test10 = (((Force_10mm_13cm_Unkinked_Test10_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test10 =Data_10mm_13cm_Unkinked_Test10(:,2);
    Time_10mm_13cm_Unkinked_Test10 = Data_10mm_13cm_Unkinked_Test10(:,3)
    Force_10mm_13cm_Unkinked_Test10 = (((Force_10mm_13cm_Unkinked_Test10_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)

figure
plot(Time_10mm_13cm_Unkinked_Test1,Force_10mm_13cm_Unkinked_Test1)
plot(Time_10mm_13cm_Unkinked_Test2,Force_10mm_13cm_Unkinked_Test2)
plot(Time_10mm_13cm_Unkinked_Test3,Force_10mm_13cm_Unkinked_Test3)
plot(Time_10mm_13cm_Unkinked_Test4,Force_10mm_13cm_Unkinked_Test4)
plot(Time_10mm_13cm_Unkinked_Test5,Force_10mm_13cm_Unkinked_Test5)
plot(Time_10mm_13cm_Unkinked_Test6,Force_10mm_13cm_Unkinked_Test6)
plot(Time_10mm_13cm_Unkinked_Test7,Force_10mm_13cm_Unkinked_Test7)
plot(Time_10mm_13cm_Unkinked_Test8,Force_10mm_13cm_Unkinked_Test8)
plot(Time_10mm_13cm_Unkinked_Test9,Force_10mm_13cm_Unkinked_Test9)
plot(Time_10mm_13cm_Unkinked_Test10,Force_10mm_13cm_Unkinked_Test10)





    
    