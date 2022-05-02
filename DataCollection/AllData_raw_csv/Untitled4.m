Kinks_20mm40cm = {'40cm_Unkinked_Test','40cm_Kinked35mm_Test','40cm_Kinked46mm_Test','40cm_Kinked69mm_Test'};
    vals_40cm = [0,35,46,69];
    
    for a = 1:length(Kinks_20mm40cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm40cm{i,a} = csvread(['20mm_',Kinks_20mm40cm{a},test,'Data.csv'])
            BPA20mm40cm{i,a}(:,4) = ones(length(BPA20mm40cm{i}),1)*20;  %col 4 = diameter
            BPA20mm40cm{i,a}(:,5) = 40;                                 %col 5 = length 
            BPA20mm40cm{i,a}(:,6) = ones(length(BPA20mm40cm{i}),1)*vals_40cm(a); %col6 = kinks
            BPA20mm40cm{i,a}(:,7) = ones(length(BPA20mm40cm{i}),1)*i;%col7 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm40cm = BPA20mm40cm{1}
for a = 1:length(Kinks_20mm40cm)
    for i =2:10
        CurrentData = BPA20mm40cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15,:); %remove data points with force below 15N
        AllBPA20mm40cm = vertcat(AllBPA20mm40cm,RealData);
    end
end