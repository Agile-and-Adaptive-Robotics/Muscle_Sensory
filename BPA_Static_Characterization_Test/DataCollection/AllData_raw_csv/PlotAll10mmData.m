%Plot all 10mm data
 AllBPA10mm13cm_Force = AllBPA10mm13cm(:,1);
 AllBPA10mm13cm_Pressure = AllBPA10mm13cm(:,2);
 AllBPA10mm13cm_Time = AllBPA10mm13cm(:,3);


%% Plotting all 10mm 13cm data: All kinks and tests
vals_13cmkinks = [0,4,8,12]; 
bpalength = 13;

for a = 1:length(vals_13cmkinks)
    b = vals_13cmkinks(a);
    str = sprintf('10mm13cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data13cm = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==bpalength& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data13cm(:,2),data13cm(:,1),'DisplayName',txt);
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
    legend
end

%check timing to split P and DP
figure
for a = 1:length(vals_13cmkinks)
    b = vals_13cmkinks(a);
    str = sprintf('10mm13cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data13cm = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==bpalength& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data13cm(:,3),data13cm(:,1),'DisplayName',txt);
        end
    hold off
    legend
    title(str)
    xlabel('Time')
    ylabel('Force(N)')
    legend
end

%% 10mm23cm
bpalength = 23;
vals_23cmkinks = [0,14,30];
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a);
    str = sprintf('10mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data23cm = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==bpalength& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data23cm(:,2),data23cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a);
    str = sprintf('10mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data23cm = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==bpalength& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data23cm(:,3),data23cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Time(s)')
end



%% 10mm27cm
bpalength = 27;
vals_27cmkinks = [0,7,15,31];
figure
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a);
    str = sprintf('10mm27cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data27cm = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==bpalength& AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data27cm(:,2),data27cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end
figure
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a);
    str = sprintf('10mm27cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data27cm = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==bpalength& AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data27cm(:,3),data27cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Time(s)')
end

%% 10mm29cm
bpalength = 29;
vals_29cmkinks = [0,17,28,41];
figure
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a);
    str = sprintf('10mm29cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data29cm = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==bpalength& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data29cm(:,2),data29cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end
figure
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a);
    str = sprintf('10mm29cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data29cm = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==bpalength& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) ;
            plot(data29cm(:,3),data29cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Time(s)')
end

%% 10mm30cm
bpalength = 30;
vals_30cmkinks = [0,12,22,33];
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    str = sprintf('10mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data30cm = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==bpalength& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test); 
            plot(data30cm(:,2),data30cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    str = sprintf('10mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data30cm = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==bpalength& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test); 
            plot(data30cm(:,3),data30cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Time(s)')
end





%% Plot test 9 only
 testnumber = 9; %choosing test numner 9 as the standard
%13cm
figure
subplot 321
hold on
for a = 1:length(vals_13cmkinks)
    b=vals_13cmkinks(a);
    data13cm_test9 = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_13cmkinks(a));
    plot(data13cm_test9(:,2),data13cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 13cm all Kinks(Test 9 only)')

%23cm
subplot 322
hold on
for a = 1:length(vals_23cmkinks)
    b=vals_23cmkinks(a);
    data23cm_test9 = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==23& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_23cmkinks(a));
    plot(data23cm_test9(:,2),data23cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 23cm all Kinks(Test 9 only)')

%27cm
subplot 323
hold on
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a);
    data27cm_test9 = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==27&AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_27cmkinks(a));
    plot(data27cm_test9(:,2),data27cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure (kPa)')
ylabel('Force(N)')
title('10mm 27cm all Kinks(Test 9 only)')

%29cm
subplot 324
hold on
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a);
    data29cm_test9 = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==29& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_29cmkinks(a));
    plot(data29cm_test9(:,2),data29cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 29cm all Kinks(Test 9 only)')

%30cm
subplot 325
hold on
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    data30cm_test9 = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==30& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_30cmkinks(a));
    plot(data30cm_test9(:,2),data30cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 30cm all Kinks(Test 9 only)')
%% Plot test 9: check for P/DP timing

testnum = 9 ;
figure
title('Plot all data for a specific test numnber')
subplot 321
hold on
for a = 1:length(vals_13cmkinks)
    b=vals_13cmkinks(a);
    data13cm_test9 = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==testnum,:);
    txt = sprintf('%dmm',vals_13cmkinks(a));
    plot(data13cm_test9(:,3),data13cm_test9(:,1),'DisplayName',txt)
end
legend
xlabel('Time(s)')
ylabel('Force(N)')
title('10mm 13cm all Kinks',testnum)
hold off
subplot 322
hold on
for a = 1:length(vals_23cmkinks)
    b=vals_23cmkinks(a);
    data23cm_test9 = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==23& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_23cmkinks(a));
    plot(data23cm_test9(:,3),data23cm_test9(:,1),'DisplayName',txt)
end
legend
xlabel('Time(s)')
ylabel('Force(N)')
title('10mm 23cm all Kinks',testnum)
hold off


subplot 323
hold on
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a);
    data27cm_test9 = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==27&AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_27cmkinks(a));
    plot(data27cm_test9(:,3),data27cm_test9(:,1),'DisplayName',txt)
