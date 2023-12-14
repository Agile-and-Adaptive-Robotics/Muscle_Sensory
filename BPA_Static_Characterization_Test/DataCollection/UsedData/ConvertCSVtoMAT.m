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
Kinks{2,:} = {'23cm_Unkinked_Test', '23cm_Kinked14mm_Test','23cm_Kinked30mm_Test'};
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


test = ["8", "9", "10"];

[a,b] = size(relE);
c = length(test);
T = cell(a,b,c);
for k = 1:length(test)
    for i = 1:length(Cut)
        for j = 1:length(li{i})
         str ="10mm_"+(string(Kinks{i}{1,j})+test(k)+".csv");   
         M = readmatrix(str);
         M = M((M(:,3)<=17 &M(:,1)>low_force &M(:,2)<high_pressure),:);  %keep values that are pressurizing (less than 17second, high than low force, lower than high pressure
         M = imresize(M,[num 3],'nearest');
         M = [ones(length(M),1).*relE{i,j}(:), M(:,2), M(:,1), M(:,3)];
         T{i,j,k} = M(:,:);
        end
    end
end


%% plots to check data


varS = ["Relative Strain", "Pressure (kPa)", "Force (N)", "Time (s)"];
cz = ["b", "m", "r"];
xAx = [4, 4, 1, 2];    %which subplots will use which varS for x-axis 
% 10mm 13cm
for i = 1:length(Cut)
    figure
    for a = 1:length(xAx)
    subplot(2,2,a)
    hold on
    x = xAx(a);
    y = 3;
    for j = 1:length(li{i})
        for k = 1:length(test)
            xx = T{i,j,k}(:,x);
            yy = T{i,j,k}(:,y);
            str1 = sprintf('%.2f rel. strain, test %s ',relE{i,j},test(k));
            scatter(xx,yy,[],cz(k),'DisplayName',str1);
        end
    end
    hold off
    xlabel(varS(x))
    ylabel(varS(y))
    str2 = sprintf('%.1fcm l_{rest}, %s vs. %s - all kinks',lo(i),varS(x),varS(y));
    title(str2)
    lgd = legend;
    end
end
    
