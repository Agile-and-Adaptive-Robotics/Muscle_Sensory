%compiling all data into one giant matrix for optimization  of parameters
CombinedData = vertcat(AllBPA10mm,AllBPA20mm);  %combine all data into a single matrix
SelectedData = CombinedData(CombinedData(:,7)==testnum&CombinedData(:,8)==1,:); %extract only certain test number and P/DP
%% extracting test # and rearranging columns into a matrix named AllData.
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
AllData = [count,Force,Pressure,Diameter,Length,Lo,E,Emax,P_DP];

%% creating regression matrix
y = Force;
x1 = Pressure;
x2 = Diameter;
x3 = Lo;                          
x4 = E;                            
x5 = Emax;
x6 = P_DP;
x7 = Pressure.*Diameter;
x8 = E./Emax;

X = [ones(size(Force)) x1 x2 x3 x4 x5 x6 x7 x8];
b = regress(y,X)
optimized_para = b; 

%% plot fit

figure
yfitt = b(1) + x1*b(2) + x2*b(3) + x3*b(4) + x4*b(5) +x5*b(6) + x6*b(7) +x7*b(8) +x8*b(9);
plot(Pressure,yfitt);
hold on
plot(Pressure,Force,'o');
legend('fit','data')
xlabel('pressure(kPa)');
ylabel('Force');
