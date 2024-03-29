%Overlap plots
%clear matlab
clear; clc; close all;

%get number of experiment files in the directory (total files - 3)
numOfExperiments = length(dir)-4;

%create two lists with the names of the files (ExperimentxFill.mat where x
%is the experiment number)
for (i = 1:numOfExperiments)
    %store file names
    filename{i} = strjoin({'Experiment',num2str(i),'Fill.mat'},'');
    %load files
    experiments{i} = load(filename{i});
end

x = linspace(0, 40);
Pbldg = 620*ones([100,1]); %Building pressure in kPa
RiseTime = 0.9*Pbldg; %Calculate rise time as 90% of step input

f = figure;
f.OuterPosition = [314 218 796 496];
ax = gca;
ax.XLim = [0 4];
%set(ax,'XMinorGrid','on','XMinorTick','on','XTick')
xlabel('Time (s)')
ylabel('Pressure (kPa)')
grid on
hold on

%plot each of the experiments on the graph
for (i = 1:numOfExperiments)
    
    %find location of the data field within the experiment file
    loc = experiments{i}.data;
    
    %plot the first column (time) as the x axis and the second column
    %(pressure) as the y axis. 'displayname' sets the name that shows up on
    %the legend as the experiment number (num2str(i))
    plot(loc(:,1),loc(:,2),'DisplayName',num2str(i));
end    

lgd = legend('show');
%plot max pressure line
pstep = plot(x, Pbldg,'DisplayName','Step Input');
pstep.LineWidth = 3;
%plot 90% of max pressure line
pRiseTime = plot(x, RiseTime,'LineStyle','--','DisplayName','Rise Time');
hold off
%title of legend
title(lgd,'Experiments')
%position of legend
lgd.Position = [0.6607    0.2304    0.2333    0.2519];
%title of graph
title('20 mm Festo Fill Times')