Data_10mm_13cm_Unkinked_Test4 = csvread('10mm_13cm_Unkinked_Test4.csv');
    Force_10mm_13cm_Unkinked_Test4_Wrong = Data_10mm_13cm_Unkinked_Test4(:,1);
    Force_10mm_13cm_Unkinked_Test4_A0=((Force_10mm_13cm_Unkinked_Test4_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test4_Offset = Force_10mm_13cm_Unkinked_Test4_A0 - min(Force_10mm_13cm_Unkinked_Test3_A0);
    Force_10mm_13cm_Unkinked_Test4 = (((Force_10mm_13cm_Unkinked_Test4_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test4 =Data_10mm_13cm_Unkinked_Test4(:,2);
    Time_10mm_13cm_Unkinked_Test4 = Data_10mm_13cm_Unkinked_Test4(:,3)
    Force_10mm_13cm_Unkinked_Test4 = (((Force_10mm_13cm_Unkinked_Test4_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)