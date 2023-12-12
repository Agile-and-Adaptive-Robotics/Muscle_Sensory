%% Find the max force at 620 kPa using Lawrence's data
%Note that this script is a copy-paste from a Command Window and has
%been only slightly fine-tuned.

%Run Ben_Lawrence_data_10mm.m

Ymax = [100, 200, 300, 400, 500, 620];
meth = 'linear';
extrap = 'extrap';


%13cm cut length, test 9
Y13P9 = data13cm_t9(data13cm_t9(:,1)==0,2); Z13P9 = data13cm_t9(data13cm_t9(:,1)==0,3);
y13P9 = imresize(Y13P9,[400 1]);
z13P9 = imresize(Z13P9,[400 1]);
Y13P10 = data13cm_t10(data13cm_t10(:,1)==0,2); Z13P10 = data13cm_t10(data13cm_t10(:,1)==0,3);
y13P10 = imresize(Y13P10,[400 1]);
z13P10 = imresize(Z13P10,[400 1]);
z13max9 = interp1(y13P9, z13P9, Ymax, meth, extrap);
z13max10 = interp1(y13P10, z13P10, Ymax, meth, extrap);
z13max = mean([z13max9; z13max10],1)
figure
hold on
plot(Ymax, z13max, '--b')
scatter(Y13P9,Z13P9,[],'blue')
scatter(y13P9,z13P9,[],'red')
scatter(Y13P10,Z13P10,[],'blue','d')
scatter(y13P10,z13P10,[],'red','d')
hold off


% 
% %23 cm cut length
Y23P9 = data23cm_t9(data23cm_t9(:,1)==0,2);
Z23P9 = data23cm_t9(data23cm_t9(:,1)==0,3);
y23P9 = imresize(Y23P9,[400 1]);
z23P9 = imresize(Z23P9,[400 1]);
Y23P10 = data23cm_t10(data23cm_t10(:,1)==0,2);
Z23P10 = data23cm_t10(data23cm_t10(:,1)==0,3);
y23P10 = imresize(Y23P10,[400 1]);
z23P10 = imresize(Z23P10,[400 1]);
z23max9 = interp1(y23P9, z23P9, Ymax, meth, extrap);
z23max10 = interp1(y23P10, z23P10, Ymax, meth, extrap);
z23max = mean([z23max9; z23max10],1)
figure
hold on
plot(Ymax, z23max, '--b')
scatter(Y23P9,Z23P9,[],'blue')
scatter(y23P9,z23P9,[],'red')
scatter(Y23P10,Z23P10,[],'blue','d')
scatter(y23P10,z23P10,[],'red','d')
hold off

