%Clean up workspace. Comment out if also using data from LoadAll10mmData.
clear; clc; close all

low_force = 3;
high_pressure = 800;
kink_p = [0 25 50 75];

num = 25;  %number of data points

% Loading all 10mm data from mat files. 
Cut = {'10','15','20','25','30','40','45','52'};     %cut lengths
kink = {'Unkink','kinked25','kinked50','kinked75'};   %potential kink percentages

%Create potential filenames
filz = cell(length(Cut),length(kink));
for i=1:length(Cut)                
  for j=1:length(kink)
     str=sprintf('10mm_%scm_%s.mat',Cut{i},kink{j});
     filz{i,j}=str;
  end
end

%Access directory of filenames
Filez = dir('*kink*.mat');
file = cell(length(Filez),1);
for i = 1:length(Filez)
     file{i,1} = Filez(i).name;
end
TF = matches(filz,file);

lo = zeros(length(Cut),1);      %resting length
l620 = zeros(length(Cut),1);    %max contracted length
maxE = zeros(length(Cut),1);    %maximum strain
li = cell(length(Cut),1);       %current length
relE = cell(length(Cut),length(kink));     %relative strain

%10cm
lo(1) = 8.3;
l620(1) = 7;
li{1} = [8.3,7.975,7.65,7.325];
%15cm
lo(2) = 13.2;
l620(2) = 11.1;
li{2} = [13.2	12.675	12.15	11.625];
%20cm
lo(3) = 18.2;
l620(3)= 15.2;
li{3} = [18.2	17.45	16.7	15.95];
%25cm
lo(4) = 23.3;
l620(4)=19.3;
li{4} = [23.3	22.3	21.3	20.3];
%30cm
lo(5) = 28.1;
l620(5) = 23.2;
li{5} = [28.1	26.875	25.65	24.425];
%40cm
lo(6) = 38.2;
l620(6) = 31.4;
li{6} = [38.2	36.5	34.8	33.1];
%45cm
lo(7) = 42.6;
l620(7) = 35.1;
li{7} = [42.6];
%52cm
lo(8) = 52.1;
l620(8) = 43.7;
li{8} = [52.1	50	47.9  45.8];

maxE = (lo-l620)./lo;
for i = 1:length(Cut)
    for j = 1:length(li{i})
      relE{i,j} = ((lo(i)-li{i}(j))./lo(i))./maxE(i);
    end
end


vars = ["Test8Data","Test9Data","Test10Data"];                    %desired tests
[a, b] = size(filz);
tf2 = cell(a,b);
wrk = cell(a,b);
% t9 = cell(a,b);
% t10 = cell(a,b);

T = cell(a,b,length(vars));
Q = cell(size(T));

disp('Calculating cell arrays')

for i = 1:length(Cut)
   for j = 1:length(li{i})
      if TF(i,j)==1  
        wrk = matfile(filz{i,j},'Writable',true);
        varlist = who(wrk);
        tf2{i,j} = matches(vars,varlist);
        myVars = vars(tf2{i,j});
        S = load(filz{i,j},myVars{:});
        for k = 1:length(vars)
            if tf2{i,j}(k) == 1
            M = S.(myVars(k));
            M = M((M(:,4)==1 &M(:,1)>low_force &M(:,2)<high_pressure),1:3);  %remove depressurizing data
            N = imresize(M,[num 3]);
            N = [ones(length(N),1)*relE{i,j}(:), N(:,2), N(:,1), N(:,3)];
            T{i,j,k} = N(:,:);
            M = [ones(length(M),1)*relE{i,j}(:), M(:,2), M(:,1), M(:,3)];
            Q{i,j,k} = M(:,:);
            else
            end
        end
      end
   end
end

% 
% Testz = cell(a,b,(length(vars)));
% for a = 1:length(Cut)
%   for  b = 1:length(li{b})
%         Testz{a,b,1} = t9{a,b};
%         Testz{a,b,2} = t10{a,b};
%   end
% end
%% plots to check data
varZ = ["Relative Strain", "Pressure (kPa)", "Force (N)", "Time (s)"];
cz = ["b", "m", "r"];
xAx = [4, 4, 1, 2];    %which subplots will use which varS for x-axis
yAy = [3, 2, 3, 3];    %which subplots will use which varS for y-axis
disp('Plotting, be patient')

for i = 1:length(Cut)
    figure
    tlo = tiledlayout(2,2);
    for a = 1:length(xAx)
      nexttile
%     subplot(2,2,a)
      hold on
      x = xAx(a);
      y = yAy(a);
      for j = 1:length(li{i})
        for k = 1:length(vars)
            if tf2{i,j}(k)==1
            xx = T{i,j,k}(:,x);
            yy = T{i,j,k}(:,y);
%             str1 = sprintf('%.2f \\epsilon, %s, resize ',relE{i,j},vars(k));
            str1 = sprintf('%s, resize ',vars(k));
            scatter(xx,yy,[],cz(k),'LineWidth',2,'DisplayName',str1);
            XX = Q{i,j,k}(:,x);
            YY = Q{i,j,k}(:,y);
%             str2 = sprintf('%.2f \\epsilon, %s, full ',relE{i,j},vars(k));
            str2 = sprintf('%s, full ',vars(k));
            scatter(XX,YY,.05,'.',cz(k),'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5,'DisplayName',str2); 
            else
            end
        end
      end
      hold off
      xlabel(varZ(x))
      ylabel(varZ(y))
      str3 = sprintf('%.1fcm l_{rest}, %s vs. %s, all kinks',lo(i),varZ(y),varZ(x));
      title(str3)
    end
    if a == length(xAx)
     lgd = legend;
     lgd.NumColumns = length(vars);
     txt = cellstr(lgd.String(1:6));
     lgd.String = txt;
     lgd.Layout.Tile = 'South';
    else
    end
end
