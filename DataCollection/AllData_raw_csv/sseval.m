%Compute sum of square error

function sse = sseval(x,tdata,ydata)
A = x(1);
lambda =x(2);
sse = sum((ydata-(A*tdata+lambda)).^2);