% %27 cm cut length
Y27P9 = data27cm_t9(data27cm_t9(:,1)==0,2);
Z27P9 = data27cm_t9(data27cm_t9(:,1)==0,3);
y27P9 = imresize(Y27P9,[400 1]);
z27P9 = imresize(Z27P9,[400 1]);
Y27P10 = data27cm_t10(data27cm_t10(:,1)==0,2);
Z27P10 = data27cm_t10(data27cm_t10(:,1)==0,3);
y27P10 = imresize(Y27P10,[400 1]);
z27P10 = imresize(Z27P10,[400 1]);
z27max9 = interp1(y27P9, z27P9, Ymax, meth, extrap);
z27max10 = interp1(y27P10, z27P10, Ymax, meth, extrap);
z27max = mean([z27max9; z27max10],1)
figure
hold on
plot(Ymax, z27max, '--b')
scatter(Y27P9,Z27P9,[],'blue')
scatter(y27P9,z27P9,[],'red')
scatter(Y27P10,Z27P10,[],'blue','d')
scatter(y27P10,z27P10,[],'red','d')
hold off
% 
% %29 cm cut length
Y29P9 = data29cm_t9(data29cm_t9(:,1)==0,2);
Z29P9 = data29cm_t9(data29cm_t9(:,1)==0,3);
y29P9 = imresize(Y29P9,[400 1]);
z29P9 = imresize(Z29P9,[400 1]);
Y29P10 = data29cm_t10(data29cm_t10(:,1)==0,2);
Z29P10 = data29cm_t10(data29cm_t10(:,1)==0,3);
y29P10 = imresize(Y29P10,[400 1]);
z29P10 = imresize(Z29P10,[400 1]);
z29max9 = interp1(y29P9, z29P9, Ymax, meth, extrap);
z29max10 = interp1(y29P10, z29P10, Ymax, meth, extrap);
z29max = mean([z29max9; z29max10],1)
figure
hold on
plot(Ymax, z29max, '--b')
scatter(Y29P9,Z29P9,[],'blue')
scatter(y29P9,z29P9,[],'red')
scatter(Y29P10,Z29P10,[],'blue','d')
scatter(y29P10,z29P10,[],'red','d')
hold off
% 
% %30 cm cut length
Y30P9 = data30cm_t9(data30cm_t9(:,1)==0,2);
Z30P9 = data30cm_t9(data30cm_t9(:,1)==0,3);
y30P9 = imresize(Y30P9,[400 1]);
z30P9 = imresize(Z30P9,[400 1]);
Y30P10 = data30cm_t10(data30cm_t10(:,1)==0,2);
Z30P10 = data30cm_t10(data30cm_t10(:,1)==0,3);
y30P10 = imresize(Y30P10,[400 1]);
z30P10 = imresize(Z30P10,[400 1]);
z30max9 = interp1(y30P9, z30P9, Ymax, meth, extrap);
z30max10 = interp1(y30P10, z30P10, Ymax, meth, extrap);
z30max = mean([z30max9; z30max10],1)
figure
hold on
plot(Ymax, z30max, '--b')
scatter(Y30P9,Z30P9,[],'blue')
scatter(y30P9,z30P9,[],'red')
scatter(Y30P10,Z30P10,[],'blue','d')
scatter(y30P10,z30P10,[],'red','d')
hold off

