%Plotting Data 10mm 23cm

%Unkinked 
Data_10mm_23cm_Unkinked = csvread('10mm_23cm_Unkinked_Test10.csv');
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

%% plot Unkinked
figure(1)
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

figure(2) 
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



