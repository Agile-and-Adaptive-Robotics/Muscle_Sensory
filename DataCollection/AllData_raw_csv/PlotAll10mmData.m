%Plot all 10mm data
 AllBPA10mm13cm_Force = AllBPA10mm13cm(:,1);
 AllBPA10mm13cm_Pressure = AllBPA10mm13cm(:,2);
 AllBPA10mm13cm_Time = AllBPA10mm13cm(:,3);


 %% comparing between test# 
% 10mm 13cm (Unkink) %shown in column 5
vals_13cmkinks = [0,4,8,12]; %shown in column 6
for a = 1:length(vals_13cmkinks)
    b = vals_13cmkinks(a)
    str = sprintf('10mm13cm_%dmm',b);
    figure(a)
    hold on
        for i=1:10
           test = num2str(i);
            data13cm = AllBPA10mm13cm(AllBPA10mm13cm(:,5)==13& AllBPA10mm13cm(:,6)==b&AllBPA10mm13cm(:,7)==i,:); %choosing all 13cm data
            txt = sprintf('%sTest%s',str,test) 
            plot(data13cm(:,2),data13cm(:,1),'.','DisplayName',txt)
        end
    hold off
    legend
    title('10mm 13cm Pressure vs Force')
    xlabel('Pressure(kPa)')
    ylabel('Force(N)')
end

%% 
str = {'AllBPA10mm13cm','AllBPA10mm23cm','AllBPA10mm27cm','AllBPA10mm29cm','AllBPA10mm30cm'};
  