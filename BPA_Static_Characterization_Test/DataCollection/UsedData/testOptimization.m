%Curve fitting via optimization

%eg: model y = Aexp(-lamda*t) where A and lamda are the parameters to be
%tuned. To fit curve we need to minimize sum of squared errors

%Sample data
rng default %random number generator
tdata = 0:0.1:10;
ydata = 40*exp(-0.5*tdata)+randn(size(tdata));

%using fminsearch to optimize
fun = @(x)sseval(x,tdata,ydata);

%Find best fitting parameters. 
x0 = rand(2,1);
bestx = fminsearch(fun,x0)

%check fit quality
A = bestx(1); lambda = bestx(2);
yfit = A*exp(-lambda*tdata);
plot(tdata,ydata,'*')
hold on
plot(tdata,yfit,'r')
xlabel('tdata')
ylabel('Response Data and Curve')
title('Data and Best fitting curve')
legend('Data','Fitted Curve')
hold off

