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


%% 20mm 23cm



%% 20mm 30cm 


%% 20mm 40cm 


