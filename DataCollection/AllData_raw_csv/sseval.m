%Compute sum of square error

function sse = sseval(x,tdata,ydata,diameter,li,lo,kmax) %tdata = pressure
a0 = x(1);
a1 =x(2);
a2 = x(3);
a3 = x(4);
% a4 = x(5);
% a5 = x(6);
% model = (a0 + a1*((lo-li)/lo)/kmax)*tdata + a2*((lo-li)/lo)/kmax +a3 ;
% model =(a0 +a1 +a2*(((lo-li)/lo)/kmax))*tdata + a3*((lo-li)/lo) + a4*((lo-li)/lo)/kmax +a5;                     %(a0 + a1*(li-lo)/lo)*tdata + a2*(li-lo)/lo +a3 ;
model = pi*diameter^2*tdata*(a0+a1*(1/((lo-li)/lo)) + a2*(((lo-li)/lo)/kmax))+a3;
sse =sum((ydata-model).^2); %sum((ydata-(a0*tdata+a1)).^2);
