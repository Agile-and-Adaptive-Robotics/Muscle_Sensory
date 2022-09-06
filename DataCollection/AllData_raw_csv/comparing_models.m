%Comparing models
% 10mm 13cm
pressure = linspace(0,620,100);

P_yfit10mm13cm_1 = 0.64121*pressure - 59.044; 
P_yfit10mm13cm_2 = 0.645*pressure -130.74;
P_yfit10mm13cm_3 = 0.589*pressure - 194.8;
P_yfit10mm13cm_4 = 0.536*pressure - 231.369;

DP_yfit10mm13cm_1 = 0.6146*pressure - 52.014; 
DP_yfit10mm13cm_2 = 0.598*pressure -106.24;
DP_yfit10mm13cm_3 = 0.5532*pressure - 165.65;
DP_yfit10mm13cm_4 = 0.429*pressure - 161.69;

%% 20mm 40cm
P_yfit20mm40cm_1 = 2.29*pressure -162.54;
P_yfit20mm40cm_2 = 1.7865*pressure -340.65;
P_yfit20mm40cm_3 = 1.546*pressure - 344.227;
P_yfit20mm40cm_4 = 1.106*pressure - 355.3;


DP_yfit20mm40cm_1 = 2.2619*pressure -153.32;
DP_yfit20mm40cm_2 = 1.739*pressure -318.90;
DP_yfit20mm40cm_3 = 1.496*pressure -319.38;
DP_yfit20mm40cm_4 = 1.0365*pressure -321.19;

figure
subplot(221)
plot(pressure,P_yfit10mm13cm_1,pressure,P_yfit10mm13cm_2,pressure,P_yfit10mm13cm_3,pressure,P_yfit10mm13cm_4);
title('10mm13cm - Pressure vs Force (P)')
ylim([0,1000])
legend
grid on
subplot(222)
plot(pressure,DP_yfit10mm13cm_1,pressure,DP_yfit10mm13cm_2,pressure,DP_yfit10mm13cm_3,pressure,DP_yfit10mm13cm_4);
title('10mm13cm -Pressure vs Force(DP)')
ylim([0,1000])
legend
grid on
subplot (223)
plot(pressure,P_yfit20mm40cm_1,pressure,P_yfit20mm40cm_2,pressure,P_yfit20mm40cm_3,pressure,P_yfit20mm40cm_4);
title('20mm40cm -Pressure vs Force (P)')
ylim([0,1000])
legend
grid on
subplot(224)
plot(pressure,DP_yfit20mm40cm_1,pressure,DP_yfit20mm40cm_2,pressure,DP_yfit20mm40cm_3,pressure,DP_yfit20mm40cm_4);
title('20mm40cm -Pressure vs Force (P)')
ylim([0,1000])
legend
grid on



