%% Optimizing Data - Curve fitting via optimization
close all;clc;
% BPA Parameters (parameters to enter to select a specific set of data)
    lo = 12;
    li = 10.8;
    l620 = 10;
    diameter = 10;
    lengths = 13;
    kink =12;  %kink 13cm = [0,4,8,12]
    initiallength =0;
    testnum = 9;
    state = 'DP'; %P= pressurizig, DP = depressurizing

 %extracting specific set of data
    data_chosen = data_select(diameter,lengths,kink,testnum,state); %selected diameter|length|state
    data_eval = eval(data_chosen);
    data = data_eval(data_eval(:,6)==kink& data_eval(:,7)==testnum,:); %selected kink|testnumber
     
 %Assigning P|F|t
    data_force = data(:,1);
    data_pressure = data(:,2);
    data_time = data(:,3);
    data_test = data(:,7);
    data_strain = data(:,12);
    data_relativestrain = data(:,13);
 %Plotting to check data
    figure
    plot(data_pressure,data_force,'b.')
    title(data_chosen)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
%% Optimization
% using fmin search to optimize data
fun = @(x)sseval(x,data_pressure,data_force,li,lo);

%Best fitting parameters(x0)
x0 = [0.6184,-41.219,2.1,3]; %random values (#of parameters = # of entries) 
bestx =fminsearch(fun,x0) 


%Test fit quality
a0 = bestx(1);
a1 = bestx(2);
a2 = bestx(3);
a3 = bestx(4);

yfit =  (a0 + a1*(li-lo)/lo)*data_pressure + a2*(li-lo)/lo + a3;

figure
plot(data_pressure, data_force,'*');
hold on
plot(data_pressure,yfit, 'r');
xlabel('Pressure(kPa)');
ylabel('Force (N)');
title('Data and Fitting Curve')
legend('Data','Fit');
grid on
hold off

    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    

