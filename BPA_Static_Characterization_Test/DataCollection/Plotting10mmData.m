%% Plotting Data 10mm 23cm

%Unkinked 
Data_10mm_23cm_Unkinked = csvread('10mm_23cm_UnkinkedRaw_Test10.csv');
Force_10mm_23cm_Unkinked = Data_10mm_23cm_Unkinked(:,1);
Pressure_10mm_23cm_Unkinked = Data_10mm_23cm_Unkinked(:,2);
Time_10mm_23cm_Unkinked = Data_10mm_23cm_Unkinked(:,3);
%Kinked 14mm
Data_10mm_23cm_Kinked14mm = csvread('10mm_23cm_Kinked14mm_Test10.csv');
Force_10mm_23cm_Kinked14mm = Data_10mm_23cm_Kinked14mm(:,1);
Pressure_10mm_23cm_Kinked14mm = Data_10mm_23cm_Kinked14mm(:,2);
Time_10mm_23cm_Kinked14mm = Data_10mm_23cm_Kinked14mm(:,3);
%Kinked 30mm
Data_10mm_23cm_Kinked30mm = csvread('10mm_23cm_Kinked30mm_Test10.csv');
Force_10mm_23cm_Kinked30mm = Data_10mm_23cm_Kinked30mm(:,1);
Pressure_10mm_23cm_Kinked30mm = Data_10mm_23cm_Kinked30mm(:,2);
Time_10mm_23cm_Kinked30mm = Data_10mm_23cm_Kinked30mm(:,3);
% plot 

figure
yyaxis left
plot(Time_10mm_23cm_Unkinked,Force_10mm_23cm_Unkinked)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_23cm_Unkinked,Pressure_10mm_23cm_Unkinked)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Unkinked Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_23cm_Kinked14mm,Force_10mm_23cm_Kinked14mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_23cm_Kinked14mm,Pressure_10mm_23cm_Kinked14mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Unkinked Force and Pressure vs Time')
hold off

figure 
yyaxis left
plot(Time_10mm_23cm_Kinked30mm,Force_10mm_23cm_Kinked30mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_23cm_Kinked30mm,Pressure_10mm_23cm_Kinked30mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Unkinked Force and Pressure vs Time')
hold off


%% 10mm 27 cm Jan 10
%Unkinked 
Data_10mm_27cm_Unkinked = csvread('10mm_27cm_Unkinked_Test10.csv');
Force_10mm_27cm_Unkinked = Data_10mm_27cm_Unkinked(:,1);
Pressure_10mm_27cm_Unkinked = Data_10mm_27cm_Unkinked(:,2);
Time_10mm_27cm_Unkinked = Data_10mm_27cm_Unkinked(:,3);
%Kinked 7mm
Data_10mm_27cm_Kinked7mm = csvread('10mm_27cm_Kinked7mm_Test10.csv');
Force_10mm_27cm_Kinked7mm = Data_10mm_27cm_Kinked7mm(:,1);
Pressure_10mm_27cm_Kinked7mm = Data_10mm_27cm_Kinked7mm(:,2);
Time_10mm_27cm_Kinked7mm = Data_10mm_27cm_Kinked7mm(:,3);
%Kinked 15mm
Data_10mm_27cm_Kinked15mm = csvread('10mm_27cm_Kinked15mm_Test10.csv');
Force_10mm_27cm_Kinked15mm = Data_10mm_27cm_Kinked15mm(:,1);
Pressure_10mm_27cm_Kinked15mm = Data_10mm_27cm_Kinked15mm(:,2);
Time_10mm_27cm_Kinked15mm = Data_10mm_27cm_Kinked15mm(:,3);
%Kinked 31mm
Data_10mm_27cm_Kinked31mm = csvread('10mm_27cm_Kinked31mm_Test10.csv');
Force_10mm_27cm_Kinked31mm = Data_10mm_27cm_Kinked31mm(:,1);
Pressure_10mm_27cm_Kinked31mm = Data_10mm_27cm_Kinked31mm(:,2);
Time_10mm_27cm_Kinked31mm = Data_10mm_27cm_Kinked31mm(:,3);

figure
yyaxis left
plot(Time_10mm_27cm_Unkinked,Force_10mm_27cm_Unkinked)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_27cm_Unkinked,Pressure_10mm_27cm_Unkinked)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('27cm Unkinked Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_27cm_Kinked7mm,Force_10mm_27cm_Kinked7mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_27cm_Kinked7mm,Pressure_10mm_27cm_Kinked7mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 7mm Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_27cm_Kinked15mm,Force_10mm_27cm_Kinked15mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_27cm_Kinked15mm,Pressure_10mm_27cm_Kinked15mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 15mm Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_27cm_Kinked31mm,Force_10mm_27cm_Kinked31mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_27cm_Kinked31mm,Pressure_10mm_27cm_Kinked31mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 31mm Force and Pressure vs Time')
hold off
%% 10mm 29cm 

