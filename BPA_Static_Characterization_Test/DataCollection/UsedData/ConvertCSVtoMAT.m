%Load CSV files into MATLAB workspace

clear; close all; clc;
%% Initial parameters
dia = '10';

%remove low force and pressure data data
low_force = 3; %removing force below this value
high_pressure = 800; %remove pressure above this value 

num = 50; %number of rows

%% BPA info
Cut = {'13','23','27','29','30'};  %Cut lengths
lo = [12,22,26,28.1,28.1]'; %resting lengths for 10mm BPA
li = cell(length(lo),1);     %inflated length
l620 = zeros(length(lo),1);  %fully inflated length
% Kinks = cell(length(lo),1);  %string name

%10cm    
Kinks{1,:} = {'13cm_Unkinked_Test','13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test'};
li{1} = [12,11.6,11.2,10.8];  %initial kink lengths for 10mm 13cm
l620(1) = 10; 
vals{1}= [0,4,8,12];

%23 cm
Kinks{2,:} = {'27cm_Unkinked_Test', '27cm_Kinked7mm_Test','27cm_Kinked15mm_Test','27cm_Kinked31mm_Test'};
vals{2}= [0,14,30];
l620(2) = 18.5;
li{2} = [22,20.5,18.9];

%27cm
Kinks{3,:} = {'27cm_Unkinked_Test', '27cm_Kinked7mm_Test','27cm_Kinked15mm_Test','27cm_Kinked31mm_Test'};
vals{3}= [0,7,15,31];
lo(3) = 25.7;
l620(3) = 21.8;
li{3} = [25.7,25,24.2,22.6];

%29cm
Kinks{4,:} = {'29cm_Unkinked_Test', '29cm_Kinked17mm_Test','29cm_Kinked28mm_Test','29cm_Kinked41mm_Test'};
vals{4}=[0,17,28,41];
lo(4) = 28.1;
l620(4) = 23.6;
li{4} = [28.1,26.4,25.3,24];
    
%30cm
Kinks{5,:} = {'30cm_Unkinked_Test','30cm_Kinked12mm_Test','30cm_Kinked22mm_Test','30cm_Kinked33mm_Test'}; 
lo(5) = 28.1;
l620(5) = 24;
li{5} = [28.1,26.9,25.9,24.8];

maxE = (lo-l620)./lo;
for i = 1:length(Cut)
    for j = 1:length(li{i})
      relE{i,j} = ((lo(i)-li{i}(j))./lo(i))./maxE(i);
    end
end


test = ["9", "10"];

[a,b] = size(relE);
c = length(test);
T = cell(a,b,c);
for k = 1:length(test)
    for j = 1:length(Cut)
        for i = 1:length(li{j})
         str ="10mm_"+(string(Kinks{j}{1,i})+test(k)+".csv");   
         M = readmatrix(str);
         M = M((M(:,3)<=17 &M(:,1)>low_force &M(:,2)<high_pressure),:);
         M = imresize(M,[num 3]);
         M = [ones(length(M),1).*relE{j,i}(:), M(:,2), M(:,1), M(:,3)];
         T{j,i,k} = M(:,:);
        end
    end
end


%% plots to check data



% 10mm 13cm
    figure
    subplot 121
    plot(T(:,4,i),T(:,3,i),'b.');
    xlabel('time (s)')
    ylabel('Force(N)')
    title('10mm 13cm Pressurizing - all kinks')
    subplot 122
    plot(AllBPA10mm13cm_DP(:,3),AllBPA10mm13cm_DP(:,1),'r.');
    title('10mm 13cm Depressurizing - all kinks')
    xlabel('time (s)')
    ylabel('Force(N)')
% 10mm 23cm
    figure
    subplot 121
    plot(AllBPA10mm23cm(:,4),AllBPA10mm23cm(:,3),'bo');
    subplot 122
    plot(AllBPA10mm23cm_DP(:,3),AllBPA10mm23cm_DP(:,1),'ro');
    title('10mm23cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
% 10mm 27cm
    figure
    subplot 121
    plot(AllBPA10mm27cm(:,4),AllBPA10mm27cm(:,3),'bo');
    subplot 122
    plot(AllBPA10mm27cm_DP(:,3),AllBPA10mm27cm_DP(:,1),'ro');
    title('10mm27cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
%10mm 29cm
    figure
    subplot 121
    plot(AllBPA10mm29cm(:,4),AllBPA10mm29cm(:,3),'bo');
    subplot 122
    plot(AllBPA10mm29cm_DP(:,3),AllBPA10mm29cm_DP(:,1),'ro');
    title('10mm29cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on

%10mm 30cm
    figure
    subplot 121
    plot(AllBPA10mm30cm(:,4),AllBPA10mm30cm(:,3),'bo');
    subplot 122
    plot(AllBPA10mm30cm_DP(:,3),AllBPA10mm30cm_DP(:,1),'ro');
    title('10mm30cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on




