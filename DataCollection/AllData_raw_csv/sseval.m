%Compute sum of square error

function sse = sseval(x,tdata,ydata)
a0 = x(1);
a1 =x(2);
sse = sum((ydata-(a0*tdata+a1)).^2);