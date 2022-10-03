%compiling all data into one giant matrix for optimization  of parameters
CombinedData =AllBPA10mm_DP; %vertcat(AllBPA10mm,AllBPA20mm);  %combine all data into a single matrix
testnum=10;
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
x2 = Li.^2;
x3 = Pressure ;                     
% % x4 = E;                            
% x5 = Emax;
% x6 = P_DP;
% x7 = Pressure.*Diameter;
% x8 = E./Emax;
X = [ones(size(Force)) x1 x2 x3];% x2 x3]% x4 x5 x6 x7 x8];

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
% diameter = 20;
% lengths_= [10,12,23,30,40]
test=10;


%plot fit
for i=1:length(lengths_)
    [diameter,lengths,lo,li,l620,kink,E,kmax,Erel,testnum,State,B0,B1]=choosedata(diameter,lengths_(i),test);
    figure(i)
%     r = cell(length(lengths_),length(kink));
    for k = 1:length(kink)
    wtc = SelectedData(SelectedData(:,5)==lengths_(i)&SelectedData(:,11)==li(k),:);
    wtc_pressure = wtc(:,2);
    wtc_force = wtc(:,1);
    yfit = c(1) +c(2)*(1-Erel(k)).^2 + c(3)*(li(k))^2 + c(4)*wtc_pressure;
    r{i,k}= wtc_force - yfit;
    subplot(2,2,k)
    plot(wtc_pressure,yfit)
    hold on
    plot(wtc_pressure,wtc_force,'.')
    hold off
    str = sprintf('%dcm%dmm',lengths_(i),kink(k));
    title(str)
    xlabel('Pressure (kPa)');
    ylabel('Force (N)');
    grid on
    end
end
%% plot residuals of each fit

for i=1:length(lengths_)
    [diameter,lengths,lo,li,l620,kink,E,kmax,Erel,testnum,State,B0,B1]=choosedata(diameter,lengths_(i),test);
    figure
    for k =1:length(kink)
    wtc = SelectedData(SelectedData(:,5)==lengths_(i)&SelectedData(:,11)==li(k),:);
    wtc_pressure = wtc(:,2);
    wtc_force = wtc(:,1);
    yfit = c(1) + c(2)*(1-Erel(k)).^2 + c(3)*(li(k))^2+ c(4)*wtc_pressure;
    r{i,k}= wtc_force - yfit;
    subplot(2,2,k)
    plot(wtc_pressure,r{i,k})
    str = sprintf('Residual Plot %dcm%dmm',lengths_(i),kink(k));
    title(str)
    xlabel('Pressure (kPa)');
    ylabel('Force (N)');
    grid on
    end
end

%% save all figures
% for i = 1:10
%     saveas(figure(i),sprintf('Figure%d',i));
% end




% %% plot the fit with individual pressure points. 
% c(1);
% c(2);
% c(3);
% 
% AllBPA10mm13cm_P; %4 kinks
% AllBPA10mm23cm_P; %3 kinks
% AllBPA10mm27cm_P; %4 kinks
% AllBPA10mm30cm_P; %4 kinks








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
