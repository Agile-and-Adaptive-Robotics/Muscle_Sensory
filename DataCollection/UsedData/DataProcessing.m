%This code modifies the data collected into a consistent pressure(kPa) and
%load (N) 
%% 10mm 13cm BPA (Force column needs to be mod)
Data_10mm_13cm_Unkinked_Test9 = csvread('10mm_13cm_Unkinked_Test9.csv');
    Force_10mm_13cm_Unkinked_Test9_Wrong = Data_10mm_13cm_Unkinked_Test9(:,1);
    Force_10mm_13cm_Unkinked_Test9_A0=((Force_10mm_13cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test9 = (((Force_10mm_13cm_Unkinked_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test9 =Data_10mm_13cm_Unkinked_Test9(:,2);
    Time_10mm_13cm_Unkinked_Test9 = Data_10mm_13cm_Unkinked_Test9(:,3);
    
    figure
    suptitle('10mm 13cm BPA Static Pressure and Force')
    subplot 221
    yyaxis left
    plot(Time_10mm_13cm_Unkinked_Test9,Force_10mm_13cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Unkinked_Test9,Pressure_10mm_13cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off   
%kinked 4mm    
Data_10mm_13cm_Kinked4mm_Test9 = csvread('10mm_13cm_Kinked4mm_Test9.csv');
    Force_10mm_13cm_Kinked4mm_Test9_Wrong = Data_10mm_13cm_Kinked4mm_Test9(:,1);
    Force_10mm_13cm_Kinked4mm_Test9_A0=((Force_10mm_13cm_Kinked4mm_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Kinked4mm_Test9 = (((Force_10mm_13cm_Kinked4mm_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Kinked4mm_Test9 =Data_10mm_13cm_Kinked4mm_Test9(:,2);
    Time_10mm_13cm_Kinked4mm = Data_10mm_13cm_Kinked4mm_Test9(:,3);
    
    subplot 222
    yyaxis left
    plot(Time_10mm_13cm_Kinked4mm,Force_10mm_13cm_Kinked4mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Kinked4mm,Pressure_10mm_13cm_Kinked4mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 4mm Force and Pressure vs Time')
    hold off   
 %Kinked 8mm
 Data_10mm_13cm_Kinked8mm_Test9 = csvread('10mm_13cm_Kinked8mm_Test9.csv');
    Force_10mm_13cm_Kinked8mm_Test9_Wrong = Data_10mm_13cm_Kinked8mm_Test9(:,1);
    Force_10mm_13cm_Kinked8mm_Test9_A0=((Force_10mm_13cm_Kinked8mm_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Kinked8mm_Test9 = (((Force_10mm_13cm_Kinked8mm_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Kinked8mm_Test9 =Data_10mm_13cm_Kinked8mm_Test9(:,2);
    Time_10mm_13cm_Kinked8mm = Data_10mm_13cm_Kinked8mm_Test9(:,3);
    
    subplot 223
    yyaxis left
    plot(Time_10mm_13cm_Kinked8mm,Force_10mm_13cm_Kinked8mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Kinked8mm,Pressure_10mm_13cm_Kinked8mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 8mm Force and Pressure vs Time')
    hold off   
 %Kinked 12mm
 Data_10mm_13cm_Kinked12mm_Test9 = csvread('10mm_13cm_Kinked12mm_Test9.csv');
    Force_10mm_13cm_Kinked12mm_Test9_Wrong = Data_10mm_13cm_Kinked12mm_Test9(:,1);
    Force_10mm_13cm_Kinked12mm_Test9_A0=((Force_10mm_13cm_Kinked12mm_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Kinked12mm_Test9 = (((Force_10mm_13cm_Kinked12mm_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Kinked12mm_Test9 =Data_10mm_13cm_Kinked12mm_Test9(:,2);
    Time_10mm_13cm_Kinked12mm = Data_10mm_13cm_Kinked12mm_Test9(:,3);
    
    subplot 224
    yyaxis left
    plot(Time_10mm_13cm_Kinked12mm,Force_10mm_13cm_Kinked12mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Kinked12mm,Pressure_10mm_13cm_Kinked12mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 12mm Force and Pressure vs Time')
    hold off  
%% 10mm 23cm BPA (Force column = Arduino Output)
%Unkink
Data_10mm_23cm_Unkinked_Test9 = csvread('10mm_23cm_Unkinked_Test9.csv');
    Force_10mm_23cm_Unkinked_Test9_Wrong = Data_10mm_23cm_Unkinked_Test9(:,1);
    Force_10mm_23cm_Unkinked_Test9_A0=((Force_10mm_23cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_23cm_Unkinked_Test9 = (((Force_10mm_23cm_Unkinked_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_23cm_Unkinked_Test9 =Data_10mm_23cm_Unkinked_Test9(:,2);
    Time_10mm_23cm_Unkinked_Test9 = Data_10mm_23cm_Unkinked_Test9(:,3);
    
    figure
    suptitle('10mm 23cm BPA')
    subplot 311
    title('10mm 13cm BPA Static Pressure and Force')
    yyaxis left
    plot(Time_10mm_23cm_Unkinked_Test9,Force_10mm_23cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_23cm_Unkinked_Test9,Pressure_10mm_23cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off    
    
%Kinked 14mm
Data_10mm_23cm_Kinked14mm_Test9 = csvread('10mm_23cm_Kinked14mm_Test9.csv');
    Force_10mm_23cm_Kinked14mm_Test9_Wrong = Data_10mm_23cm_Kinked14mm_Test9(:,1);
    Force_10mm_23cm_Kinke14mm_Test9_A0=((Force_10mm_23cm_Kinked14mm_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_23cm_Kinked14mm_Test9 = (((Force_10mm_23cm_Kinke14mm_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_23cm_Kinked14mm_Test9 =Data_10mm_23cm_Kinked14mm_Test9(:,2);
    Time_10mm_23cm_Kinked14mm_Test9 = Data_10mm_23cm_Kinked14mm_Test9(:,3);
    
    subplot 312
    title('10mm 13cm BPA Static Pressure and Force')
    yyaxis left
    plot(Time_10mm_23cm_Kinked14mm_Test9,Force_10mm_23cm_Kinked14mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_23cm_Kinked14mm_Test9,Pressure_10mm_23cm_Kinked14mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked14mm Force and Pressure vs Time')
    hold off    
%Kinked 30mm
Data_10mm_23cm_Kinked30mm_Test9 = csvread('10mm_23cm_Kinked30mm_Test9.csv');
    Force_10mm_23cm_Kinked30mm_Test9_Wrong = Data_10mm_23cm_Kinked30mm_Test9(:,1);
    Force_10mm_23cm_Kinke30mm_Test9_A0=((Force_10mm_23cm_Kinked30mm_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_23cm_Kinked30mm_Test9 = (((Force_10mm_23cm_Kinke30mm_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_23cm_Kinked30mm_Test9 =Data_10mm_23cm_Kinked30mm_Test9(:,2);
    Time_10mm_23cm_Kinked30mm_Test9 = Data_10mm_23cm_Kinked30mm_Test9(:,3);
    
    subplot 313
    title('10mm 13cm BPA Static Pressure and Force')
    yyaxis left
    plot(Time_10mm_23cm_Kinked30mm_Test9,Force_10mm_23cm_Kinked30mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_23cm_Kinked30mm_Test9,Pressure_10mm_23cm_Kinked30mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 30mm Force and Pressure vs Time')
    hold off    
%% 10mm 30cm BPA (Force =  Arduino Output)
Data_10mm_30cm_Unkinked_Test9 = csvread('10mm_30cm_Unkinked_Test9.csv');
    Force_10mm_30cm_Unkinked_Test9_Wrong = Data_10mm_30cm_Unkinked_Test9(:,1);
    Force_10mm_30cm_Unkinked_Test9_A0=((Force_10mm_30cm_Unkinked_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_30cm_Unkinked_Test9 = (((Force_10mm_30cm_Unkinked_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_30cm_Unkinked_Test9 =Data_10mm_30cm_Unkinked_Test9(:,2);
    Time_10mm_30cm_Unkinked_Test9 = Data_10mm_30cm_Unkinked_Test9(:,3);
    
    figure
    subplot 221
    suptitle('10mm 30cm BPA Pressure and Force')
    yyaxis left
    plot(Time_10mm_30cm_Unkinked_Test9,Force_10mm_30cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_30cm_Unkinked_Test9,Pressure_10mm_30cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off    
%Kinked 12mm
Data_10mm_30cm_Kinked12mm_Test9 = csvread('10mm_30cm_Kinked12mm_Test9.csv');
    Force_10mm_30cm_Kinked12mm_Test9_Wrong = Data_10mm_30cm_Kinked12mm_Test9(:,1);
    Force_10mm_30cm_Kinked12mm_A0=((Force_10mm_30cm_Kinked12mm_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_30cm_Kinked12mm_Test9 = (((Force_10mm_30cm_Kinked12mm_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_30cm_Kinked12mm =Data_10mm_30cm_Kinked12mm_Test9(:,2);
    Time_10mm_30cm_Kinked12mm_Test9 = Data_10mm_30cm_Kinked12mm_Test9(:,3);
    
    subplot 222
    yyaxis left
    plot(Time_10mm_30cm_Kinked12mm_Test9,Force_10mm_30cm_Kinked12mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_30cm_Kinked12mm_Test9,Pressure_10mm_30cm_Kinked12mm)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 12mm Force and Pressure vs Time')
    hold off   
%Kinked 22mm
Data_10mm_30cm_Kinked22mm_Test9 = csvread('10mm_30cm_Kinked22mm_Test9.csv');
    Force_10mm_30cm_Kinked22mm_Test9_Wrong = Data_10mm_30cm_Kinked22mm_Test9(:,1);
    Force_10mm_30cm_Kinked22mm_A0=((Force_10mm_30cm_Kinked22mm_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_30cm_Kinked22mm_Test9 = (((Force_10mm_30cm_Kinked22mm_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_30cm_Kinked22mm =Data_10mm_30cm_Kinked22mm_Test9(:,2);
    Time_10mm_30cm_Kinked22mm_Test9 = Data_10mm_30cm_Kinked22mm_Test9(:,3);
    
   	subplot 223
    yyaxis left
    plot(Time_10mm_30cm_Kinked22mm_Test9,Force_10mm_30cm_Kinked22mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_30cm_Kinked22mm_Test9,Pressure_10mm_30cm_Kinked22mm)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 22mm Force and Pressure vs Time')
    hold off   
%Kinked 33mm
Data_10mm_30cm_Kinked33mm_Test9 = csvread('10mm_30cm_Kinked33mm_Test9.csv');
    Force_10mm_30cm_Kinked33mm_Test9_Wrong = Data_10mm_30cm_Kinked33mm_Test9(:,1);
    Force_10mm_30cm_Kinked33mm_A0=((Force_10mm_30cm_Kinked33mm_Test9_Wrong));%/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_30cm_Kinked33mm_Test9 = (((Force_10mm_30cm_Kinked33mm_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_30cm_Kinked33mm =Data_10mm_30cm_Kinked33mm_Test9(:,2);
    Time_10mm_30cm_Kinked33mm_Test9 = Data_10mm_30cm_Kinked33mm_Test9(:,3);
    
    subplot 224
    yyaxis left
    plot(Time_10mm_30cm_Kinked33mm_Test9,Force_10mm_30cm_Kinked33mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_30cm_Kinked33mm_Test9,Pressure_10mm_30cm_Kinked33mm)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked 33mm Force and Pressure vs Time')
    hold off    