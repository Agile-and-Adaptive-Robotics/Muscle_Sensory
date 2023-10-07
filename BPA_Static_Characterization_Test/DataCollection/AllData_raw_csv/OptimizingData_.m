%% Optimizing Data - Curve fitting via optimization
close all;clc;
% BPA Parameters (parameters to enter to select a specific set of data)
[diameter,lengths,lo,li,l620,kink,kmax,testnum,State] = choosedata(diameter,lengths,test) ;%choosing BPA parameters set from a function
state = ["P","DP"]; %P= pressurizig, DP = depressurizing
    

%% calling function to choose data in a loop for different (P/DP) state: this section creates the name of the file I want to extract
    data_chosen = cell(length(state),1);
    data_eval = cell(length(state),1);
    
    for k = 1:length(state)
        data_chosen{k} = data_select(diameter,lengths,kink,testnum,state(k)) %picking the csv title to extract data
        data_eval{k} =  eval(data_chosen{k}); %data_eval(1) = P, data_eval(2) = DP data
        data{k} = cell(length(kink),1);
        bestx{k} = cell(length(kink),1);
    end   
    
%% run loop to save all data wrt to kink|testnumber|P/DP state - save in a data{i} loop
for k=1:length(state)
    for i=1:length(kink)
        data{k,i} =  data_eval{k}(data_eval{k}(:,6)==kink(i)& data_eval{k}(:,7)==testnum,:);
        data_force{k,i} = data{k,i}(:,1);
        data_pressure{k,i} = data{k,i}(:,2);
        data_time{k,i} = data{k,i}(:,3);
        data_state{k,i} = data{k,i}(:,8);
        data_test{k,i} = data{k,i}(:,7);
        data_strain{k,i} = data{k,i}(:,12);
        data_relativestrain{k,i} = data{k,i}(:,13);
    end
end
%% plotting data to check(P and DP)
for k=1:length(state)
    figure
    strtitle{k} = sprintf('%s',data_chosen{k})
    sgtitle(strtitle{k})
    hold on
        for i=1:length(kink)
            subplot (2,2,i)
            plot(data_pressure{k,i},data_force{k,i},'b.')
            subtitlestr = sprintf('Test%d|%gcm|%s',testnum,li(i),state(k));
            title(subtitlestr)
            xlabel('Pressure(kPa)')
            ylabel('Force(N)')
            grid on
        end
    hold off
