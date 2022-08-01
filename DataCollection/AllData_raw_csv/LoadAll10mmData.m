close all; clc; 

%% Diameter: 10mm
diameter = {'10'};
lengths_10mm = {'13','23','27','29','30'}

% Calculating strains and relative strains
%10mm
    maxstrain_13cm = (12-10)/12;
    maxstrain_23cm = (22-18.5)/22;
    maxstrain_27cm = (25.7-21.8)/25.7;
    maxstrain_29cm = (28.1-23.5)/28.1;
    maxstrain_30cm = (28.1-24)/28.1;

%% 10mm 13cm data for all lengths and kinks
Kinks_10mm13cm = {'13cm_Unkinked_Test','13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test'};
lo = 12;
l620 = 10;
li = [12,11.6,11.2,10.8];
    vals_13cm= [0,4,8,12]; 
    for a = 1:length(Kinks_10mm13cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm13cm{i,a} = csvread(['10mm_',Kinks_10mm13cm{a},test,'.csv'])
            BPA10mm13cm{i,a}(:,4) = ones(length(BPA10mm13cm{i}),1)*10;  %col 4 = diameter
            BPA10mm13cm{i,a}(:,5) = 13;
            BPA10mm13cm{i,a}(:,6) = ones(length(BPA10mm13cm{i}),1)*vals_13cm(a); %col6 = kinks
            BPA10mm13cm{i,a}(:,7) = ones(length(BPA10mm13cm{i}),1)*i%col7 = Test#
            idx = BPA10mm13cm{i,a}(:,3) <17; %indexing the pressurizing part
            idx_DP = BPA10mm13cm{i,a}(:,3) >=17;
            BPA10mm13cm{i,a}(idx_DP,8) =0;
            BPA10mm13cm{i,a}(idx,8) = 1 %pressurizing = #1 on column 8, depressurizing = 0;
            BPA10mm13cm{i,a}(:,9) = lo;
            BPA10mm13cm{i,a}(:,10)= l620;
            BPA10mm13cm{i,a}(:,11)= li(a);
            BPA10mm13cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA10mm13cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_13cm; %relative strain
        end
    end


% Combine all 10cm 13cm data into one array
AllBPA10mm13cm =BPA10mm13cm{1};
for a =1:length(Kinks_10mm13cm)
    for i=2:10
        CurrentData= BPA10mm13cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>10,:); %%%
        AllBPA10mm13cm=vertcat(AllBPA10mm13cm,RealData);%CurrentData);%RealData);
    end
end

%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm13cm(:,8)==1);
id_DP = (AllBPA10mm13cm(:,8)==0);

AllBPA10mm13cm_P = AllBPA10mm13cm(id_P,1:13);
AllBPA10mm13cm_DP = AllBPA10mm13cm(id_DP,1:13);

figure
subplot 121
plot(AllBPA10mm13cm(id_P,3),AllBPA10mm13cm(id_P,1),'b.');
xlabel('time (s)')
ylabel('Force(N)')
title('10mm 13cm Pressurizing - all kinks')
subplot 122
plot(AllBPA10mm13cm(id_DP,3),AllBPA10mm13cm(id_DP,1),'r.');
title('10mm 13cm Depressurizing - all kinks')
xlabel('time (s)')
ylabel('Force(N)')



