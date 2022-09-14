%Plot all 10mm data
 AllBPA10mm13cm_Force = AllBPA10mm13cm(:,1);
 AllBPA10mm13cm_Pressure = AllBPA10mm13cm(:,2);
 AllBPA10mm13cm_Time = AllBPA10mm13cm(:,3);


%% Plotting all 10mm 13cm data: All kinks and tests
vals_13cmkinks = [0,4,8,12]; 
bpalength = 13;

for a = 1:length(vals_13cmkinks)
    b = vals_13cmkinks(a)
    str = sprintf('10mm13cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data13cm = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==bpalength& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data13cm(:,2),data13cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end

%% 10mm23cm
bpalength = 23;
vals_23cmkinks = [0,14,30];
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a)
    str = sprintf('10mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data23cm = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==bpalength& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data23cm(:,2),data23cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end




%% 10mm27cm
bpalength = 27;
vals_27cmkinks = [0,7,15,31];
figure
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a)
    str = sprintf('10mm27cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data27cm = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==bpalength& AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data27cm(:,2),data27cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end

%% 10mm29cm
bpalength = 29;
vals_29cmkinks = [0,17,28,41];
figure
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a)
    str = sprintf('10mm29cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data29cm = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==bpalength& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data29cm(:,2),data29cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end

%% 10mm30cm
bpalength = 30;
vals_30cmkinks = [0,12,22,33];
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a)
    str = sprintf('10mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
        for i=1:10
           test = num2str(i);
            data30cm = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==bpalength& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data30cm(:,2),data30cm(:,1),'DisplayName',txt)
        end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end





%%
 testnumber = 9; %choosing test numner 9 as the standard
%13cm
figure
hold on
for a = 1:length(vals_13cmkinks)
    b=vals_13cmkinks(a)
    data13cm_test9 = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_13cmkinks(a))
    plot(data13cm_test9(:,2),data13cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 13cm all Kinks')

%23cm
figure
hold on
for a = 1:length(vals_23cmkinks)
    b=vals_23cmkinks(a)
    data23cm_test9 = AllBPA10mm23cm(AllBPA10mm23cm(:,5)==23& AllBPA10mm23cm(:,6)==b&AllBPA10mm23cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_23cmkinks(a))
    plot(data23cm_test9(:,2),data23cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 23cm all Kinks')

%27cm
figure
hold on
for a = 1:length(vals_27cmkinks)
    b = vals_27cmkinks(a)
    data27cm_test9 = AllBPA10mm27cm(AllBPA10mm27cm(:,5)==27&AllBPA10mm27cm(:,6)==b&AllBPA10mm27cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_27cmkinks(a))
    plot(data27cm_test9(:,2),data27cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure (kPa)')
ylabel('Force(N)')
title('10mm 27cm all Kinks')

%29cm
figure
hold on
for a = 1:length(vals_29cmkinks)
    b = vals_29cmkinks(a)
    data29cm_test9 = AllBPA10mm29cm(AllBPA10mm29cm(:,5)==29& AllBPA10mm29cm(:,6)==b&AllBPA10mm29cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_29cmkinks(a))
    plot(data29cm_test9(:,2),data29cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 29cm all Kinks')

%30cm
figure
hold on
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a)
    data30cm_test9 = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==30& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==testnumber,:);
    txt = sprintf('%dmm',vals_30cmkinks(a))
    plot(data30cm_test9(:,2),data30cm_test9(:,1),'DisplayName',txt)
end
hold off
legend
xlabel('Pressure(kPa)')
ylabel('Force(N)')
title('10mm 30cm all Kinks')


