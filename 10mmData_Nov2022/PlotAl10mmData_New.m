% plotting 10mm data and analysis (test)
% 10cm
bpalength = 10;
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
legend ('Force','Pressure ')

%% plotting all kinks and tests (separated) 
maxforce_10cm =zeros(2,4)
minforce_10cm = zeros(2,4)
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm10cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data10cm=AllBPA10mm10cm(AllBPA10mm10cm(:,6)==bpalength&AllBPA10mm10cm(:,8)==b&AllBPA10mm10cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_10cm(i-8,a) = max(data10cm(:,1))
        minforce_10cm(i-8,a) = min(data10cm(:,1))
        plot(data10cm(:,2),data10cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end

% splitting between P(1) and DP (2)
% separate them by test number and plot, then separate by kinks and plot
% find maximum force for each kink and test and then normalize entire data
% to show (% of max force) 

%% 15cm 
bpalength =15;
maxforce_15cm =zeros(2,4)
minforce_15cm = zeros(2,4)
figure
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm15cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data15cm=AllBPA10mm15cm(AllBPA10mm15cm(:,6)==bpalength&AllBPA10mm15cm(:,8)==b&AllBPA10mm15cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_15cm(i-8,a) = max(data15cm(:,1))
        minforce_15cm(i-8,a) = min(data15cm(:,1))
        plot(data15cm(:,2),data15cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end

%% 20cm
bpalength =20;
maxforce_20cm =zeros(2,4)
minforce_20cm = zeros(2,4)
figure
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm20cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data20cm=AllBPA10mm20cm(AllBPA10mm20cm(:,6)==bpalength&AllBPA10mm20cm(:,8)==b&AllBPA10mm20cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_20cm(i-8,a) = max(data20cm(:,1))
        minforce_20cm(i-8,a) = min(data20cm(:,1))
        plot(data20cm(:,2),data20cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end


%% 25cm
bpalength =25;
maxforce_25cm =zeros(2,4)
minforce_25cm = zeros(2,4)
figure
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm25cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data25cm=AllBPA10mm25cm(AllBPA10mm25cm(:,6)==bpalength&AllBPA10mm25cm(:,8)==b&AllBPA10mm25cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_25cm(i-8,a) = max(data25cm(:,1))
        minforce_25cm(i-8,a) = min(data25cm(:,1))
        plot(data25cm(:,2),data25cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end

%% 30cm

bpalength = 30;

maxforce_30cm =zeros(2,4)
minforce_30cm = zeros(2,4)
figure
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm30cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data30cm=AllBPA10mm30cm(AllBPA10mm30cm(:,6)==bpalength&AllBPA10mm30cm(:,8)==b&AllBPA10mm30cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_30cm(i-8,a) = max(data30cm(:,1))
        minforce_30cm(i-8,a) = min(data30cm(:,1))
        plot(data30cm(:,2),data30cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end


%% 40cm
bpalength =40;
maxforce_40cm =zeros(2,4)
minforce_40cm = zeros(2,4)
figure
for a = 1:length(kink_p)
    b = kink_p(a);
    str = sprintf('10mm40cm%d%%',b);
    subplot(2,2,a)
    hold on
    for i=9:10
        testnum = num2str(i);
        data40cm=AllBPA10mm40cm(AllBPA10mm40cm(:,6)==bpalength&AllBPA10mm40cm(:,8)==b&AllBPA10mm40cm(:,14)==i,:);
        txt = sprintf('%sTest%s',str,testnum);
        maxforce_40cm(i-8,a) = max(data40cm(:,1))
        minforce_40cm(i-8,a) = min(data40cm(:,1))
        plot(data40cm(:,2),data40cm(:,1),'.','DisplayName',txt);
     end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    grid on
end

%% plot only test 9 or 10 (all kinks)


%% plot: separating P/PD

%% normalized and plot & compare the difference between max force


