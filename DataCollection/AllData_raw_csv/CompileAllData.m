%compiling all data into one giant matrix for optimization of parameters

CombinedData = vertcat(AllBPA10mm,AllBPA20mm); 

SelectedData = CombinedData(CombinedData(:,7)==testnum&CombinedData(:,8)=='P',:);


%% extracting test # and rearranging columns
Force = SelectedData(:,1);
Pressure = SelectedData(:,2);
Diameter = SelectedData(:,4); 
Length = SelectedData(:,5);
Lo = SelectedData(:,9);
L620 = SelectedData(:,10);
Li = SelectedData(:,11);
P_DP = SelectedData(:,8);
E = SelectedData(:,12);
Emax = (Lo-L620)./Lo;
count = 1:length(Force);
count = count';
AllData = [count,Force,Pressure,Diameter,Length,Lo,L620,Li,P_DP];

%% creating regression matrix
y = Force;
x1 = Pressure;
x2 = Diameter;
x3 = E./Emax;                   %x3 = Length;
x4 = x1.*x2;                          %E;
x5 = x3.*Pressure;
X = [ones(size(Force)) x1 x2 x3 x4 x5];
b = regress(y,X)

%% plot fit

figure
yfitt = b(1) + x1*b(2) + x2*b(3) + x3*b(4) + x4*b(5) +x5*b(6);
plot(Pressure,yfitt);
hold on
plot(Pressure,Force,'o');
legend('fit','data')
xlabel('pressure(kPa)');
ylabel('Force');
