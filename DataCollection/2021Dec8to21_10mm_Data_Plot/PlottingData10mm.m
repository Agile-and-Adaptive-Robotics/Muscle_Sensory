%Comparing 10mm BPA data for BPA length = 11.8cm measured between clamped
%ends
% Data structure: Force(N)| Pressure(kPa) | Time(s) 
UnkinkedData9 = csvread('10mm_Data9.csv');
    Unkinked_Force9 = UnkinkedData9(:,1);
    Unkinked_Pressure9 = UnkinkedData9(:,2);
    Unkinked_Time9 = UnkinkedData9(:,3);

UnkinkedData10 = csvread('10mm_Data10.csv');
    Unkinked_Force10 = UnkinkedData10(:,1);
    Unkinked_Pressure10 = UnkinkedData10(:,2);
    Unkinked_Time10 = UnkinkedData10(:,3);

KinkedData4mm9 = csvread('Kinked_04mmTest9Data.csv');
    Kinked4mm_Force9 = KinkedData4mm9(:,1);
    Kinked4mm_Pressure9 = KinkedData4mm9(:,2);
    Kinked4mm_Time9 = KinkedData4mm9(:,3);
    
KinkedData4mm10 = csvread('Kinked_04mmTest10Data.csv');
    Kinked4mm_Force10 = KinkedData4mm10(:,1);
    Kinked4mm_Pressure10 = KinkedData4mm10(:,2);
    Kinked4mm_Time10 = KinkedData4mm10(:,3);

KinkedData12mm9 = csvread('Kinked_12mmTest9Data.csv');
    Kinked12mm_Force9 = KinkedData12mm9(:,1);
    Kinked12mm_Pressure9 = KinkedData12mm9(:,2);
    Kinked12mm_Time9 = KinkedData12mm9(:,3);
    
KinkedData12mm10 = csvread('Kinked_12mmTest10Data.csv');
    Kinked12mm_Force10 = KinkedData12mm10(:,1);
    Kinked12mm_Pressure10 = KinkedData12mm10(:,2);
    Kinked12mm_Time10 = KinkedData12mm10(:,3);





%% Plotting Raw Data - Visualizing Unkinked and Kinked raw data
%Unkinked - Test 9 and 10
figure()
subplot(321)
yyaxis left
plot(Unkinked_Time9,Unkinked_Force9)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('10mm Unkinked  Test 9')
yyaxis right
ylabel('Pressure(kPa)')
plot(Unkinked_Time9,Unkinked_Pressure9)
hold off

subplot(322)
yyaxis left
plot(Unkinked_Time10,Unkinked_Force10)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('10mm Unkinked  Test 10')
yyaxis right
ylabel('Pressure(kPa)')
plot(Unkinked_Time10,Unkinked_Pressure10)
hold off



%Kinked - 4mm
subplot(323)
yyaxis left
plot(Kinked4mm_Time9,Kinked4mm_Force9)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('Kinked4mm')
yyaxis right
ylabel('Pressure(kPa)')
plot(Kinked4mm_Time9,Kinked4mm_Pressure9)
hold off

subplot(324)
yyaxis left
plot(Kinked4mm_Time10,Kinked4mm_Force10)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('Kinked4mm')
yyaxis right
ylabel('Pressure(kPa)')
plot(Kinked4mm_Time10,Kinked4mm_Pressure10)
hold off

%Kinked - 12mm
subplot(325)
yyaxis left
plot(Kinked12mm_Time9,Kinked12mm_Force9)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('Kinked12mm Test10')
yyaxis right
ylabel('Pressure(kPa)')
plot(Kinked12mm_Time9,Kinked12mm_Pressure9)
hold off

subplot(326)
yyaxis left
plot(Kinked12mm_Time10,Kinked12mm_Force10)
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('Kinked12mm Test10')
yyaxis right
ylabel('Pressure(kPa)')
plot(Kinked12mm_Time10,Kinked12mm_Pressure10)
hold off
%% Filtering Force Data - Comparing Pressure vs Force
figure()
subplot(221)
plot(Unkinked_Pressure9,Unkinked_Force9,'.k',Unkinked_Pressure10,Unkinked_Force10,'*r')
hold on
plot(Kinked4mm_Pressure9,Kinked4mm_Force9,'.k',Kinked4mm_Pressure10,Kinked4mm_Force10,'*b')
plot(Kinked12mm_Pressure9,Kinked12mm_Force9,'.k',Kinked12mm_Pressure10,Kinked12mm_Force10,'*g');
hold off
legend('UnkinkedTest9','UnkinkedTest10','Kinked 4mm Test9','Kinked 4mm Test 10','Kinked 12mm Test 9','Kinked 12mm Test 10','Location','NW');
title('Raw Data: Pressure vs Force');
grid on