end
%% Optimization - using fmin search to optimize data
r = cell(length(state),length(kink));
for k = 1:length(state)
    figure
    sgtitle(data_chosen{k})
    hold on
        for i=1:length(kink)
            fun = @(x)sseval(x,data_pressure{k,i},data_force{k,i},diameter,li(i),lo,l620,kmax,State(k));
            %Best fitting parameters(x0)
            x0 = [-3.13,-1.47,21.44,2.26] %-3.21,-20];%,1,4]; %random values (#of parameters = # of entries) 
            bestx{k,i} = fminsearch(fun,x0) 

            %Test fit quality
            a0 = bestx{k,i}(1);
            a1 = bestx{k,i}(2);
            a2 = bestx{k,i}(3);
            a3 = bestx{k,i}(4);
%             a4 = bestx{k,i}(5);
%             a5 = bestx{k,i}(6);
%             a6 = bestx{k,i}(7);
%             a7 = bestx{k,i}(8);
%            a8 = bestx{k,i}(9);
%           yfit{k,i} = (a0 + a1*(li(i)-lo)/lo)*data_pressure{k,i} + a2*(li(i)-lo)/lo + a3;
%           yfit{k,i} = (a0 + a1*((lo-li(i))/lo)/kmax)*data_pressure{k,i} + a2*((lo-li(i))/lo)/kmax + a3;
%           yfit{k,i} =(a0+a1 +a2*(((lo-li(i))/lo)/kmax))*data_pressure{k,i} + (a3+a4)*((lo-li)/lo)/kmax +a5;
%           yfit{k,i} = pi*diameter^2*data_pressure{k,i}*(a0+a1*(1/((lo-li(i))/lo)) + a2*(((lo-li(i))/lo)/kmax))+a3; %bad fit
%           yfit{k,i} = (a0 + a1*(((lo-li(i))/lo)/kmax) + a2*diameter)*data_pressure{k,i} +a3*diameter + a4*(((lo-li(i))/lo)/kmax) +a5;
%            yfit{k,i} = a0 + a1*data_pressure{k,i} + a2*diameter +a3*lo + a4*(lo-li(i))/lo + a5*(kmax) + a6*State(k) + a7*data_pressure{k,i}*diameter + a8*((lo-li(i))/(lo-l620)); 
%            yfit{k,i} = (a0 + a1*(((lo-li(i))/lo)/kmax))*data_pressure{k,i} +a2*(((lo-li(i))/lo)/kmax) + a3;
%           yfit{k,i} = (a0 + a1*lo +a2*(1 - (((lo-li(i))/lo)/kmax)))*data_pressure{k,i} + a3*(1 - (((lo-li(i))/lo)/kmax))+ a4*lo +a5;
            yfit{k,i} = (a0 +a1*lo)*data_pressure{k,i} + a2*lo +a3;
            r{k,i} = data_force{k,i} - yfit{k,i}; %remove divide by zero. 
            
            
%           reg_fit = -32.7154 + 0.0603*data_pressure{k,i}-2.6*diameter-789.9*(((lo-li(i))/lo)/kmax) + 0.0875*diameter*data_pressure{k,i}+0.0414*data_pressure{k,i}*(((lo-li(i))/lo)/kmax);
            subplot (2,2,i)
            plot(data_pressure{k,i}, data_force{k,i},'*');
            hold on
            plot(data_pressure{k,i},yfit{k,i}, 'r');
%           plot(data_pressure{k,i},reg_fit,'o');
            xlabel('Pressure(kPa)');
            ylabel('Force (N)');
            subtitlestr = sprintf('Test%d|%gcm|%s',testnum,li(i),state(k));
            title(subtitlestr)
            legend('Data','Fit');
            grid on
            hold off
        end
end
%% plotting residuals
for k = 1:length(state)
    figure
    sgtitle(data_chosen{k})
    hold on
        for i=1:length(kink)
            subplot(2,2,i)
            plot(data_pressure{k,i},r{k,i},'.')
            hold on
            xlabel('pressure(kPa)')
            ylabel('Force(N)')
            subtitlestr2 = sprintf('Test%d|%gcm|%s',testnum,li(i),state(k));
            title(subtitlestr2)
            grid on
            yline(0)
            hold off
        end
    hold off
end

bestparameters = bestx'
%% save bestx in a csv file (row 1: kink 1, row 2= kink 2; col 1 = ao, col 2= a1...etc) 
    para_p  = bestparameters{1,1}
    for i=2:length(kink)
        currentpara = bestparameters{i,1};
        para_p = vertcat(para_p,currentpara);
    end
    para_name_p = char(data_chosen(1));
    str = strcat(para_name_p,'_test',num2str(testnum),'parameters'); %creating a new string to save parameters
    eval([str,'=para_p;']) %create variable named: str with data from para_p
    pname = str;
    k = eval(pname);
    str_title = sprintf('%s.csv',str);
    csvwrite(str_title,k)
    
    para_dp = bestparameters{1,2}
    for i=2:length(kink)
        currentpara = bestparameters{i,2};
        para_dp = vertcat(para_dp,currentpara);
    end
    para_name_dp = char(data_chosen(2));
    str2 = strcat(para_name_dp,'_test',num2str(testnum),'parameters');
    eval([str2 '=para_dp;'])
    pname2 = str2;
    k2 =eval(pname2);
    str_title2 = sprintf('%s.csv',str2);
    csvwrite(str_title2,k2);
    
%% saving all figures in a folder
for i = 1:6
saveas(figure(i),sprintf('%s_%d.fig',str2,i))
end
%% 

%This is the previos code without loops to separate P/DP
% calling function to choose data
%     data_chosen = cell(length(state),1);
%     data_chosen = data_select(diameter,lengths,kink,testnum,state) %choose diameter and length(All data) 
%     data_eval = eval(data_chosen);
%     data = cell(length(kink),1);
%     bestx = cell(length(kink),1);  

%%run loop to save all data wrt to kink|testnumber - save in a data{i} 
% for k = 1:length(state)
%   for i =1:length(kink)
%         data{i} = data_eval(data_eval(:,6)==kink(i)& data_eval(:,7)==testnum,:);
%         data_force{i} = data{i}(:,1);
%         data_pressure{i} = data{i}(:,2);
%         data_time{i} = data{i}(:,3);
%         data_test{i} = data{i}(:,7);
%         data_strain{i} = data{i}(:,12);
%         data_relativestrain{i} = data{i}(:,13);
%     end
% end

%     figure
%     for i=1:length(kink)
%         subplot (2,2,i)
%         plot(data_pressure{i},data_force{i},'b.')
%         subtitlestr = sprintf('%gcm test#%d %s',li(i),testnum,state);
%         title(data_chosen)
%         subtitle(subtitlestr)
%         xlabel('Pressure(kPa)')
%         ylabel('Force(N)')
%         grid on
%     end

%% Optimization - using fmin search to optimize data
% figure
% title(data_chosen)
% hold on
%     for i=1:length(kink)
%         fun = @(x)sseval(x,data_pressure{i},data_force{i},li(i),lo);
% 
%         %Best fitting parameters(x0)
%         x0 = [0.6184,-41.219,2.1,3]; %random values (#of parameters = # of entries) 
%         bestx{i} = fminsearch(fun,x0) 
% 
%         %Test fit quality
%         a0 = bestx{i}(1);
%         a1 = bestx{i}(2);
%         a2 = bestx{i}(3);
%         a3 = bestx{i}(4);
% 
%         yfit{i} =  (a0 + a1*(li(i)-lo)/lo)*data_pressure{i} + a2*(li(i)-lo)/lo + a3;
% 
%         subplot (2,2,i)
%         plot(data_pressure{i}, data_force{i},'*');
%         hold on
%         plot(data_pressure{i},yfit{i}, 'r');
%         xlabel('Pressure(kPa)');
%         ylabel('Force (N)');
%         subtitlestr = sprintf('%gcm test#%d %s',li(i),testnum,state);
%         title(subtitlestr)
%         legend('Data','Fit');
%         grid on
%         hold off
%         
%     end
    
    
