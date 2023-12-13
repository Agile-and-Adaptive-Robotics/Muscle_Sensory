%Clean up workspace. Comment out if also using data from LoadAll10mmData.
clear; clc; close all

% Loading all 10mm data from csv files. 

kink = {'Unkink_','kinked25_','kinked50_','kinked75_'};
test = {'Test8','Test9','Test10'};
test_num = [8,9,10];
low_force = 3;
high_pressure = 800;
kink_p = [0 25 50 75];

num = 50  %number of data points
%% Loading 10mm 10cm data(Force,Pressure,t,state) for all lengths and kinks
% Note = 10cm is the cut length(lc), (lo = resting length)
lo = 8.3;
l620 = 7;
li = [8.3,7.975,7.65,7.325];

    for b=1:length(test)
        for a = 1:length(kink_p)
            BPA10mm10cm{b,a}=csvread(['10mm_10cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm10cm{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm10cm{b,a}(:,4) ==2);
            BPA10mm10cm{b,a}(idx_DP,8) = 0;
            BPA10mm10cm{b,a}(idx,8) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm10cm{b,a}(:,4) = ones(length(BPA10mm10cm{b,a}),1)*10; %diameter
            BPA10mm10cm{b,a}(:,5) = ones(length(BPA10mm10cm{b,a}),1)*10; %cut length(lc)
            BPA10mm10cm{b,a}(:,6) = ones(length(BPA10mm10cm{b,a}),1)*kink_p(a); %attempted kink percent
            BPA10mm10cm{b,a}(:,7) = ones(length(BPA10mm10cm{b,a}),1)*test_num(b); %test number
            BPA10mm10cm{b,a}(:,9) = ones(length(BPA10mm10cm{b,a}),1)*lo; %resting length(lo) 
            BPA10mm10cm{b,a}(:,10) = ones(length(BPA10mm10cm{b,a}),1)*l620;   %length at 620 kPa
            BPA10mm10cm{b,a}(:,11) = ones(length(BPA10mm10cm{b,a}),1)*li(a);   %current length
            BPA10mm10cm{b,a}(:,12) = -((li(a)-lo)/lo); %strain
            BPA10mm10cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm10cm{b,a}=imresize(BPA10mm10cm{b,a},[num 13]) %resize it all to remove excess data (already checked for accuracy
        end
    end
%combining data into a single array

AllBPA10mm10cm = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm10cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm10cm=vertcat(AllBPA10mm10cm,RealData);
    end
end
AllBPA10mm10cm = AllBPA10mm10cm(AllBPA10mm10cm(:,1)>low_force&AllBPA10mm10cm(:,2)<high_pressure,:);
%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm10cm(:,4)==1);
id_DP = (AllBPA10mm10cm(:,4)==2);

%Separating P and DP
AllBPA10mm10cm_P = AllBPA10mm10cm(id_P,1:14);
AllBPA10mm10cm_DP = AllBPA10mm10cm(id_DP,1:14);

%% 15cm
lo = 13.2;
l620= 11.1;
li = [13.2	12.675	12.15	11.625];

    for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm15cm{b,a}=csvread(['10mm_15cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm15cm{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm15cm{b,a}(:,4) ==2);
            BPA10mm15cm{b,a}(idx_DP,4) = zeros(length(BPA10mm15cm{b,a}),1);
            BPA10mm15cm{b,a}(idx,4) = ones(length(BPA10mm15cm{b,a}),1); %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm15cm{b,a}(:,5) = ones(length(BPA10mm15cm{b,a}),1)*10; %diameter
            BPA10mm15cm{b,a}(:,6) = 15; %cut length(lc) 
            BPA10mm15cm{b,a}(:,7) = ones(length(BPA10mm15cm{b,a}),1)*lo; %resting length(lo) 
            BPA10mm15cm{b,a}(:,8) = kink_p(a); %attempted kink
            BPA10mm15cm{b,a}(:,9) = li(a);  %current length
            BPA10mm15cm{b,a}(:,10) = l620;  %length at 620
            BPA10mm15cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm15cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm15cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm15cm{b,a}(:,14) = ones(length(BPA10mm15cm{b,a}),1)*test_num(b); %test number
            BPA10mm15cm{b,a}=imresize(BPA10mm15cm{b,a},[num 14],'nearest')
        end
    end
%combining data into a single array
AllBPA10mm15cm = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm15cm{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm15cm=vertcat(AllBPA10mm15cm,RealData);
    end
end
AllBPA10mm15cm = AllBPA10mm15cm(AllBPA10mm15cm(:,1)>low_force&AllBPA10mm15cm(:,2)<high_pressure,:);

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
            idx = (BPA10mm20cm{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm20cm{b,a}(:,4) ==2);
            BPA10mm20cm{b,a}(idx_DP,4) =2;
            BPA10mm20cm{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm20cm{b,a}(:,5) = ones(length(BPA10mm20cm{b,a}),1)*10; %diameter
            BPA10mm20cm{b,a}(:,6) = 20; %cut length(lc) 
            BPA10mm20cm{b,a}(:,7) = ones(length(BPA10mm20cm{b,a}),1)*lo; %resting length(lo) 
            BPA10mm20cm{b,a}(:,8) = kink_p(a); 
            BPA10mm20cm{b,a}(:,9) = li(a);
            BPA10mm20cm{b,a}(:,10) = l620;
            BPA10mm20cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm20cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm20cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm20cm{b,a}(:,14) = ones(length(BPA10mm20cm{b,a}),1)*test_num(b);
            BPA10mm20cm{b,a}=imresize(BPA10mm20cm{b,a},[num 14],'nearest')
        end
    end
%combining data into a single array
AllBPA10mm20cm = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm20cm{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm20cm=vertcat(AllBPA10mm20cm,RealData);
    end
end
AllBPA10mm20cm = AllBPA10mm20cm(AllBPA10mm20cm(:,1)>low_force&AllBPA10mm20cm(:,2)<high_pressure,:);
id_P = (AllBPA10mm20cm(:,4)==1);
id_DP = (AllBPA10mm20cm(:,4)==2);

%Separating P and DP
AllBPA10mm20cm_P  = AllBPA10mm20cm(id_P,1:14);
AllBPA10mm20cm_DP = AllBPA10mm20cm(id_DP,1:14);


%% 25cm
lo = 23.3;
l620=19.3;
li = [23.3	22.3	21.3	20.3];
    for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm25cm{b,a}=csvread(['10mm_25cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm25cm{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm25cm{b,a}(:,4) ==2);
            BPA10mm25cm{b,a}(idx_DP,4) =2;
            BPA10mm25cm{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm25cm{b,a}(:,5) = ones(length(BPA10mm25cm{b,a}),1)*10; %diameter
            BPA10mm25cm{b,a}(:,6) = 25; %cut length(lc) 
            BPA10mm25cm{b,a}(:,7) = ones(length(BPA10mm25cm{b,a}),1)*lo; %resting length(lo) 
            BPA10mm25cm{b,a}(:,8) = kink_p(a); 
            BPA10mm25cm{b,a}(:,9) = li(a);
            BPA10mm25cm{b,a}(:,10) = l620;
            BPA10mm25cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm25cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm25cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm25cm{b,a}(:,14) = ones(length(BPA10mm25cm{b,a}),1)*test_num(b);
            BPA10mm25cm{b,a}=imresize(BPA10mm25cm{b,a},[num 14],'nearest')
        end
    end
%combining data into a single array
AllBPA10mm25cm = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm25cm{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm25cm=vertcat(AllBPA10mm25cm,RealData);
    end
end
AllBPA10mm25cm = AllBPA10mm25cm(AllBPA10mm25cm(:,1)>low_force&AllBPA10mm25cm(:,2)<high_pressure,:);
id_P = (AllBPA10mm25cm(:,4)==1);
id_DP = (AllBPA10mm25cm(:,4)==2);

%Separating P and DP
AllBPA10mm25cm_P  = AllBPA10mm25cm(id_P,1:14);
AllBPA10mm25cm_DP = AllBPA10mm25cm(id_DP,1:14);


%% 30cm, use _2 to differentiate from 30cm data from LoadAll10mmData
lo = 28.1;
l620 = 23.2;
li = [28.1	26.875	25.65	24.425];
    for a = 1:length(kink_p)
        for b=1:length(test)
            BPA10mm30cm_2{b,a}=csvread(['10mm_30cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm30cm_2{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm30cm_2{b,a}(:,4) ==2);
            BPA10mm30cm_2{b,a}(idx_DP,4) =2;
            BPA10mm30cm_2{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm30cm_2{b,a}(:,5) = ones(length(BPA10mm30_2cm{b,a}),1)*10; %diameter
            BPA10mm30cm_2{b,a}(:,6) = 30; %cut length(lc) 
            BPA10mm30cm_2{b,a}(:,7) = ones(length(BPA10mm30cm_2{b,a}),1)*lo; %resting length(lo) 
            BPA10mm30cm_2{b,a}(:,8) = kink_p(a); 
            BPA10mm30cm_2{b,a}(:,9) = li(a);
            BPA10mm30cm_2{b,a}(:,10) = l620;
            BPA10mm30cm_2{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm30cm_2{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm30cm_2{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm30cm_2{b,a}(:,14) = ones(length(BPA10mm30cm_2{b,a}),1)*test_num(b);
            BPA10mm30cm_2{b,a}=imresize(BPA10mm30cm_2{b,a},[num 14],'nearest')
        end
    end
%combining data into a single array
AllBPA10mm30cm_2 = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm30cm_2{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm30cm_2=vertcat(AllBPA10mm30cm_2,RealData);
    end
end
AllBPA10mm30cm_2 = AllBPA10mm30cm_2(AllBPA10mm30cm_2(:,1)>low_force&AllBPA10mm30cm_2(:,2)<high_pressure,:);
id_P = (AllBPA10mm30cm_2(:,4)==1);
id_DP = (AllBPA10mm30cm_2(:,4)==2);

%Separating P and DP
AllBPA10mm30cm_2_P  = AllBPA10mm30cm_2(id_P,1:14);
AllBPA10mm30cm_2_DP = AllBPA10mm30cm_2(id_DP,1:14);



%% 40cm
lo = 38.2;
l620 = 31.4;
li = [38.2	36.5	34.8	33.1];

        for a = 1:length(kink_p)
          for b=1:length(test)
            BPA10mm40cm{b,a}=csvread(['10mm_40cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm40cm{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm40cm{b,a}(:,4) ==2);
            BPA10mm40cm{b,a}(idx_DP,4) =2;
            BPA10mm40cm{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm40cm{b,a}(:,5) = ones(length(BPA10mm15cm{b,a}),1)*10; %diameter
            BPA10mm40cm{b,a}(:,6) = 40; %cut length(lc) 
            BPA10mm40cm{b,a}(:,7) = ones(length(BPA10mm40cm{b,a}),1)*lo; %resting length(lo) 
            BPA10mm40cm{b,a}(:,8) = kink_p(a); 
            BPA10mm40cm{b,a}(:,9) = li(a);
            BPA10mm40cm{b,a}(:,10) = l620;
            BPA10mm40cm{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm40cm{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm40cm{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm40cm{b,a}(:,14) = ones(length(BPA10mm40cm{b,a}),1)*test_num(b);
            BPA10mm40cm{b,a}=imresize(BPA10mm40cm{b,a},[num 14],'nearest')
          end
         end
%combining data into a single array
AllBPA10mm40cm = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm40cm{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm40cm=vertcat(AllBPA10mm40cm,RealData);
    end
end
AllBPA10mm40cm = AllBPA10mm40cm(AllBPA10mm40cm(:,1)>low_force&AllBPA10mm40cm(:,2)<high_pressure,:);
id_P = (AllBPA10mm40cm(:,4)==1);
id_DP = (AllBPA10mm40cm(:,4)==2);

%Separating P and DP
AllBPA10mm40cm_P  = AllBPA10mm40cm(id_P,1:14);
AllBPA10mm40cm_DP = AllBPA10mm40cm(id_DP,1:14);

%% 45cm, use _2 to differentiate from Ben's test (Bipedal robot)
lo = 42.6;
l620 = 35.1;
li = [42.6];

        for a = 1:length(li)
          for b=1:length(test)
            BPA10mm45cm_2{b,a}=csvread(['10mm_45cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm45cm_2{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm45cm_2{b,a}(:,4) ==2);
            BPA10mm45cm_2{b,a}(idx_DP,4) =2;
            BPA10mm45cm_2{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm45cm_2{b,a}(:,5) = ones(length(BPA10mm45_2cm{b,a}),1)*10; %diameter
            BPA10mm45cm_2{b,a}(:,6) = 40; %cut length(lc) 
            BPA10mm45cm_2{b,a}(:,7) = ones(length(BPA10mm45cm_2{b,a}),1)*lo; %resting length(lo) 
            BPA10mm45cm_2{b,a}(:,8) = kink_p(a); 
            BPA10mm45cm_2{b,a}(:,9) = li(a);
            BPA10mm45cm_2{b,a}(:,10) = l620;
            BPA10mm45cm_2{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm45cm_2{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm45cm_2{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm45cm_2{b,a}(:,14) = ones(length(BPA10mm45cm_2{b,a}),1)*test_num(b);
            BPA10mm45cm_2{b,a}=imresize(BPA10mm45cm_2{b,a},[num 14],'nearest')
          end
         end
%combining data into a single array
AllBPA10mm45cm_2 = zeros(1,14);
for a = 1:length(li)
    for i=2:3
        CurrentData=BPA10mm45cm_2{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm45cm_2=vertcat(AllBPA10mm45cm_2,RealData);
    end
end
AllBPA10mm45cm_2 = AllBPA10mm45cm_2(AllBPA10mm45cm_2(:,1)>low_force&AllBPA10mm45cm_2(:,2)<high_pressure,:);
id_P = (AllBPA10mm45cm_2(:,4)==1);
id_DP = (AllBPA10mm45cm_2(:,4)==2);

%Separating P and DP
AllBPA10mm45cm_2_P  = AllBPA10mm45cm_2(id_P,1:14);
AllBPA10mm45cm_2_DP = AllBPA10mm45cm_2(id_DP,1:14);

%% 52cm, use _2 to differentiate from 52cm data from Ben's test (Bipedal robot)
lo = 52.1;
l620 = 43.7;
li = [52.1	50	47.9  45.8];

        for a = 1:length(kink_p)
          for b=1:length(test)
            BPA10mm52cm_2{b,a}=csvread(['10mm_52cm_',kink{a},test{b},'.csv']);
            idx = (BPA10mm52cm_2{b,a}(:,4) == 1); %indexing the pressurizing part
            idx_DP = (BPA10mm52cm_2{b,a}(:,4) ==2);
            BPA10mm52cm_2{b,a}(idx_DP,4) =2;
            BPA10mm52cm_2{b,a}(idx,4) = 1; %pressurizing = #1 on column 4, depressurizing = 2;
            BPA10mm52cm_2{b,a}(:,5) = ones(length(BPA10mm52_2cm{b,a}),1)*10; %diameter
            BPA10mm52cm_2{b,a}(:,6) = 40; %cut length(lc) 
            BPA10mm52cm_2{b,a}(:,7) = ones(length(BPA10mm52cm_2{b,a}),1)*lo; %resting length(lo) 
            BPA10mm52cm_2{b,a}(:,8) = kink_p(a); 
            BPA10mm52cm_2{b,a}(:,9) = li(a);
            BPA10mm52cm_2{b,a}(:,10) = l620;
            BPA10mm52cm_2{b,a}(:,11) = -((li(a)-lo)/lo); %strain
            BPA10mm52cm_2{b,a}(:,12) = -((l620-lo)/lo); %max strain
            BPA10mm52cm_2{b,a}(:,13) = ((li(a)-lo)/lo)/((l620-lo)/lo);%relative strain
            BPA10mm52cm_2{b,a}(:,14) = ones(length(BPA10mm52cm_2{b,a}),1)*test_num(b);
            BPA10mm52cm_2{b,a}=imresize(BPA10mm52cm_2{b,a},[num 14],'nearest')
          end
         end
%combining data into a single array
AllBPA10mm52cm_2 = zeros(1,14);
for a = 1:length(kink_p)
    for i=2:3
        CurrentData=BPA10mm52cm_2{b,a};
        RealData= CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %%%
        AllBPA10mm52cm_2=vertcat(AllBPA10mm52cm_2,RealData);
    end
end
AllBPA10mm52cm_2 = AllBPA10mm52cm_2(AllBPA10mm52cm_2(:,1)>low_force&AllBPA10mm52cm_2(:,2)<high_pressure,:);
id_P = (AllBPA10mm52cm_2(:,4)==1);
id_DP = (AllBPA10mm52cm_2(:,4)==2);

%Separating P and DP
AllBPA10mm52cm_2_P  = AllBPA10mm52cm_2(id_P,1:14);
AllBPA10mm52cm_2_DP = AllBPA10mm52cm_2(id_DP,1:14);


%% Combine all 10mm data into a single array

AllBPA10mm_2 = vertcat(AllBPA10mm10cm,AllBPA10mm15cm,AllBPA10mm20cm,AllBPA10mm25cm,AllBPA10mm30cm_2, AllBPA10mm40cm, AllBPA10mm45cm_2, AllBPA10mm52cm_2);
id_P = (AllBPA10mm_2(:,4)==1);
id_DP = (AllBPA10mm_2(:,4)==2);
AllBPA10mm_2_P  = AllBPA10mm_2(id_P,1:14);
AllBPA10mm_2_DP = AllBPA10mm_2(id_DP,1:14);


%% plots to check data
% 10mm 10cm
    figure
    subplot 121
    plot(AllBPA10mm10cm_P(:,3),AllBPA10mm10cm_P(:,1),'b.');
    xlabel('time (s)')
    ylabel('Force(N)')
    title('10mm 10cm Pressurizing - all kinks')
    subplot 122
    plot(AllBPA10mm10cm_DP(:,3),AllBPA10mm10cm_DP(:,1),'r.');
    title('10mm 10cm Depressurizing - all kinks')
    xlabel('time (s)')
    ylabel('Force(N)')
% 10mm 15cm
    figure
    subplot 121
    plot(AllBPA10mm15cm_P(:,3),AllBPA10mm15cm_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm15cm_DP(:,3),AllBPA10mm15cm_DP(:,1),'ro');
    title('10mm15cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
% 10mm 20cm
    figure
    subplot 121
    plot(AllBPA10mm20cm_P(:,3),AllBPA10mm20cm_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm20cm_DP(:,3),AllBPA10mm20cm_DP(:,1),'ro');
    title('10mm20cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
%10mm 25cm
    figure
    subplot 121
    plot(AllBPA10mm25cm_P(:,3),AllBPA10mm25cm_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm25cm_DP(:,3),AllBPA10mm25cm_DP(:,1),'ro');
    title('10mm25cm all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on

%10mm 30cm_2
    figure
    subplot 121
    plot(AllBPA10mm30cm_2_P(:,3),AllBPA10mm30cm_2_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm30cm_2_DP(:,3),AllBPA10mm30cm_2_DP(:,1),'ro');
    title('10mm30cm_2 all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
    
% 10mm 40cm
    figure
    subplot 121
    plot(AllBPA10mm40cm_P(:,3),AllBPA10mm40cm_P(:,1),'b.');
    xlabel('time (s)')
    ylabel('Force(N)')
    title('10mm 40cm Pressurizing - all kinks')
    subplot 122
    plot(AllBPA10mm40cm_DP(:,3),AllBPA10mm40cm_DP(:,1),'r.');
    title('10mm 40cm Depressurizing - all kinks')
    xlabel('time (s)')
    ylabel('Force(N)')
    
%10mm 45cm_2
    figure
    subplot 121
    plot(AllBPA10mm45cm_2_P(:,3),AllBPA10mm45cm_2_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm45cm_2_DP(:,3),AllBPA10mm45cm_2_DP(:,1),'ro');
    title('10mm45cm_2 all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on

%10mm 52cm_2
    figure
    subplot 121
    plot(AllBPA10mm52cm_2_P(:,3),AllBPA10mm52cm_2_P(:,1),'bo');
    subplot 122
    plot(AllBPA10mm52cm_2_DP(:,3),AllBPA10mm52cm_2_DP(:,1),'ro');
    title('10mm52cm_2 all kinks')
    xlabel('Time(s)')
    ylabel('Force(N)')
    grid on
