%% Optimizing Data - Curve fitting via optimization
close all;clc;
% BPA Parameters (parameters to enter to select a specific set of data)
    lo = 12;
    li = 10.8; %needs to be changed
    l620 = 10;
    diameter = 10;
    lengths = 13;
    %kink =12;  
    kink= [0,4,8,12];
    initiallength =0;
    testnum = 9;
    state = 'DP'; %P= pressurizig, DP = depressurizing
  
    data_chosen = data_select(diameter,lengths,kink,testnum,state); %choose diameter and length(All data) 
    data_eval = eval(data_chosen);
    data = cell(length(kink),1);
    
    for i =1:length(kink)
        data{i} = data_eval(data_eval(:,6)==kink(i)& data_eval(:,7)==testnum,:);
        data_force{i} = data{i}(:,1);
        data_pressure{i} = data{i}(:,2);
        data_time{i} = data{i}(:,3);
        data_test{i} = data{i}(:,7);
        data_strain{i} = data{i}(:,12);
        data_relativestrain{i} = data{i}(:,13);
        figure
        plot(data_pressure{i},data_force{i},'b.')
        title(data_chosen)
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        grid on
        
        % %% Optimization
% % using fmin search to optimize data
fun = @(x)sseval(x,data_pressure{i},data_force{i},li,lo);

%Best fitting parameters(x0)
x0 = [0.6184,-41.219,2.1,3]; %random values (#of parameters = # of entries) 
bestx =fminsearch(fun,x0) 

%Test fit quality
a0 = bestx(1);
a1 = bestx(2);
a2 = bestx(3);
a3 = bestx(4);

yfit{i} =  (a0 + a1*(li-lo)/lo)*data_pressure{i} + a2*(li-lo)/lo + a3;

figure
plot(data_pressure{i}, data_force{i},'*');
hold on
plot(data_pressure{i},yfit{i}, 'r');
xlabel('Pressure(kPa)');
ylabel('Force (N)');
title('Data and Fitting Curve')
legend('Data','Fit');
grid on
hold off

        
        
        
        
        
    end

 
% 
% % %% Optimization
% % % using fmin search to optimize data
% fun = @(x)sseval(x,data_pressure{i},data_force{i},li,lo);
% 
% %Best fitting parameters(x0)
% x0 = [0.6184,-41.219,2.1,3]; %random values (#of parameters = # of entries) 
% bestx =fminsearch(fun,x0) 
% 
% 
% %Test fit quality
% a0 = bestx(1);
% a1 = bestx(2);
% a2 = bestx(3);
% a3 = bestx(4);
% 
% yfit{i} =  (a0 + a1*(li-lo)/lo)*data_pressure{i} + a2*(li-lo)/lo + a3;
% 
% figure
% plot(data_pressure{i}, data_force{i},'*');
% hold on
% plot(data_pressure{i},yfit{i}, 'r');
% xlabel('Pressure(kPa)');
% ylabel('Force (N)');
% title('Data and Fitting Curve')
% legend('Data','Fit');
% grid on
% hold off

    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    

