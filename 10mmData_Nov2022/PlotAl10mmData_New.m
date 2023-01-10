% plotting 10mm data and analysis

% Plotting all 10mm10cm data: All together in one array (just checking)
figure
plot (AllBPA10mm10cm_P(:,2),AllBPA10mm10cm_P(:,1),'.')
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('P: 10mm10cm - FvP')

figure
yyaxis left
plot(AllBPA10mm10cm_P(:,3),AllBPA10mm10cm_P(:,1),'.')
ylabel('Force (N)')

yyaxis right
plot(AllBPA10mm10cm_P(:,3),AllBPA10mm10cm_P(:,2),'.')
ylabel('Pressure(kPa)')
xlabel('time')
legend ('Force','Pressure')

% separate them by test number and plot, then separate by kinks and plot

% find maximum force for each kink and test and then normalize entire data
% to show (% of max force) 