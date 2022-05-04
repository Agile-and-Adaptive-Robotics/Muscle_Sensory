%Plot all 20mm data


% 20mm10cm 
bpalength = 10;
vals_10cmkinks = [0,13,20];

for a = 1:length(vals_10cmkinks)
    b = vals_10cmkinks(a)
    str = sprintf('20mm10cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data10cm = AllBPA20mm10cm(AllBPA20mm10cm(:,5)==bpalength&AllBPA20mm10cm(:,6)==b&AllBPA20mm10cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test)
        plot(data10cm(:,2),data10cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end

%% 20mm 12cm
bpalength = 12;
vals_12cmkinks = [0,10,20]
figure
for a = 1:length(vals_12cmkinks)
    b = vals_12cmkinks(a)
    str = sprintf('20mm12cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data12cm = AllBPA20mm12cm(AllBPA20mm12cm(:,5)==bpalength&AllBPA20mm12cm(:,6)==b&AllBPA20mm12cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test)
        plot(data12cm(:,2),data12cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end


%% 20mm 23cm %% something wrong with 9mm and 19mm data (they're plotting the same thing) 
bpalength = 23;
vals_23cmkinks = [0,9,19]
figure
for a = 1:length(vals_23cmkinks)
    b = vals_23cmkinks(a)
    str = sprintf('20mm23cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data23cm = AllBPA20mm23cm(AllBPA20mm23cm(:,5)==bpalength&AllBPA20mm23cm(:,6)==b&AllBPA20mm23cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test)
        plot(data23cm(:,2),data23cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end


%% 20mm 30cm 
bpalength = 30;
vals_30cmkinks = [0,14,23,34]
figure
for a = 1:length(vals_30cmkinks)
    b = vals_30cmkinks(a)
    str = sprintf('20mm30cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data30cm = AllBPA20mm30cm(AllBPA20mm30cm(:,5)==bpalength&AllBPA20mm30cm(:,6)==b&AllBPA20mm30cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test)
        plot(data30cm(:,2),data30cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end


%% 20mm 40cm 
bpalength = 40;
vals_40cmkinks = [0,35,46,69]
figure
for a = 1:length(vals_40cmkinks)
    b = vals_40cmkinks(a)
    str = sprintf('20mm40cm%dmm',b);
    subplot(2,2,a)
    hold on
    for i = 1:10
        test = num2str(i);
        data40cm = AllBPA20mm40cm(AllBPA20mm40cm(:,5)==bpalength&AllBPA20mm40cm(:,6)==b&AllBPA20mm40cm(:,7)==i,:); 
        txt = sprintf('%sTest%s',str,test)
        plot(data40cm(:,2),data40cm(:,1),'DisplayName',txt)
    end
    hold off
    legend
    title(str)
    xlabel('Pressure(kPa)')
    ylabel('Force (N)')
end


