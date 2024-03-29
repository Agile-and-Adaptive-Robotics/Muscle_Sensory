clc;
%Plot all 20mm data
% 20mm10cm 
bpalength = 10;
vals_10cmkinks = [0,13,20];
figure
for a = 1:length(vals_10cmkinks)
    b = vals_10cmkinks(a);
    str = sprintf('20mm10cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data10cm = AllBPA20mm10cm(AllBPA20mm10cm(:,5)==bpalength&AllBPA20mm10cm(:,6)==b&AllBPA20mm10cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data10cm(:,2),data10cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end

figure 
for a = 1:length(vals_10cmkinks)
    b = vals_10cmkinks(a);
    str = sprintf('20mm10cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data10cm = AllBPA20mm10cm(AllBPA20mm10cm(:,5)==bpalength&AllBPA20mm10cm(:,6)==b&AllBPA20mm10cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data10cm(:,3),data10cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Time(s)')
end


%% 20mm 12cm
bpalength = 12;
vals_12cmkinks = [0,10,20]
figure
for a = 1:length(vals_12cmkinks)
    b = vals_12cmkinks(a);
    str = sprintf('20mm12cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data12cm = AllBPA20mm12cm(AllBPA20mm12cm(:,5)==bpalength&AllBPA20mm12cm(:,6)==b&AllBPA20mm12cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data12cm(:,2),data12cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end
figure
for a = 1:length(vals_12cmkinks)
    b = vals_12cmkinks(a);
    str = sprintf('20mm12cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data12cm = AllBPA20mm12cm(AllBPA20mm12cm(:,5)==bpalength&AllBPA20mm12cm(:,6)==b&AllBPA20mm12cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data12cm(:,3),data12cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    ylabel('Pressure(kPa)')
    xlabel('Time(s)')
end


%% 20mm 23cm %% something wrong with 9mm and 19mm data (they're plotting the same thing) 
bpalength = 23;
vals_23cmkinks = [0,9,19]
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a);
    str = sprintf('20mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data23cm = AllBPA20mm23cm(AllBPA20mm23cm(:,5)==bpalength&AllBPA20mm23cm(:,6)==b&AllBPA20mm23cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data23cm(:,2),data23cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a);
    str = sprintf('20mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data23cm = AllBPA20mm23cm(AllBPA20mm23cm(:,5)==bpalength&AllBPA20mm23cm(:,6)==b&AllBPA20mm23cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data23cm(:,3),data23cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    ylabel('Pressure(kPa)')
    xlabel('Time(s)')
end


%% 20mm 30cm 
bpalength = 30;
vals_30cmkinks = [0,14,23,34]
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    str = sprintf('20mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data30cm = AllBPA20mm30cm(AllBPA20mm30cm(:,5)==bpalength&AllBPA20mm30cm(:,6)==b&AllBPA20mm30cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data30cm(:,2),data30cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end

bpalength = 30;
vals_30cmkinks = [0,14,23,34]
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    str = sprintf('20mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data30cm = AllBPA20mm30cm(AllBPA20mm30cm(:,5)==bpalength&AllBPA20mm30cm(:,6)==b&AllBPA20mm30cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data30cm(:,3),data30cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    ylabel('Pressure(kPa)')
    xlabel('Time(s)')
end


%% 20mm 40cm 
bpalength = 40;
vals_40cmkinks = [0,35,46,69]
figure
for a = 1:length(vals_40cmkinks)
    b = vals_40cmkinks(a);
    str = sprintf('20mm40cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data40cm = AllBPA20mm40cm(AllBPA20mm40cm(:,5)==bpalength&AllBPA20mm40cm(:,6)==b&AllBPA20mm40cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data40cm(:,2),data40cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end
figure
for a = 1:length(vals_40cmkinks)
    b = vals_40cmkinks(a);
    str = sprintf('20mm40cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data40cm = AllBPA20mm40cm(AllBPA20mm40cm(:,5)==bpalength&AllBPA20mm40cm(:,6)==b&AllBPA20mm40cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test);
        plot(data40cm(:,3),data40cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    ylabel('Pressure(kPa)')
    xlabel('Time(s)')
end

%% Check test 9 if they're consistent(find best test)
testnumber= 10;

data_10cm_t9 = AllBPA20mm10cm(AllBPA20mm10cm(:,5)==10&AllBPA20mm10cm(:,6)==0&AllBPA20mm10cm(:,7)==testnumber,:);
data_12cm_t9 = AllBPA20mm12cm(AllBPA20mm12cm(:,5)==12&AllBPA20mm12cm(:,6)==0&AllBPA20mm12cm(:,7)==testnumber,:);
data_23cm_t9 = AllBPA20mm23cm(AllBPA20mm23cm(:,5)==23&AllBPA20mm23cm(:,6)==0&AllBPA20mm23cm(:,7)==testnumber,:);
data_30cm_t9 = AllBPA20mm30cm(AllBPA20mm30cm(:,5)==30&AllBPA20mm30cm(:,6)==0&AllBPA20mm30cm(:,7)==testnumber,:);
data_40cm_t9 = AllBPA20mm40cm(AllBPA20mm40cm(:,5)==40&AllBPA20mm40cm(:,6)==0&AllBPA20mm40cm(:,7)==testnumber,:);
figure 
subplot 321
plot(data_10cm_t9(:,3),data_10cm_t9(:,1))
title('20mm10cm Unkink',testnumber)
xlabel('time(s)')
ylabel('Force(N)')
subplot 322
plot(data_12cm_t9(:,3),data_12cm_t9(:,1))
title('20mm12cm Unkink',testnumber)
xlabel('time(s)')
ylabel('Force(N)')
subplot 323
plot(data_23cm_t9(:,3),data_23cm_t9(:,1))
title('20mm23cm Unkink',testnumber)
xlabel('time(s)')
ylabel('Force(N)')
subplot 324
plot(data_30cm_t9(:,3),data_30cm_t9(:,1))
title('20mm30cm Unkink',testnumber)
xlabel('time(s)')
ylabel('Force(N)')
subplot 325
plot(data_40cm_t9(:,3),data_40cm_t9(:,1))
title('20mm40cm Unkink',testnumber)
xlabel('time(s)')
ylabel('Force(N)')






%% Plot only test 9: All together
testnumber = 9; %using test 9 as standard 

    %10cm
        figure
        subplot 321
        hold on
        for a = 1:length(vals_10cmkinks)
            b= vals_10cmkinks(a);
            data10cm_test9 = AllBPA20mm10cm(AllBPA20mm10cm(:,5)==10& AllBPA20mm10cm(:,6)==b&AllBPA20mm10cm(:,7)==testnumber,:);
            txt = sprintf('%dmm',vals_10cmkinks(a));
            plot(data10cm_test9(:,2),data10cm_test9(:,1),'DisplayName',txt)
        end
        hold off
        legend
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        title('20mm 10cm all Kinks - Test 9')

    %12cm
        subplot 322
        hold on
        for a = 1:length(vals_12cmkinks)
            b= vals_12cmkinks(a);
            data12cm_test9 = AllBPA20mm12cm(AllBPA20mm12cm(:,5)==12& AllBPA20mm12cm(:,6)==b&AllBPA20mm12cm(:,7)==testnumber,:);
            txt = sprintf('%dmm',vals_12cmkinks(a));
            plot(data12cm_test9(:,2),data12cm_test9(:,1),'DisplayName',txt)
        end
        hold off
        legend
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        title('20mm 12cm all Kinks - Test 9')
    %23cm
        subplot 323
        hold on
        for a = 1:length(vals_23cmkinks)
            b= vals_23cmkinks(a);
            data23cm_test9 = AllBPA20mm23cm(AllBPA20mm23cm(:,5)==23& AllBPA20mm23cm(:,6)==b&AllBPA20mm23cm(:,7)==testnumber,:);
            txt = sprintf('%dmm',vals_23cmkinks(a));
            plot(data23cm_test9(:,2),data23cm_test9(:,1),'DisplayName',txt)
        end
        hold off
        legend
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        title('20mm 23cm all Kinks - Test 9')

    %30cm
        subplot 324
        hold on
        for a = 1:length(vals_30cmkinks)
            b= vals_30cmkinks(a);
            data30cm_test9 = AllBPA20mm30cm(AllBPA20mm30cm(:,5)==30& AllBPA20mm30cm(:,6)==b&AllBPA20mm30cm(:,7)==testnumber,:);
            txt = sprintf('%dmm',vals_30cmkinks(a));
            plot(data30cm_test9(:,2),data30cm_test9(:,1),'DisplayName',txt)
        end
        hold off
        legend
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        title('20mm 30cm all Kinks - Test 9')

    %40cm
        subplot 325
        hold on
        for a = 1:length(vals_40cmkinks)
            b= vals_40cmkinks(a);
            data40cm_test9 = AllBPA20mm40cm(AllBPA20mm40cm(:,5)==40& AllBPA20mm40cm(:,6)==b&AllBPA20mm40cm(:,7)==testnumber,:);
            txt = sprintf('%dmm',vals_40cmkinks(a));
            plot(data40cm_test9(:,2),data40cm_test9(:,1),'DisplayName',txt)
        end
        hold off
        legend
        xlabel('Pressure(kPa)')
        ylabel('Force(N)')
        title('20mm 40cm all Kinks - Test 9')




%% Plot 20mm separating pressurizing and depressurizing data
figure
subplot 211
plot(AllBPA20mm_P(:,2),AllBPA20mm_P(:,1),'.')
title('10mm BPA - Pressurizing')
xlabel('Pressure(kPa)')
ylabel('Force(N)')

subplot 212
plot(AllBPA20mm_DP(:,2),AllBPA20mm_DP(:,1),'.')
title('20mm BPA - Depressurizing')
xlabel('Pressure(kPa)')
ylabel('Force(N)')

%Separate different lengths by colors (20mm)
figure
subplot(121)
plot(AllBPA20mm10cm_P(:,2),AllBPA20mm10cm_P(:,1),'.')
hold on
plot(AllBPA20mm12cm_P(:,2),AllBPA20mm12cm_P(:,1),'.')
plot(AllBPA20mm23cm_P(:,2),AllBPA20mm23cm_P(:,1),'.')
plot(AllBPA20mm30cm_P(:,2),AllBPA20mm30cm_P(:,1),'.')
plot(AllBPA20mm40cm_P(:,2),AllBPA20mm40cm_P(:,1),'.')
grid on
ylim([0,1400])
legend('10cm','12cm','23cm','30cm','40cm')
title('20mm BPA force-pressure relationship at various lengths (Pressurizing)')

subplot(122)
plot(AllBPA20mm10cm_DP(:,2),AllBPA20mm10cm_DP(:,1),'.')
hold on
plot(AllBPA20mm12cm_DP(:,2),AllBPA20mm12cm_DP(:,1),'.')
plot(AllBPA20mm23cm_DP(:,2),AllBPA20mm23cm_DP(:,1),'.')
plot(AllBPA20mm30cm_DP(:,2),AllBPA20mm30cm_DP(:,1),'.')
plot(AllBPA20mm40cm_DP(:,2),AllBPA20mm40cm_DP(:,1),'.')
grid on
legend('10cm','12cm','23cm','30cm','40cm')
title('20mm BPA force-pressure relationship at various lengths (Depressurizing)')
hold off

figure
plot(AllBPA20mm_P(:,2),AllBPA20mm_P(:,1),'b.')
hold on
plot(AllBPA20mm_DP(:,2),AllBPA20mm_DP(:,1),'r.')
title('Comparing Pressurizing and Depressurizing for 20mm')
legend('Pressurizing','Depressurizing')
grid on
hold off


%% Plotting only test 9 
testnumber = 9;





