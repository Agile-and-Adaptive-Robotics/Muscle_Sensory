%Compute sum of square error and finding parameters to fit data

function sse = sseval(x,data_pressure,ydata,diameter,li,lo,l620,kmax,State) 
a0 = x(1);
a1 = x(2);
a2 = x(3);
a3 = x(4);
% a4 = x(5);
% a5 = x(6);
% a6 = x(7);
% a7 = x(8);
% a8 = x(9);
% model = (a0 + a1*((lo-li)/lo)/kmax)*tdata + a2*((lo-li)/lo)/kmax +a3
% model =(a0 +a1 +a2*(((lo-li)/lo)/kmax))*tdata + a3*((lo-li)/lo) + a4*((lo-li)/lo)/kmax +a5;                     %(a0 + a1*(li-lo)/lo)*tdata + a2*(li-lo)/lo +a3 ;
% model = pi*diameter^2*tdata*(a0+a1*(1/((lo-li)/lo)) + a2*(((lo-li)/lo)/kmax))+a3;
% model = (a0 + a1*(((lo-li)/lo)/kmax) + a2*diameter)*data_pressure +a3*diameter + a4*(((lo-li)/lo)/kmax) +a5;
% model = a0 + a1*data_pressure + a2*diameter +a3*lo + a4*((lo-li)/lo) + a5*(kmax) + a6*State + a7*data_pressure*diameter + a8*(lo-li)/(lo-l620);
% model = (a0 + (a1*((lo-li)/lo)/kmax))*data_pressure + a2*(((lo-li)/lo)/kmax)+a3;
% model = (a0 + a1*lo +a2*(1 - (((lo-li)/lo)/kmax)))*data_pressure + a3*(1 - (((lo-li)/lo)/kmax)) + a4*lo +a5;
model = (a0 + a1*lo)*data_pressure + a2*lo +a3;
sse =sum((ydata-model).^2); %sum((ydata-(a0*tdata+a1)).^2);