%Unkinked 
Data_10mm_29cm_Unkinked = csvread('10mm_29cm_Unkinked_Test10.csv');
Force_10mm_29cm_Unkinked = Data_10mm_29cm_Unkinked(:,1);
Pressure_10mm_29cm_Unkinked = Data_10mm_29cm_Unkinked(:,2);
Time_10mm_29cm_Unkinked = Data_10mm_29cm_Unkinked(:,3);
%Kinked 17mm
Data_10mm_29cm_Kinked17mm = csvread('10mm_29cm_Kinked17mm_Test10.csv');
Force_10mm_29cm_Kinked17mm = Data_10mm_29cm_Kinked17mm(:,1);
Pressure_10mm_29cm_Kinked17mm = Data_10mm_29cm_Kinked17mm(:,2);
Time_10mm_29cm_Kinked17mm = Data_10mm_29cm_Kinked17mm(:,3);
%Kinked 28mm
Data_10mm_29cm_Kinked28mm = csvread('10mm_29cm_Kinked28mm_Test10.csv');
Force_10mm_29cm_Kinked28mm = Data_10mm_29cm_Kinked28mm(:,1);
Pressure_10mm_29cm_Kinked28mm = Data_10mm_29cm_Kinked28mm(:,2);
Time_10mm_29cm_Kinked28mm = Data_10mm_29cm_Kinked28mm(:,3);
%Kinked 41mm
Data_10mm_29cm_Kinked41mm = csvread('10mm_29cm_Kinked41mm_Test10.csv');
Force_10mm_29cm_Kinked41mm = Data_10mm_29cm_Kinked41mm(:,1);
Pressure_10mm_29cm_Kinked41mm = Data_10mm_29cm_Kinked41mm(:,2);
Time_10mm_29cm_Kinked41mm = Data_10mm_29cm_Kinked41mm(:,3);

% plot 
figure
yyaxis left
plot(Time_10mm_29cm_Unkinked,Force_10mm_29cm_Unkinked)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_29cm_Unkinked,Pressure_10mm_29cm_Unkinked)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('29cm Unkinked Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_29cm_Kinked17mm,Force_10mm_29cm_Kinked17mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_29cm_Kinked17mm,Pressure_10mm_29cm_Kinked17mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 17mm Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_29cm_Kinked28mm,Force_10mm_29cm_Kinked28mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_29cm_Kinked28mm,Pressure_10mm_29cm_Kinked28mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 28mm Force and Pressure vs Time')
hold off

figure 
yyaxis left
plot(Time_10mm_29cm_Kinked41mm,Force_10mm_29cm_Kinked41mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_29cm_Kinked41mm,Pressure_10mm_29cm_Kinked41mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 41mm Force and Pressure vs Time')
hold off

%% 10mm 30cm

%Unkinked 
Data_10mm_30cm_Unkinked = csvread('10mm_30cm_Unkinked_Test10.csv');
Force_10mm_30cm_Unkinked = Data_10mm_30cm_Unkinked(:,1);
Pressure_10mm_30cm_Unkinked = Data_10mm_30cm_Unkinked(:,2);
Time_10mm_30cm_Unkinked = Data_10mm_30cm_Unkinked(:,3);
%Kinked 12mm
Data_10mm_30cm_Kinked12mm = csvread('10mm_30cm_Kinked12mm_Test10.csv');
Force_10mm_30cm_Kinked12mm = Data_10mm_30cm_Kinked12mm(:,1);
Pressure_10mm_30cm_Kinked12mm = Data_10mm_30cm_Kinked12mm(:,2);
Time_10mm_30cm_Kinked12mm = Data_10mm_30cm_Kinked12mm(:,3);
%Kinked 22mm
Data_10mm_30cm_Kinked22mm = csvread('10mm_30cm_Kinked22mm_Test10.csv');
Force_10mm_30cm_Kinked22mm = Data_10mm_30cm_Kinked22mm(:,1);
Pressure_10mm_30cm_Kinked22mm = Data_10mm_30cm_Kinked22mm(:,2);
Time_10mm_30cm_Kinked22mm = Data_10mm_30cm_Kinked22mm(:,3);
%Kinked 33mm
Data_10mm_30cm_Kinked33mm = csvread('10mm_30cm_Kinked33mm_Test10.csv');
Force_10mm_30cm_Kinked33mm = Data_10mm_30cm_Kinked33mm(:,1);
Pressure_10mm_30cm_Kinked33mm = Data_10mm_30cm_Kinked33mm(:,2);
Time_10mm_30cm_Kinked33mm = Data_10mm_30cm_Kinked33mm(:,3);

% plot 
figure
yyaxis left
plot(Time_10mm_30cm_Unkinked,Force_10mm_30cm_Unkinked)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_30cm_Unkinked,Pressure_10mm_30cm_Unkinked)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('30cm Unkinked Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_30cm_Kinked12mm,Force_10mm_30cm_Kinked12mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on
yyaxis right
plot(Time_10mm_30cm_Kinked12mm,Pressure_10mm_30cm_Kinked12mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 12mm Force and Pressure vs Time')
hold off

figure
yyaxis left
plot(Time_10mm_30cm_Kinked22mm,Force_10mm_30cm_Kinked22mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_30cm_Kinked22mm,Pressure_10mm_30cm_Kinked22mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 22mm Force and Pressure vs Time')
hold off

figure 
yyaxis left
plot(Time_10mm_30cm_Kinked33mm,Force_10mm_30cm_Kinked33mm)
ylim([-10,5000])
ylabel('Force(N)')
hold on

yyaxis right
plot(Time_10mm_30cm_Kinked33mm,Pressure_10mm_30cm_Kinked33mm)
ylim([-50,700])
ylabel('Pressure(kPa)')
legend('Force','Pressure')
title('Kinked 33mm Force and Pressure vs Time')
hold off