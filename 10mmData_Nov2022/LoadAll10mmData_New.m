% Loading all 10mm data from csv files. 

kink = {'Unkink_','kinked25_','kinked50_','kinked75_'};
test = {'Test8','Test9','Test10'};
test_num = [8,9,10];
low_force = 0;
high_pressure = 700;
kink_p = [0 25 50 75];
%% Loading 10mm 10cm data(Force,Pressure,t,state) for all lengths and kinks
% Note = 10cm is the cut length(lc), (lo = resting length)
lo = 8.3;
l620 = 7;
li = [8.3,7.975,7.65,7.325];



    for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm10cm{b,a}=csvread(['10mm_10cm_',kink{a},test{b},'.csv'])
            BPA10mm10cm{b,a}(:,5) = 10; %diameter
            BPA10mm10cm{b,a}(:,6) = 10; %cut length(lc) 
            BPA10mm10cm{b,a}(:,7) = ones(length(BPA10mm10cm{b}),1)*lo; %resting length(lo) 
            BPA10mm10cm{b,a}(:,8) = kink_p(a); 
            BPA10mm10cm{b,a}(:,9) = li(a);
            BPA10mm10cm{b,a}(:,10) = l620;
            BPA10mm10cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm10cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm10cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm10cm{b,a}(:,14) = ones(length(BPA10mm10cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm10cm = BPA10mm10cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm10cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm10cm=vertcat(AllBPA10mm10cm,RealData);
    end
end
id_P = (AllBPA10mm10cm(:,4)==1);
id_DP = (AllBPA10mm10cm(:,4)==2);

%Separating P and DP
AllBPA10mm10cm_P  = AllBPA10mm10cm(id_P,1:14);
AllBPA10mm10cm_DP = AllBPA10mm10cm(id_DP,1:14);

%% 15cm
lo = 13.2;
l620= 11.1;
li = [13.2	12.675	12.15	11.625];

    for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm15cm{b,a}=csvread(['10mm_15cm_',kink{a},test{b},'.csv'])
            BPA10mm15cm{b,a}(:,5) = 10; %diameter
            BPA10mm15cm{b,a}(:,6) = 15; %cut length(lc) 
            BPA10mm15cm{b,a}(:,7) = ones(length(BPA10mm15cm{b}),1)*lo; %resting length(lo) 
            BPA10mm15cm{b,a}(:,8) = kink_p(a); 
            BPA10mm15cm{b,a}(:,9) = li(a);
            BPA10mm15cm{b,a}(:,10) = l620;
            BPA10mm15cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm15cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm15cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm15cm{b,a}(:,14) = ones(length(BPA10mm15cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm15cm = BPA10mm15cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm15cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm15cm=vertcat(AllBPA10mm15cm,RealData);
    end
end
id_P = (AllBPA10mm15cm(:,4)==1);
id_DP = (AllBPA10mm15cm(:,4)==2);

%Separating P and DP
AllBPA10mm15cm_P  = AllBPA10mm15cm(id_P,1:14);
AllBPA10mm15cm_DP = AllBPA10mm15cm(id_DP,1:14);


%% 20cm
lo = 18.2;
l620= 15.2;
li = [18.2	17.45	16.7	15.95];

        for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm20cm{b,a}=csvread(['10mm_20cm_',kink{a},test{b},'.csv'])
            BPA10mm20cm{b,a}(:,5) = 10; %diameter
            BPA10mm20cm{b,a}(:,6) = 20; %cut length(lc) 
            BPA10mm20cm{b,a}(:,7) = ones(length(BPA10mm20cm{b}),1)*lo; %resting length(lo) 
            BPA10mm20cm{b,a}(:,8) = kink_p(a); 
            BPA10mm20cm{b,a}(:,9) = li(a);
            BPA10mm20cm{b,a}(:,10) = l620;
            BPA10mm20cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm20cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm20cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm20cm{b,a}(:,14) = ones(length(BPA10mm20cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm20cm = BPA10mm20cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm20cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm20cm=vertcat(AllBPA10mm20cm,RealData);
    end
end
id_P = (AllBPA10mm20cm(:,4)==1);
id_DP = (AllBPA10mm20cm(:,4)==2);

%Separating P and DP
AllBPA10mm20cm_P  = AllBPA10mm20cm(id_P,1:14);
AllBPA10mm20cm_DP = AllBPA10mm20cm(id_DP,1:14);


%% 25cm
lo = 23.3;
l620=19.3;
li = [23.3	22.3	21.3	20.3]
            for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm25cm{b,a}=csvread(['10mm_25cm_',kink{a},test{b},'.csv'])
            BPA10mm25cm{b,a}(:,5) = 10; %diameter
            BPA10mm25cm{b,a}(:,6) = 25; %cut length(lc) 
            BPA10mm25cm{b,a}(:,7) = ones(length(BPA10mm25cm{b}),1)*lo; %resting length(lo) 
            BPA10mm25cm{b,a}(:,8) = kink_p(a); 
            BPA10mm25cm{b,a}(:,9) = li(a);
            BPA10mm25cm{b,a}(:,10) = l620;
            BPA10mm25cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm25cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm25cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm25cm{b,a}(:,14) = ones(length(BPA10mm25cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm25cm = BPA10mm25cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm25cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm25cm=vertcat(AllBPA10mm25cm,RealData);
    end
end
id_P = (AllBPA10mm25cm(:,4)==1);
id_DP = (AllBPA10mm25cm(:,4)==2);

%Separating P and DP
AllBPA10mm25cm_P  = AllBPA10mm25cm(id_P,1:14);
AllBPA10mm25cm_DP = AllBPA10mm25cm(id_DP,1:14);


%% 30cm
lo = 28.1;
l620 = 23.2;
li = [28.1	26.875	25.65	24.425]
        for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm30cm{b,a}=csvread(['10mm_30cm_',kink{a},test{b},'.csv'])
            BPA10mm30cm{b,a}(:,5) = 10; %diameter
            BPA10mm30cm{b,a}(:,6) = 30; %cut length(lc) 
            BPA10mm30cm{b,a}(:,7) = ones(length(BPA10mm30cm{b}),1)*lo; %resting length(lo) 
            BPA10mm30cm{b,a}(:,8) = kink_p(a); 
            BPA10mm30cm{b,a}(:,9) = li(a);
            BPA10mm30cm{b,a}(:,10) = l620;
            BPA10mm30cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm30cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm30cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm30cm{b,a}(:,14) = ones(length(BPA10mm30cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm30cm = BPA10mm30cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm30cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm30cm=vertcat(AllBPA10mm30cm,RealData);
    end
end
id_P = (AllBPA10mm30cm(:,4)==1);
id_DP = (AllBPA10mm30cm(:,4)==2);

%Separating P and DP
AllBPA10mm30cm_P  = AllBPA10mm30cm(id_P,1:14);
AllBPA10mm30cm_DP = AllBPA10mm30cm(id_DP,1:14);



%% 40cm
lo = 38.2;
l620 = 31.4;
li = [38.2	36.5	34.8	33.1]

        for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm40cm{b,a}=csvread(['10mm_40cm_',kink{a},test{b},'.csv'])
            BPA10mm40cm{b,a}(:,5) = 10; %diameter
            BPA10mm40cm{b,a}(:,6) = 40; %cut length(lc) 
            BPA10mm40cm{b,a}(:,7) = ones(length(BPA10mm40cm{b}),1)*lo; %resting length(lo) 
            BPA10mm40cm{b,a}(:,8) = kink_p(a); 
            BPA10mm40cm{b,a}(:,9) = li(a);
            BPA10mm40cm{b,a}(:,10) = l620;
            BPA10mm40cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm40cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm40cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm40cm{b,a}(:,14) = ones(length(BPA10mm40cm{b}),1)*test_num(b);
        end
    end
%combining data into a single array
AllBPA10mm40cm = BPA10mm40cm{1};
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm40cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm40cm=vertcat(AllBPA10mm40cm,RealData);
    end
end
id_P = (AllBPA10mm40cm(:,4)==1);
id_DP = (AllBPA10mm40cm(:,4)==2);

%Separating P and DP
AllBPA10mm40cm_P  = AllBPA10mm40cm(id_P,1:14);
AllBPA10mm40cm_DP = AllBPA10mm40cm(id_DP,1:14);