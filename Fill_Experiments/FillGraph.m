%Overlap plots
%clear matlab
clear; clc; close all;

numOfExperiments = length(dir)-3;

for (i = 1:numOfExperiments)
    filename{i} = strjoin({'Experiment',num2str(i),'Fill.mat'},'');
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
for (i = 1:numOfExperiments)
    loc = experiments{i}.data;
    plot(loc(:,1),loc(:,2),'DisplayName',num2str(i));
end    

lgd = legend('show');
pstep = plot(x, Pbldg,'DisplayName','Step Input');
pstep.LineWidth = 3;
pRiseTime = plot(x, RiseTime,'LineStyle','--','DisplayName','Rise Time');
hold off
title(lgd,'Experiments')
lgd.Position = [0.6607    0.2304    0.2333    0.2519];
title('20 mm Festo Fill Times')