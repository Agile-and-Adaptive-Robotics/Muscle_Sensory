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