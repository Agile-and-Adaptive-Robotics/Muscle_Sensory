% Loading all 10mm data from csv files. 

kink = {'Unkink_','kinked25_','kinked50_','kinked75_'};
test = {'Test8','Test9','Test10'};
test_num = [8,9,10];
low_force = 0;
high_pressure = 700;
%% Loading 10mm 10cm data(Force,Pressure,t,state) for all lengths and kinks
% Note = 10cm is the cut length(lc), (lo = resting length)
lo = 8.3;
l620 = 7;
li = [8.3,7.975,7.65,7.325];
kink_p = [0 25 50 75];


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













%%% %% 15cm
% lo = 13.2;
% l620= 11.1;
% li = [13.2	12.675	12.15	11.625]
% 
% 
% %% 20cm
% lo = 18.2;
% l620= 15.2;
% li = [18.2	17.45	16.7	15.95]
% 
% 
% 
% %% 25cm
% lo = 23.3;
% l620=19.3;
% li = [23.3	22.3	21.3	20.3]
% 
% 
% 
% %% 30cm
% lo = 28.1;
% l620 = 23.2;
% li = [28.1	26.875	25.65	24.425]
% 
% 
% 
% %% 40cm
% lo = 38.2;
% l620 = 31.4;
% li = [38.2	36.5	34.8	33.1]