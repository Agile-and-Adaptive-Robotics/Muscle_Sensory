%compiling all data into one giant matrix for optimization  of parameters
CombinedData =AllBPA10mm_P; %vertcat(AllBPA10mm,AllBPA20mm);  %combine all data into a single matrix
% state = [1 0];
% kinknum =0;
% SelectedData = CombinedData(CombinedData(:,7)==testnum&CombinedData(:,8)==1&CombinedData(:,6)==kinknum,:); %extract only certain test number and P/DP
SelectedData = CombinedData(CombinedData(:,7)==testnum,:);
% SubsetData = CombinedData(CombinedData(:,7) = testnum&CombinedData(:,8)=1,:)
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
Erel = E./Emax;
count = 1:length(Force);
count = count';
AllData = [Force,Pressure,Lo,Li,L620,E,Emax,Erel];

%% creating regression matrix
y = Force;
x1 = (1 - Erel).^2; 
%x2 = Li+100;
x3 = Pressure ;                     
% % x4 = E;                            
% x5 = Emax;
% x6 = P_DP;
% x7 = Pressure.*Diameter;
% x8 = E./Emax;
X = [ones(size(Force)) x1 x3];% x2 x3]% x4 x5 x6 x7 x8];

% x1 = Diameter; 
% x2 = Pressure; 
% x3 = E./Emax;
% x4 = Diameter.*Pressure; 
% x5 = E.*Pressure./Emax;
% X = [ones(size(Force)) x1 x2 x3 x4 x5];
c = regress(y,X)
optimized_para = c; 

%% plot fit for all different lengths and Li (kinks)
lengths_ = [13,23,27,30];
diameter = 10;
test=10;

figure
hold on
for i=1:length(lengths_)
    [lengths,lo,li,l620,Erel,E,kink,kmax] = choosedata(diameter,lengths_(i),test);
    for k = 1:length(kink)
        i
        k
        yfit{i,k} = c(1) + c(2)*(1-Erel).^2 + c(3)*li
    end
    
end


% figure
% yfitt = c(1) + x1*c(2) + x3*c(3);% + x4*b(5) +x5*b(6) + x6*b(7) +x7*b(8) +x8*b(9);
% %plot(Pressure,yfitt,'.');
% % hold on
%  plot(Pressure,Force,'o');
% legend('fit','data')
% xlabel('pressure(kPa)');
% title('Best fit using optimized Parameters vs data')
% ylabel('Force');
% grid on;
% hold off;
