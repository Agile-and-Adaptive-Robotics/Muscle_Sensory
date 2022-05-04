%% Diameter: 20mm
diameter  = {'20'}
lengths = {'10','12','23','30','40'}

%% 20mm 10cm 
Kinks_20mm10cm = {'10cm_Unkinked_Test','10cm_Kinked13mm_Test','10cm_Kinked20mm_Test'};
    vals_10cm = [0,13,20];
    
    for a = 1:length(Kinks_20mm10cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm10cm{i,a} = csvread(['20mm_',Kinks_20mm10cm{a},test,'Data.csv'])
            BPA20mm10cm{i,a}(:,4) = ones(length(BPA20mm10cm{i}),1)*20;  %col 4 = diameter
            BPA20mm10cm{i,a}(:,5) = 10;
            BPA20mm10cm{i,a}(:,6) = ones(length(BPA20mm10cm{i}),1)*vals_10cm(a); %col5 = kinks
            BPA20mm10cm{i,a}(:,7) = ones(length(BPA20mm10cm{i}),1)*i;%col6 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm10cm = BPA20mm10cm{1}
for a = 1:length(Kinks_20mm10cm)
    for i =2:10
        CurrentData = BPA20mm10cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15,:); %remove data points with force below 15N
        AllBPA20mm10cm = vertcat(AllBPA20mm10cm,RealData);
    end
end

%% 20mm12cm
Kinks_20mm12cm = {'12cm_Unkinked_Test','12cm_Kinked10mm_Test','12cm_Kinked20mm_Test'};
    vals_12cm = [0,10,20];
    
    for a = 1:length(Kinks_20mm12cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm12cm{i,a} = csvread(['20mm_',Kinks_20mm12cm{a},test,'.csv'])
            BPA20mm12cm{i,a}(:,4) = ones(length(BPA20mm12cm{i}),1)*20;  %col 4 = diameter
            BPA20mm12cm{i,a}(:,5) = 12;                                 %col 5 = length 
            BPA20mm12cm{i,a}(:,6) = ones(length(BPA20mm12cm{i}),1)*vals_12cm(a); %col6 = kinks
            BPA20mm12cm{i,a}(:,7) = ones(length(BPA20mm12cm{i}),1)*i;%col7 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm12cm = BPA20mm12cm{1}
for a = 1:length(Kinks_20mm12cm)
    for i =2:10
        CurrentData = BPA20mm12cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15,:); %remove data points with force below 15N
        AllBPA20mm12cm = vertcat(AllBPA20mm12cm,RealData);
    end
end




%% 20mm 23cm
Kinks_20mm23cm = {'23cm_Unkinked_Test','23cm_Kinked19mm_Test','23cm_Kinked19mm_Test'};
    vals_23cm = [0,9,19];
    
    for a = 1:length(Kinks_20mm23cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm23cm{i,a} = csvread(['20mm_',Kinks_20mm23cm{a},test,'.csv'])
            BPA20mm23cm{i,a}(:,4) = ones(length(BPA20mm23cm{i}),1)*20;  %col 4 = diameter
            BPA20mm23cm{i,a}(:,5) = 23;                                 %col 5 = length 
            BPA20mm23cm{i,a}(:,6) = ones(length(BPA20mm23cm{i}),1)*vals_23cm(a); %col6 = kinks
            BPA20mm23cm{i,a}(:,7) = ones(length(BPA20mm23cm{i}),1)*i;%col7 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm23cm = BPA20mm23cm{1}
for a = 1:length(Kinks_20mm23cm)
    for i =2:10
        CurrentData = BPA20mm23cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15,:); %remove data points with force below 15N
        AllBPA20mm23cm = vertcat(AllBPA20mm23cm,RealData);
    end
end


%% 20mm 30cm
Kinks_20mm30cm = {'30cm_Unkinked_Test','30cm_Kinked14mm_Test','30cm_Kinked23mm_Test','30cm_Kinked34mm_Test'};
    vals_30cm = [0,14,23,34];
    
    for a = 1:length(Kinks_20mm30cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm30cm{i,a} = csvread(['20mm_',Kinks_20mm30cm{a},test,'.csv'])
            BPA20mm30cm{i,a}(:,4) = ones(length(BPA20mm30cm{i}),1)*20;  %col 4 = diameter
            BPA20mm30cm{i,a}(:,5) = 30;                                 %col 5 = length 
            BPA20mm30cm{i,a}(:,6) = ones(length(BPA20mm30cm{i}),1)*vals_30cm(a); %col6 = kinks
            BPA20mm30cm{i,a}(:,7) = ones(length(BPA20mm30cm{i}),1)*i;%col7 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm30cm = BPA20mm30cm{1}
for a = 1:length(Kinks_20mm30cm)
    for i =2:10
        CurrentData = BPA20mm30cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15,:); %remove data points with force below 15N
        AllBPA20mm30cm = vertcat(AllBPA20mm30cm,RealData);
    end
end

%% 20mm 40cm 
Kinks_20mm40cm = {'40cm_Unkinked_Test','40cm_Kinked35mm_Test','40cm_Kinked46mm_Test','40cm_Kinked69mm_Test'};
    vals_40cm = [0,35,46,69];
    
    for a = 1:length(Kinks_20mm40cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm40cm{i,a} = csvread(['20mm_',Kinks_20mm40cm{a},test,'Data.csv'])
            BPA20mm40cm{i,a}(:,4) = ones(length(BPA20mm40cm{i}),1)*20;  %col 4 = diameter
            BPA20mm40cm{i,a}(:,5) = 40;                                 %col 5 = length 
            BPA20mm40cm{i,a}(:,6) = ones(length(BPA20mm40cm{i}),1)*vals_40cm(a); %col6 = kinks
            BPA20mm40cm{i,a}(:,7) = ones(length(BPA20mm40cm{i}),1)*i;   %col7 = Test#
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm40cm = BPA20mm40cm{1}
for a = 1:length(Kinks_20mm40cm)
    for i =2:10
        CurrentData = BPA20mm40cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>15&CurrentData(:,2)<700,:); %remove data points with force below 15N
        AllBPA20mm40cm = vertcat(AllBPA20mm40cm,RealData);
    end
end

%% Combine all 20mm data into a single array 

AllBPA20mm = vertcat(AllBPA20mm10cm,AllBPA20mm12cm,AllBPA20mm23cm,AllBPA20mm30cm,AllBPA20mm40cm);

