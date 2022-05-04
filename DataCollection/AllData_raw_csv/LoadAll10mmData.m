clear; clc; 

%% Diameter: 10mm
diameter = {'10'};
lengths = {'13','23','27','29','30'}

Kinks_10mm13cm = {'13cm_Unkinked_Test','13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test'};
    vals_13cm= [0,4,8,12]; 


%% 10mm 13cm data for all lengths and kinks
    for a = 1:length(Kinks_10mm13cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm13cm{i,a} = csvread(['10mm_',Kinks_10mm13cm{a},test,'.csv'])
            BPA10mm13cm{i,a}(:,4) = ones(length(BPA10mm13cm{i}),1)*10;  %col 4 = diameter
            BPA10mm13cm{i,a}(:,5) = 13;
            BPA10mm13cm{i,a}(:,6) = ones(length(BPA10mm13cm{i}),1)*vals_13cm(a); %col5 = kinks
            BPA10mm13cm{i,a}(:,7) = ones(length(BPA10mm13cm{i}),1)*i%col6 = Test#
        end
    end


% Combine all 10cm 13cm data into one array
AllBPA10mm13cm =BPA10mm13cm{1};
for a =1:length(Kinks_10mm13cm)
    for i=2:10
        CurrentData= BPA10mm13cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm13cm=vertcat(AllBPA10mm13cm,RealData);
    end
end

%% 10mm 23cm data for all lengths and kinks
Kinks_10mm23cm = {'23cm_Unkinked_Test', '23cm_Kinked14mm_Test','23cm_Kinked30mm_Test'};
    vals_23cm= [0,14,30];
    for a = 1:length(Kinks_10mm23cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm23cm{i,a} = csvread(['10mm_',Kinks_10mm23cm{a},test,'.csv'])
            BPA10mm23cm{i,a}(:,4) = ones(length(BPA10mm23cm{i}),1)*10;  %col 4 = diameter
            BPA10mm23cm{i,a}(:,5) = 23;
            BPA10mm23cm{i,a}(:,6) = ones(length(BPA10mm23cm{i}),1)*vals_23cm(a); %col5 = kinks
            BPA10mm23cm{i,a}(:,7) = ones(length(BPA10mm23cm{i}),1)*i%col6 = Test#
        end
    end


% Combine all 10cm 23cm data into one array
AllBPA10mm23cm =BPA10mm23cm{1};
for a =1:length(Kinks_10mm23cm)
    for i=2:10
        CurrentData= BPA10mm23cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm23cm=vertcat(AllBPA10mm23cm,RealData);
    end
end

%% 10mm 27cm data for all lengths and kinks
Kinks_10mm27cm = {'27cm_Unkinked_Test', '27cm_Kinked7mm_Test','27cm_Kinked15mm_Test','27cm_Kinked31mm_Test'};
    vals_27cm= [0,7,15,31];
    for a = 1:length(Kinks_10mm27cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm27cm{i,a} = csvread(['10mm_',Kinks_10mm27cm{a},test,'.csv'])
            BPA10mm27cm{i,a}(:,4) = ones(length(BPA10mm27cm{i}),1)*10;  %col 4 = diameter
            BPA10mm27cm{i,a}(:,5) = 27;
            BPA10mm27cm{i,a}(:,6) = ones(length(BPA10mm27cm{i}),1)*vals_27cm(a); %col5 = kinks
            BPA10mm27cm{i,a}(:,7) = ones(length(BPA10mm27cm{i}),1)*i%col6 = Test#
        end
    end


% Combine all 10cm 27cm data into one array
AllBPA10mm27cm =BPA10mm27cm{1};
for a =1:length(Kinks_10mm27cm)
    for i=2:10
        CurrentData= BPA10mm27cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm27cm=vertcat(AllBPA10mm27cm,RealData);
    end
end

%% 10mm29cm 
Kinks_10mm29cm = {'29cm_Unkinked_Test', '29cm_Kinked17mm_Test','29cm_Kinked28mm_Test','29cm_Kinked41mm_Test'};
    vals_29cm=[0,17,28,41];

    for a = 1:length(Kinks_10mm29cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm29cm{i,a} = csvread(['10mm_',Kinks_10mm29cm{a},test,'.csv'])
            BPA10mm29cm{i,a}(:,4) = ones(length(BPA10mm29cm{i}),1)*10;  %col 4 = diameter
            BPA10mm29cm{i,a}(:,5) =29;
            BPA10mm29cm{i,a}(:,6) = ones(length(BPA10mm29cm{i}),1)*vals_29cm(a); %col5 = kinks
            BPA10mm29cm{i,a}(:,7) = ones(length(BPA10mm29cm{i}),1)*i%col6 = Test#
        end
    end


% Combine all 10cm 29cm data into one array
AllBPA10mm29cm =BPA10mm29cm{1};
for a =1:length(Kinks_10mm29cm)
    for i=2:10
        CurrentData= BPA10mm29cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm29cm=vertcat(AllBPA10mm29cm,RealData);
    end
end


%% 10mm30cm 
Kinks_10mm30cm = {'30cm_Unkinked_Test','30cm_Kinked12mm_Test','30cm_Kinked22mm_Test','30cm_Kinked33mm_Test'}; 
    vals_30cm=[0,12,22,33];

    for a = 1:length(Kinks_10mm30cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm30cm{i,a} = csvread(['10mm_',Kinks_10mm30cm{a},test,'.csv'])
            BPA10mm30cm{i,a}(:,4) = ones(length(BPA10mm30cm{i}),1)*10;  %col 4 = diameter
            BPA10mm30cm{i,a}(:,5) =30;
            BPA10mm30cm{i,a}(:,6) = ones(length(BPA10mm30cm{i}),1)*vals_30cm(a); %col5 = kinks
            BPA10mm30cm{i,a}(:,7) = ones(length(BPA10mm30cm{i}),1)*i%col6 = Test#
        end
    end


% Combine all 10cm 29cm data into one array
AllBPA10mm30cm =BPA10mm30cm{1};
for a =1:length(Kinks_10mm30cm)
    for i=2:10
        CurrentData= BPA10mm30cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm30cm=vertcat(AllBPA10mm30cm,RealData);
    end
end

%% Combine all 10mm data into a single array

AllBPA10mm = vertcat(AllBPA10mm13cm,AllBPA10mm23cm,AllBPA10mm27cm,AllBPA10mm29cm,AllBPA10mm30cm);

