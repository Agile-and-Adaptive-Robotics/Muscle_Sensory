%Optimizing 10mm data
%plot(AllBPA10mm(:,2),AllBPA10mm(:,1)) %plotting all data for 10mm (all lengths and kinks)


%Curve Fitting via optimization
%Eg: model equation:  y = Aexp(-lamda*t); A & lamda are parameters to be
%tuned. To fit curve, we need to minimize sum of squared error
testnumber = 9;
cutlength = 13; %resting length
restinglength = 12;
lo = restinglength;
li = 12; %kink length
lo= 12; 
kinks = [0,4,8,12] 
data= AllBPA10mm13cm_DP(AllBPA10mm13cm_DP(:,5)==cutlength& AllBPA10mm13cm_DP(:,6)==0&AllBPA10mm13cm_DP(:,7)==testnumber,:); %Data for optimization (F,P,t,d,l,kink,test#,P/DP status)
data_pressure = data(:,2)
data_force = data(:,1)
data_time = data(:,3)

%plot 
figure
plot(data_pressure,data_force,'o')
title('data')
xlabel('Pressure (kPa)')
ylabel('Force (N)')
figure
plot(data_time,data_pressure,data_time,data_force,'.')

%% using fmin search to optimize
fun = @(x)sseval(x,data_pressure,data_force,li,lo);

%Finding best fitting parameters
x0 = [0.6184,-41.219,2.1,3] %random values 
bestx = fminsearch(fun,x0) %finding the

%Check fit quality
a0 = bestx(1); 
a1 = bestx(2);
a2 = bestx(3);
a3 = bestx(4);

%EQ1: 
yfit = (a0 + a1*(li-lo)/lo)*data_pressure + a2*(li-lo)/lo +a3;
%a0*data_pressure+a1;
%EQ2: yfit = (a0+a1*(li -lo))*data_pressure;
figure
plot(data_pressure,data_force,'*');
hold on

plot(data_pressure,yfit,'r')
xlabel('Pressure(kPa)')
ylabel('Force data and Fit')
title('Data and Fitting curve');
legend('Data','Fitted Curve')
hold off