%% Find force at 620 kPa and 0 relative strain in Ben's data in Ben_Lawrence_data_10mm
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0)
% figure
% scatter(rawdata45cm(:,4), rawdata45cm(:,1))
% X45 = rawdata45cm(:,4); Z45 = rawdata45cm(:,1));
% X45 = rawdata45cm(:,4); Z45 = rawdata45cm(:,1);
% rawdata45cm = [26	620	0.164835165	1.041666667;
% 61	620	0.151648352	0.958333333;
% 150	620	0.101098901	0.638888889;
% 96	620	0.13956044	0.881944444;
% 100	620	0.134065934	0.847222222;
% 119	620	0.12967033	0.819444444;
% 158	620	0.10989011	0.694444444;
% 217.0732141	620	0.083516484	0.527777778;
% 262.0002522	620	0.061538462	0.388888889;
% 335.3959086	620	0.037362637	0.236111111;
% 407.0122764	620	0.021978022	0.138888889;
% 435.9257168	620	0.006593407	0.041666667;
% 404.7881656	620	0.010989011	0.069444444;
% 408.3467429	620	0.008791209	0.055555556;
% 335.3959086	620	0.021978022	0.1388;
% 257.9968528	620	0.046153846	0.291666667;
% 203.2837271	620	0.074725275	0.472222222];
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0)
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0, 'pchip','extrap')
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0, 'cubic','extrap')
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0, [],'extrap')
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0, 'makima','extrap')
% z45max = interp1(rawdata45cm(:,4), rawdata45cm(:,1), 0, 'spline','extrap')
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1))
% figure
% hold on
% scatter(rawdata45cm(:,4), rawdata45cm(:,1),[],'blue')
% scatter(rawdata45cm(:,4), yy, [], 'red')
% z45max = interp1(rawdata45cm(:,4), yy, 0, 'pchip','extrap')
% z45max = interp1(rawdata45cm(:,4), yy, 0, 'linear','extrap')
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1),'sgolay',3)
% hold on
% scatter(rawdata45cm(:,4), rawdata45cm(:,1),[],'blue')
% scatter(rawdata45cm(:,4), yy, [], 'red')
% figure
% hold on
% scatter(rawdata45cm(:,4), rawdata45cm(:,1),[],'blue')
% scatter(rawdata45cm(:,4), yy, [], 'red')
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1),'sgolay',5)
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1),'rloess')
% figure
% hold on
% scatter(rawdata45cm(:,4), rawdata45cm(:,1),[],'blue')
% scatter(rawdata45cm(:,4), yy, [], 'red')
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1),'rlowess')
% figure
% hold on
% scatter(rawdata45cm(:,4), rawdata45cm(:,1),[],'blue')
% scatter(rawdata45cm(:,4), yy, [], 'red')
% yy = smooth(rawdata45cm(:,4), rawdata45cm(:,1))
% z45max = interp1(rawdata45cm(:,4), yy, 0, 'linear','extrap')
% rawdata49cm = [12	618	0.173469388	0.923913043;
% 1.11	618	0.175510204	0.934782609;
% 464	620	-0.002040816	-0.010869565;
% 433	616	0.008163265	0.043478261;
% 320	618	0.030612245	0.163043478;
% 356	620	0.02244898	0.119565217;
% 300	618	0.03877551	0.206521739;
% 268	617	0.048979592	0.260869565;
% 241	617	0.06122449	0.326086957;
% 215	617	0.069387755	0.369565217;
% 194	617	0.081632653	0.434782609;
% 165	617	0.095918367	0.510869565;
% 144	617	0.106122449	0.565217391;
% 107	617	0.128571429	0.684782609;
% 97	617	0.132653061	0.706521739;
% 75	617	0.146938776	0.782608696;
% 58	617	0.157142857	0.836956522;
% 45	617	0.165306122	0.880434783;
% 20	617	0.17755102	0.945652174;
% 2.29	617	0.185714286	0.989130435;
% 0	617	0.187755102	1];
% z49max = interp1(rawdata49cm(:,4), rawdata49cm(:,1), 0, 'linear')

%% Find max forces from Lawrence's 10mmData_Nov2022
Ymax = [100, 200, 300, 400, 500, 620];
meth = 'linear';
extrap = 'extrap';

