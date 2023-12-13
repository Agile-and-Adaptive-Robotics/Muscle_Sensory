%Clean up workspace. Comment out if also using data from LoadAll10mmData.
clear; clc; close all

low_force = 3;
high_pressure = 800;
kink_p = [0 25 50 75];

num = 100;  %number of data points

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


vars = {'Test9Data','Test10Data'};                    %desired tests
[a, b] = size(filz);
tf2 = cell(a,b);
wrk = cell(a,b);
t9 = cell(a,b);
t10 = cell(a,b);

for i = 1:length(Cut)
   for j = 1:length(li{i})
      if TF(i,j)==1  
        wrk = matfile(filz{i,j},'Writable',true);
        varlist = who(wrk);
        tf2 = matches(vars,varlist);
        myVars = vars(tf2);
        S = load(filz{i,j},myVars{:});
        C = struct2cell(S);
          if tf2(1)==1
            T9 = C{1};
            T9 = T9((T9(:,4)==1 &T9(:,1)>low_force),1:3);  %remove depressurizing data
            T9 = imresize(T9,[num 3]);
            T9 = [ones(length(T9),1)*relE{i,j}(:), T9(:,2), T9(:,1), T9(:,3)];
            t9{i,j} = T9(:,:);
          else
          end
          if tf2(2)==1
            T10 = C{2};
            T10 = T10((T10(:,4)==1 &T10(:,1)>low_force),1:3);
            T10 = imresize(T10,[num 3]);
            T10 = [ones(length(T10),1)*relE{i,j}(:), T10(:,2), T10(:,1), T10(:,3)];
            t10{i,j} = T10(:,:);
          else
          end
      end
   end
end


Testz = cell(a,b,(length(vars)));
for a = 1:length(Cut)
  for  b = 1:length(li{b})
        Testz{a,b,1} = t9{a,b};
        Testz{a,b,2} = t10{a,b};
  end
end
%% plots to check data
% 10mm 10cm
cz = ['b','r'];

for a = 1:length(Cut)
    
    fig(a) = figure;
      
      subplot(2,2,1)
      hold on
        for b = 1:length(li{a})
            for c = 1:length(vars)
               str = sprintf('kinked  %d percent, %s',kink_p(b),string(vars(c)));
               scatter(Testz{a,b,c}(:,4),Testz{a,b,c}(:,3),[],cz(c),'DisplayName',str);
            end
        end
        hold off
        xlabel('time (s)')
        ylabel('Force(N)')
        str3 = sprintf('10mm %scm Pressurizing, Force vs Time',string(Cut(a)));
        title(str3)
        lgd = legend;
        lgd.Title.String = 'Kink percentages';
        
        subplot(2,2,2)
        hold on
        for b = 1:length(li{a})
            for c = 1:length(vars)
               str = sprintf('kinked  %d percent, %s',kink_p(b),string(vars(c)));
               scatter(Testz{a,b,c}(:,4),Testz{a,b,c}(:,2),[],cz(c),'DisplayName',str);
            end
        end
        hold off
        xlabel('time (s)')
        ylabel('Pressure(kPa)')
        str4 = sprintf('10mm %scm Pressurizing, Pressure vs Time',string(Cut(a)));
        title(str4)
        lgd = legend;
        lgd.Title.String = 'Kink percentages';
        
        subplot(2,2,3)
        hold on
        for b = 1:length(li{a})
            for c = 1:length(vars)
               str = sprintf('kinked  %d percent, %s',kink_p(b),string(vars(c)));
               scatter(Testz{a,b,c}(:,1),Testz{a,b,c}(:,3),[],cz(c),'DisplayName',str);
            end
        end
        hold off
        xlabel('Rel. Strain')
        ylabel('Force (N)')
        str4 = sprintf('10mm %scm Pressurizing, Force vs Strain',string(Cut(a)));
        title(str4)
        lgd = legend;
        lgd.Title.String = 'Kink percentages';
        
        subplot(2,2,4)
        hold on
        for b = 1:length(li{a})
            for c = 1:length(vars)
               str = sprintf('kinked  %d percent, %s',kink_p(b),string(vars(c)));
               scatter(Testz{a,b,c}(:,2),Testz{a,b,c}(:,3),[],cz(c),'DisplayName',str);
            end
        end
        hold off
        xlabel('Pressure(kPa)')
        ylabel('Force (N)')
        str4 = sprintf('10mm %scm Pressurizing, Force vs Pressure',string(Cut(a)));
        title(str4)
        lgd = legend;
        lgd.Title.String = 'Kink percentages';
end
% 10mm 15cm


% 10mm 20cm


%10mm 25cm


%10mm 30cm_2

    
% 10mm 40cm

    
%10mm 45cm_2


%10mm 52cm_2
