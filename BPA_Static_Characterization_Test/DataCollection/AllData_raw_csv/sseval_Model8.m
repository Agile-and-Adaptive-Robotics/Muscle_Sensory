function sse = sseval_Model8(x,Pressure,Force,Diameter,Li,Lo,L620,Erel)
c0 = x(1);
c1 = x(2);
c2 = x(3);
c3 = x(4);

model = c0 + c1*(1-Erel).^2 + c2(Li.^2) + c3*Pressure;

sse = sum((Force -model).^2);