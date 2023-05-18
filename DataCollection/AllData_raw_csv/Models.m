%% plotting other static model found on journals and papers

Do = 10;
ro = 5;
l = 12;
theta = 70;
b = 40.06;
n = 7;
P = linspace(0,500,100);
tk = 0.2;

%% Models: non of them looked right compared to my data. 

Steve = -(((pi*Do^2)/4)*P*(3*(cosd(70)^2)-1)) + P*pi*(Do*tk*(2*sind(70)-(1/(sind(70)))) - tk^2); %???
Chou = -P*b^2*(3*(l/b)^2 -1)/(4*pi*n^2); %best one so far, not as steep, Note: i have to add a negative in front. 
a = (3/(tand(theta)^2));
b = 1/(sind(theta)^2);
e = 0 %strain;
k =1.5;
Tondu = -(ro^2)*pi*P*(a*(1-k*e)^2-b);

%% Lawrence's fit
BPAfit = 0.647*P -58.6423; %model fit equation for unkink 10mm 13cm 
BPAfit_ = 0.5869*P -191.45; %model fit for kink 8mm
figure
plot(P,BPAfit,P,BPAfit_)
hold on
%ylim([0 400])
plot(P,Chou)%,P,Chou,P,Steve)
legend
grid on

