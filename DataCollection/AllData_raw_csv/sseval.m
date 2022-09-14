%Compute sum of square error

function sse = sseval(x,tdata,ydata,li,lo) %tdata = pressure
a0 = x(1);
a1 =x(2);
a2 = x(3);
a3 = x(4);
model = (a0 + a1*(li-lo)/lo)*tdata + a2*(li-lo)/lo +a3 ;
sse =sum((ydata-model).^2) %sum((ydata-(a0*tdata+a1)).^2);