%Optimizing 10mm data
%plot(AllBPA10mm(:,2),AllBPA10mm(:,1)) %plotting all data for 10mm (all lengths and kinks)


%Curve Fitting via optimization
%Eg: model equation:  y = Aexp(-lamda*t); A & lamda are parameters to be
%tuned. To fit curve, we need to minimize sum of squared error
testnumber = 9;
li= 12;
lo= 10; 
kinks = [0,4,8,12] 
data= AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==4&AllBPA10mm13cm(:,7)==testnumber,:); %Data for optimization (F,P,t,d,l,kink,test#)
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
a0 = bestx(1); 
a1 = bestx(2);
%a2 = bestx(3);

%EQ1: 
yfit = a0*data_pressure+a1;
%EQ2: yfit = (a0+a1*(li -lo))*data_pressure;
plot(data_pressure,data_force,'*');
hold on
plot(data_pressure,yfit,'r')
xlabel('Pressure(kPa)')
ylabel('Force data and Fit')
title('Data and Fitting curve');
legend('Data','Fitted Curve')
hold off