load('10mm_10cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y10P9 = Test9Data(Test9Data(:,4)==1,2);
Z10P9 = Test9Data(Test9Data(:,4)==1,1);
y10P9 = imresize(Y10P9,[400 1]);
z10P9 = imresize(Z10P9,[400 1]);
Y10P10 = Test10Data(Test10Data(:,4)==1,2);
Z10P10 = Test10Data(Test10Data(:,4)==1,1);
y10P10 = imresize(Y10P10,[400 1]);
z10P10 = imresize(Z10P10,[400 1]);
z10max9 = interp1(y10P9, z10P9, Ymax, meth, extrap);
z10max10 = interp1(y10P10, z10P10, Ymax, meth, extrap);
z10max = mean([z10max9; z10max10],1)
figure
hold on
scatter(Y10P9,Z10P9,[],'blue')
scatter(y10P9,z10P9,[],'red')
scatter(Y10P10,Z10P10,[],'blue','d')
scatter(y10P10,z10P10,[],'red','d')
plot(Ymax, z10max, '--b')
hold off

%15 cm cut length
load('10mm_15cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y15P9 = Test9Data(Test9Data(:,4)==1,2);
Z15P9 = Test9Data(Test9Data(:,4)==1,1);
y15P9 = imresize(Y15P9,[400 1]);
z15P9 = imresize(Z15P9,[400 1]);
Y15P10 = Test10Data(Test10Data(:,4)==1,2);
Z15P10 = Test10Data(Test10Data(:,4)==1,1);
y15P10 = imresize(Y15P10,[400 1]);
z15P10 = imresize(Z15P10,[400 1]);
z15max9 = interp1(y15P9, z15P9, Ymax, meth, extrap)
z15max10 = interp1(y15P10, z15P10, Ymax, meth, extrap)
z15max = mean([z15max9; z15max10],1)
figure
hold on
scatter(Y15P9,Z15P9,[],'blue')
scatter(y15P9,z15P9,[],'red')
scatter(Y15P10,Z15P10,[],'blue','d')
scatter(y15P10,z15P10,[],'red','d')
plot(Ymax, z15max, '--b')
hold off

%20 cm cut length
load('10mm_20cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y20P9 = Test9Data(Test9Data(:,4)==1,2);
Z20P9 = Test9Data(Test9Data(:,4)==1,1);
y20P9 = imresize(Y20P9,[400 1]);
z20P9 = imresize(Z20P9,[400 1]);
Y20P10 = Test10Data(Test10Data(:,4)==1,2);
Z20P10 = Test10Data(Test10Data(:,4)==1,1);
y20P10 = imresize(Y20P10,[400 1]);
z20P10 = imresize(Z20P10,[400 1]);
z20max9 = interp1(y20P9, z20P9, Ymax, meth, extrap);
z20max10 = interp1(y20P10, z20P10, Ymax, meth, extrap);
z20max = mean([z20max9; z20max10],1)
figure
hold on
scatter(Y20P9,Z20P9,[],'blue')
scatter(y20P9,z20P9,[],'red')
scatter(Y20P10,Z20P10,[],'blue','d')
scatter(y20P10,z20P10,[],'red','d')
plot(Ymax, z20max, '--b')
hold off

%25 cm cut length
load('10mm_25cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y25P9 = Test9Data(Test9Data(:,4)==1,2);
Z25P9 = Test9Data(Test9Data(:,4)==1,1);
y25P9 = imresize(Y25P9,[400 1]);
z25P9 = imresize(Z25P9,[400 1]);
Y25P10 = Test10Data(Test10Data(:,4)==1,2);
Z25P10 = Test10Data(Test10Data(:,4)==1,1);
y25P10 = imresize(Y25P10,[400 1]);
z25P10 = imresize(Z25P10,[400 1]);
z25max9 = interp1(y25P9, z25P9, Ymax, meth, extrap);
z25max10 = interp1(y25P10, z25P10, Ymax, meth, extrap);
z25max = mean([z25max9; z25max10],1)
figure
hold on
scatter(Y25P9,Z25P9,[],'blue')
scatter(y25P9,z25P9,[],'red')
scatter(Y25P10,Z25P10,[],'blue','d')
scatter(y25P10,z25P10,[],'red','d')
plot(Ymax, z25max, '--b')
hold off

%30 cm cut length
load('10mm_30cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y30_2P9 = Test9Data(Test9Data(:,4)==1,2);
Z30_2P9 = Test9Data(Test9Data(:,4)==1,1);
y30_2P9 = imresize(Y30_2P9,[400 1]);
z30_2P9 = imresize(Z30_2P9,[400 1]);
Y30_2P10 = Test10Data(Test10Data(:,4)==1,2);
Z30_2P10 = Test10Data(Test10Data(:,4)==1,1);
y30_2P10 = imresize(Y30_2P10,[400 1]);
z30_2P10 = imresize(Z30_2P10,[400 1]);
z30_2max9 = interp1(y30_2P9, z30_2P9, Ymax, meth, extrap);
z30_2max10 = interp1(y30_2P10, z30_2P10, Ymax, meth, extrap);
z30_2max = mean([z30_2max9; z30_2max10],1)
figure
hold on
scatter(Y30_2P9,Z30_2P9,[],'blue')
scatter(y30_2P9,z30_2P9,[],'red')
scatter(Y30_2P10,Z30_2P10,[],'blue','d')
scatter(y30_2P10,z30_2P10,[],'red','d')
plot(Ymax, z30_2max, '--b') 
hold off


%40 cm cut length
load('10mm_40cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y40P9 = Test9Data(Test9Data(:,4)==1,2);
Z40P9 = Test9Data(Test9Data(:,4)==1,1);
y40P9 = imresize(Y40P9,[200 1]);
z40P9 = imresize(Z40P9,[200 1]);
Y40P10 = Test10Data(Test10Data(:,4)==1,2);
Z40P10 = Test10Data(Test10Data(:,4)==1,1);
y40P10 = imresize(Y40P10,[200 1]);
z40P10 = imresize(Z40P10,[200 1]);
z40max9 = interp1(y40P9, z40P9, Ymax, meth, extrap);
z40max10 = interp1(y40P10, z40P10, Ymax, meth, extrap);
z40max = mean([z40max9; z40max10],1)
figure
hold on
scatter(Y40P9,Z40P9,[],[0.055 0.149 .949])
scatter(y40P9,z40P9,[],[0.949, 0.055, 0.055])
scatter(Y40P10,Z40P10,[],[0.055 0.149 .949],'d')
scatter(y40P10,z40P10,[],[0.941 .286 .604],'d')
plot(Ymax, z40max, '--b')
hold off

%45_2 cm cut length
load('10mm_45cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y45_2P9 = Test9Data(Test9Data(:,4)==1,2);
Z45_2P9 = Test9Data(Test9Data(:,4)==1,1);
y45_2P9 = imresize(Y45_2P9,[400 1]);
z45_2P9 = imresize(Z45_2P9,[400 1]);
Y45_2P10 = Test10Data(Test10Data(:,4)==1,2);
Z45_2P10 = Test10Data(Test10Data(:,4)==1,1);
y45_2P10 = imresize(Y45_2P10,[400 1]);
z45_2P10 = imresize(Z45_2P10,[400 1]);
z45_2max9 = interp1(y45_2P9, z45_2P9, Ymax, meth, extrap);
z45_2max10 = interp1(y45_2P10, z45_2P10, Ymax, meth, extrap);
z45_2max = mean([z45_2max9; z45_2max10],1)
figure
hold on
scatter(Y45_2P9,Z45_2P9,[],'blue')
scatter(y45_2P9,z45_2P9,[],'red')
scatter(Y45_2P10,Z45_2P10,[],'blue','d')
scatter(y45_2P10,z45_2P10,[],'red','d')
plot(Ymax, z45_2max, '--b')
hold off

%52_2 cm cut length
load('10mm_52cm_Unkink.mat', 'Test9Data', 'Test10Data')
Y52_2P9 = Test9Data(Test9Data(:,4)==1,2);
Z52_2P9 = Test9Data(Test9Data(:,4)==1,1);
y52_2P9 = imresize(Y52_2P9,[400 1]);
z52_2P9 = imresize(Z52_2P9,[400 1]);
Y52_2P10 = Test10Data(Test10Data(:,4)==1,2);
Z52_2P10 = Test10Data(Test10Data(:,4)==1,1);
y52_2P10 = imresize(Y52_2P10,[400 1]);
z52_2P10 = imresize(Z52_2P10,[400 1]);
z52_2max9 = interp1(y52_2P9, z52_2P9, Ymax, meth, extrap);
z52_2max10 = interp1(y52_2P10, z52_2P10, Ymax, meth, extrap);
z52_2max = mean([z52_2max9; z52_2max10],1)
figure
hold on
scatter(Y52_2P9,Z52_2P9,[],'blue')
scatter(y52_2P9,z52_2P9,[],'red')
scatter(Y52_2P10,Z52_2P10,[],'blue','d')
scatter(y52_2P10,z52_2P10,[],'red','d')
plot(Ymax, z52_2max, '--b')
hold off