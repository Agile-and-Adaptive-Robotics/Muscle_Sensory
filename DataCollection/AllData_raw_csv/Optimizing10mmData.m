%Optimizing 10mm data
%plot(AllBPA10mm(:,2),AllBPA10mm(:,1)) %plotting all data for 10mm (all lengths and kinks)


%Curve Fitting via optimization
%Eg: model equation:  y = Aexp(-lamda*t); A & lamda are parameters to be
%tuned. To fit curve, we need to minimize sum of squared error
testnumber = 9;
kinks = [0,4,8,12]
data= AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==12&AllBPA10mm13cm(:,7)==testnumber,:);
data_pressure = data(:,2)
data_force = data(:,1)

%plot 
figure
plot(data_pressure,data_force,'o')
title('data')
xlabel('Pressure (kPa)')
ylabel('Force (N)')

%% using fmin search to optimize
fun = @(x)sseval(x,data_pressure,data_force);

%Finding best fitting parameters
x0 = [0.6184,-41.219] %random values 
bestx = fminsearch(fun,x0) %finding the

%Check fit quality
A = bestx(1); 
lambda = bestx(2);

yfit = A*data_pressure+lambda;
plot(data_pressure,data_force,'*');
hold on
plot(data_pressure,yfit,'r')
xlabel('Pressure(kPa)')
ylabel('Force data and Fit')
title('Data and Fitting curve for 10mm13cm0Kinks');
legend('Data','Fitted Curve')
hold off

