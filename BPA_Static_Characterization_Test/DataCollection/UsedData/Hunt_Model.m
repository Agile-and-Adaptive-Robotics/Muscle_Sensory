% Dr. Hunt's model
%optimization parameters

a0 = 254.3;%*10^3;
a1 = 192;%*10^3;
a2 = 2.0265;
a3 = -0.461;
a4 = -0.331;
a5 = 1.23;
a6 = 15.6;

%10mm BPA strain - length (29.8cm)
rest_length = 28.1;
max_contraction_length = 23.6;
kmax =(rest_length - max_contraction_length)./rest_length;
k = 1;
S=0;
F = linspace(0,600);
%Model
P = a0+(a1.*tand(a2.*(k./(a4.*F.*kmax))+a3)) + a5.*F+a6*S;

figure
plot(P,F)
figure
plot(F,P)











