clear

leng = {'10','20'};

origleng = {'13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test','13cm_Unkinked_Test'}; %10mm_13cm: 4 different kink lengths
   vals = [4,8,12,0]; %kink lengths
   

for a = 1:length(origleng)
    for i = 1:10
        test = num2str(i);
        loadtest{i,a} = csvread(['10mm_',origleng{a},test,'.csv']);
        loadtest{i,a}(:,4) = ones(length(loadtest{i}),1)*i;
        loadtest{i,a}(:,5) = ones(length(loadtest{i}),1)*vals(a);
    end

end

AllData = loadtest{1};
    for a = 1:length(origleng)
        for i = 2:10
            CurrentData = loadtest{i,a};
            RealData = CurrentData(CurrentData(:,1)>0,:);
            AllData = vertcat(AllData,RealData);
        end
    end