% Filtering Force Signals [2,0.1]
[B,A] = butter(2,0.1);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);

subplot(222)
plot(Unkinked_Pressure9,Unkinked_Fforce9,'.k',Unkinked_Pressure9,Unkinked_Fforce10,'*r')
hold on
plot(Kinked4mm_Pressure9,Kinked4mm_Fforce9,'.k',Kinked4mm_Pressure9,Kinked4mm_Fforce10,'*b')
plot(Kinked12mm_Pressure9,Kinked12mm_Fforce9,'.k',Kinked12mm_Pressure9,Kinked12mm_Fforce10,'*g');
hold off
legend('UnkinkedTest9','Filtered','Kinked 4mm Test9','Filtered','Kinked 12mm Test 9','Filtered','Location','NW');
title('Filtered Data:[2,0.1] Pressure vs Force');
grid on


% Filtering Force Signals [2,0.5]
[B,A] = butter(2,0.5);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);
subplot(223)
plot(Unkinked_Pressure9,Unkinked_Fforce9,'.k',Unkinked_Pressure9,Unkinked_Fforce10,'*r')
hold on
plot(Kinked4mm_Pressure9,Kinked4mm_Fforce9,'.k',Kinked4mm_Pressure9,Kinked4mm_Fforce10,'*b')
plot(Kinked12mm_Pressure9,Kinked12mm_Fforce9,'.k',Kinked12mm_Pressure9,Kinked12mm_Fforce10,'*g');
hold off
legend('UnkinkedTest9','Filtered','Kinked 4mm Test9','Filtered','Kinked 12mm Test 9','Filtered','Location','NW');
title('Filtered Data:[2,0.5] Pressure vs Force');grid on;
% Filtering Force Signals [2,0.9]
[B,A] = butter(2,0.9);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);

subplot(224)
plot(Unkinked_Pressure9,Unkinked_Fforce9,'.k',Unkinked_Pressure9,Unkinked_Fforce10,'*r')
hold on
plot(Kinked4mm_Pressure9,Kinked4mm_Fforce9,'.k',Kinked4mm_Pressure9,Kinked4mm_Fforce10,'*b')
plot(Kinked12mm_Pressure9,Kinked12mm_Fforce9,'.k',Kinked12mm_Pressure9,Kinked12mm_Fforce10,'*g');
hold off
legend('UnkinkedTest9','Filtered','Kinked 4mm Test9','Filtered','Kinked 12mm Test 9','Filtered','Location','NW');
title('Filtered Data:[2,0.9] Pressure vs Force');grid on;

%% Comparing raw data vs filtered data
[B,A] = butter(2,0.1);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);

figure()
plot(Unkinked_Time9,Unkinked_Force9,'k')
ylabel('Force(N)')
hold on
xlabel('Time(s)')
title('Comparing filtered force signals')
plot(Unkinked_Time9,Unkinked_Fforce9,'.b')


[B,A] = butter(2,0.5);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);
plot(Unkinked_Time9,Unkinked_Fforce9,'.r')

[B,A] = butter(2,0.9);
Unkinked_Fforce9 = filter(B,A,Unkinked_Force9);
Unkinked_Fforce10 = filter(B,A,Unkinked_Force10);
Kinked4mm_Fforce9 = filter(B,A,Kinked4mm_Force9);
Kinked4mm_Fforce10 = filter(B,A,Kinked4mm_Force10);
Kinked12mm_Fforce9 = filter(B,A,Kinked12mm_Force9);
Kinked12mm_Fforce10 = filter(B,A,Kinked12mm_Force10);
plot(Unkinked_Time9,Unkinked_Fforce9,'.y')

hold off
legend('Unfiltered','Filtered [2,0.1]','[2,0.5]','[2,0.9]')