%% 10mm 23cm data for all lengths and kinks
Kinks_10mm23cm = {'23cm_Unkinked_Test', '23cm_Kinked14mm_Test','23cm_Kinked30mm_Test'};
    vals_23cm= [0,14,30];
    lo = 22;
    l620 = 18.5;
    li = [22,20.5,18.9];
    for a = 1:length(Kinks_10mm23cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm23cm{i,a} = csvread(['10mm_',Kinks_10mm23cm{a},test,'.csv'])
            BPA10mm23cm{i,a}(:,4) = ones(length(BPA10mm23cm{i}),1)*10;  %col 4 = diameter
            BPA10mm23cm{i,a}(:,5) = 23;
            BPA10mm23cm{i,a}(:,6) = ones(length(BPA10mm23cm{i}),1)*vals_23cm(a); %col5 = kinks
            BPA10mm23cm{i,a}(:,7) = ones(length(BPA10mm23cm{i}),1)*i%col6 = Test#
            idx = BPA10mm23cm{i,a}(:,3) <=17; %indexing the pressurizing part
            BPA10mm23cm{i,a}(idx,8) = 1 %pressurizing = #1 on column 8, depressurizing = 0;
            BPA10mm23cm{i,a}(:,9) = lo;
            BPA10mm23cm{i,a}(:,10)= l620;
            BPA10mm23cm{i,a}(:,11)= li(a);
            BPA10mm23cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA10mm23cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_23cm; %relative strain
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

%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm23cm(:,8)==1);
id_DP = (AllBPA10mm23cm(:,8)==0);
AllBPA10mm23cm_P = AllBPA10mm23cm(id_P,1:13);
AllBPA10mm23cm_DP = AllBPA10mm23cm(id_DP,1:13);
figure
subplot 121
plot(AllBPA10mm23cm(id_P,3),AllBPA10mm23cm(id_P,1),'bo');
subplot 122
plot(AllBPA10mm23cm(id_DP,3),AllBPA10mm23cm(id_DP,1),'ro');
title('10mm23cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on

%% 10mm 27cm data for all lengths and kinks
Kinks_10mm27cm = {'27cm_Unkinked_Test', '27cm_Kinked7mm_Test','27cm_Kinked15mm_Test','27cm_Kinked31mm_Test'};
    vals_27cm= [0,7,15,31];
    lo = 25.7;
    l620 = 21.8;
    li = [25.7,25,24.2,22.6];
    for a = 1:length(Kinks_10mm27cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm27cm{i,a} = csvread(['10mm_',Kinks_10mm27cm{a},test,'.csv'])
            BPA10mm27cm{i,a}(:,4) = ones(length(BPA10mm27cm{i}),1)*10;  %col 4 = diameter
            BPA10mm27cm{i,a}(:,5) = 27;
            BPA10mm27cm{i,a}(:,6) = ones(length(BPA10mm27cm{i}),1)*vals_27cm(a); %col5 = kinks
            BPA10mm27cm{i,a}(:,7) = ones(length(BPA10mm27cm{i}),1)*i%col6 = Test#
            idx = BPA10mm27cm{i,a}(:,3) <=17; %indexing the pressurizing part
            BPA10mm27cm{i,a}(idx,8) = 1 %pressurizing = #1 on column 8, depressurizing = 0;
            BPA10mm27cm{i,a}(:,9) = lo;
            BPA10mm27cm{i,a}(:,10)= l620;
            BPA10mm27cm{i,a}(:,11)= li(a);
            BPA10mm27cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA10mm27cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_27cm; %relative strain
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

%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm27cm(:,8)==1);
id_DP = (AllBPA10mm27cm(:,8)==0);
AllBPA10mm27cm_P = AllBPA10mm27cm(id_P,1:13);
AllBPA10mm27cm_DP = AllBPA10mm27cm(id_DP,1:13);
figure
subplot 121
plot(AllBPA10mm27cm(id_P,3),AllBPA10mm27cm(id_P,1),'bo');
subplot 122
plot(AllBPA10mm27cm(id_DP,3),AllBPA10mm27cm(id_DP,1),'ro');
title('10mm27cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on

%% 10mm29cm 
Kinks_10mm29cm = {'29cm_Unkinked_Test', '29cm_Kinked17mm_Test','29cm_Kinked28mm_Test','29cm_Kinked41mm_Test'};
    vals_29cm=[0,17,28,41];
    lo = 28.1;
    l620 = 23.5;
    li = [28.1,26.4,25.3,24]

    for a = 1:length(Kinks_10mm29cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm29cm{i,a} = csvread(['10mm_',Kinks_10mm29cm{a},test,'.csv'])
            BPA10mm29cm{i,a}(:,4) = ones(length(BPA10mm29cm{i}),1)*10;  %col 4 = diameter
            BPA10mm29cm{i,a}(:,5) =29;
            BPA10mm29cm{i,a}(:,6) = ones(length(BPA10mm29cm{i}),1)*vals_29cm(a); %col5 = kinks
            BPA10mm29cm{i,a}(:,7) = ones(length(BPA10mm29cm{i}),1)*i%col6 = Test#
            idx = BPA10mm29cm{i,a}(:,3) <=17; %indexing the pressurizing part
            BPA10mm29cm{i,a}(idx,8) = 1 %pressurizing = #1 on column 8, depressurizing = 0;
            BPA10mm29cm{i,a}(:,9) = lo;
            BPA10mm29cm{i,a}(:,10)= l620;
            BPA10mm29cm{i,a}(:,11)= li(a);
            BPA10mm29cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA10mm29cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_29cm; %relative strain
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

%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm29cm(:,8)==1);
id_DP = (AllBPA10mm29cm(:,8)==0);
AllBPA10mm29cm_P = AllBPA10mm29cm(id_P,1:13);
AllBPA10mm29cm_DP = AllBPA10mm29cm(id_DP,1:13);
figure
subplot 121
plot(AllBPA10mm29cm(id_P,3),AllBPA10mm29cm(id_P,1),'bo');
subplot 122
plot(AllBPA10mm29cm(id_DP,3),AllBPA10mm29cm(id_DP,1),'ro');
title('10mm29cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on


%% 10mm30cm 
Kinks_10mm30cm = {'30cm_Unkinked_Test','30cm_Kinked12mm_Test','30cm_Kinked22mm_Test','30cm_Kinked33mm_Test'}; 
    vals_30cm=[0,12,22,33];
    lo = 28.1;
    l620 = 24;
    li = [28.1,26.9,25.9,24.8]

    for a = 1:length(Kinks_10mm30cm)
        for i = 1:10
            test = num2str(i);
            BPA10mm30cm{i,a} = csvread(['10mm_',Kinks_10mm30cm{a},test,'.csv'])
            BPA10mm30cm{i,a}(:,4) = ones(length(BPA10mm30cm{i}),1)*10;  %col 4 = diameter
            BPA10mm30cm{i,a}(:,5) =30;
            BPA10mm30cm{i,a}(:,6) = ones(length(BPA10mm30cm{i}),1)*vals_30cm(a); %col5 = kinks
            BPA10mm30cm{i,a}(:,7) = ones(length(BPA10mm30cm{i}),1)*i%col6 = Test#
            idx = BPA10mm30cm{i,a}(:,3) <=17; %indexing the pressurizing part
            BPA10mm30cm{i,a}(idx,8) = 1 %pressurizing = #1 on column 8, depressurizing = 0;
            BPA10mm30cm{i,a}(:,9) = lo;
            BPA10mm30cm{i,a}(:,10)= l620;
            BPA10mm30cm{i,a}(:,11)= li(a);
            BPA10mm30cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA10mm30cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_30cm; %relative strain
        end
    end


% Combine all 10cm 30cm data into one array
AllBPA10mm30cm =BPA10mm30cm{1};
for a =1:length(Kinks_10mm30cm)
    for i=2:10
        CurrentData= BPA10mm30cm{i,a};
        RealData= CurrentData(CurrentData(:,1)>15,:);
        AllBPA10mm30cm=vertcat(AllBPA10mm30cm,RealData);
    end
end
%Separating the pressurizing and depressurizing data
id_P = (AllBPA10mm30cm(:,8)==1);
id_DP = (AllBPA10mm30cm(:,8)==0);
AllBPA10mm30cm_P = AllBPA10mm30cm(id_P,1:13);
AllBPA10mm30cm_DP = AllBPA10mm30cm(id_DP,1:13);
figure
subplot 121
plot(AllBPA10mm30cm(id_P,3),AllBPA10mm30cm(id_P,1),'bo');
subplot 122
plot(AllBPA10mm30cm(id_DP,3),AllBPA10mm30cm(id_DP,1),'ro');
title('10mm30cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on

%% Combine all 10mm data into a single array

AllBPA10mm = vertcat(AllBPA10mm13cm,AllBPA10mm23cm,AllBPA10mm27cm,AllBPA10mm29cm,AllBPA10mm30cm);
AllBPA10mm_P = vertcat(AllBPA10mm13cm_P,AllBPA10mm23cm_P,AllBPA10mm27cm_P,AllBPA10mm29cm_P,AllBPA10mm30cm_P);
AllBPA10mm_DP = vertcat(AllBPA10mm13cm_DP,AllBPA10mm23cm_DP,AllBPA10mm27cm_DP,AllBPA10mm29cm_DP,AllBPA10mm30cm_DP);