end
legend
xlabel('Time(s)')
ylabel('Force(N)')
title('10mm 27cm all Kinks',testnum)
hold off

subplot 324
hold on
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a);
    data29cm_test9 = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==29& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_29cmkinks(a));
    plot(data29cm_test9(:,3),data29cm_test9(:,1),'DisplayName',txt)
end
legend
xlabel('Time(s)')
ylabel('Force(N)')
title('10mm 29cm all Kinks',testnum)
hold off

subplot 325
hold on
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a);
    data30cm_test9 = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==30& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_30cmkinks(a));
    plot(data30cm_test9(:,3),data30cm_test9(:,1),'DisplayName',txt)
end
legend
xlabel('Time(s)')
ylabel('Force(N)')
title('10mm 30cm all Kinks',testnum)
hold off



%% Plot 10mm Separating Pressurizing and Depressurizing
figure
subplot 211
plot(AllBPA10mm_P(:,2),AllBPA10mm_P(:,1),'.')
title('10mm BPA - Pressurizing')
xlabel('Pressure (kPa)')
ylabel('Force(N)')

subplot 212
plot(AllBPA10mm_DP(:,2),AllBPA10mm_DP(:,1),'.');
title('10mm BPA - Depressurizing')
xlabel('Pressure(kPa)')
ylabel('Force(N)')

%color labeling each lengths and its respective kinks
figure
subplot(121)
plot(AllBPA10mm13cm_P(:,2),AllBPA10mm13cm_P(:,1),'.')
hold on
plot(AllBPA10mm23cm_P(:,2),AllBPA10mm23cm_P(:,1),'.')
plot(AllBPA10mm27cm_P(:,2),AllBPA10mm27cm_P(:,1),'.')
plot(AllBPA10mm29cm_P(:,2),AllBPA10mm29cm_P(:,1),'.')
plot(AllBPA10mm30cm_P(:,2),AllBPA10mm30cm_P(:,1),'.')
grid on
legend('13cm','23cm','27cm','29cm','30cm')
title('10mm BPA force-pressure relationship at various lengths (Pressurizing)- All Tests')

subplot(122)
plot(AllBPA10mm13cm_DP(:,2),AllBPA10mm13cm_DP(:,1),'.')
hold on
plot(AllBPA10mm23cm_DP(:,2),AllBPA10mm23cm_DP(:,1),'.')
plot(AllBPA10mm27cm_DP(:,2),AllBPA10mm27cm_DP(:,1),'.')
plot(AllBPA10mm29cm_DP(:,2),AllBPA10mm29cm_DP(:,1),'.')
plot(AllBPA10mm30cm_DP(:,2),AllBPA10mm30cm_DP(:,1),'.')
grid on
legend('13cm','23cm','27cm','29cm','30cm')
title('10mm BPA force-pressure relationship at various lengths (Depressurizing)')
hold off

figure
plot(AllBPA10mm_P(:,2),AllBPA10mm_P(:,1),'b.')
hold on
plot(AllBPA10mm_DP(:,2),AllBPA10mm_DP(:,1),'r.')
title('Comparing Pressurizing and Depressurizing for 10mm (All tests)')
legend('Pressurizing','Depressurizing')
grid on
hold off








