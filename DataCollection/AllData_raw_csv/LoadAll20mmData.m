%% Diameter: 20mm
diameter  = {'20'};
lengths = {'10','12','23','30','40'};

%Calculating strains and relative strains (20mm) 
    maxstrain_10cm = (9.8-7.6)/9.8;
    maxstrain_12cm = (12-9.1)/12;
    maxstrain_23cm = (22.5-17)/22.5;
    maxstrain_30cm = (27.4-20.7)/27.4;
    maxstrain_40cm = (39.8-29.9)/39.8;
    high_pressure = 620;
    low_force = 20;

%% 20mm 10cm 
Kinks_20mm10cm = {'10cm_Unkinked_Test','10cm_Kinked13mm_Test','10cm_Kinked20mm_Test'};
    vals_10cm = [0,13,20];
    lo = 9.8;
    l620 = 7.6;
    li = [9.8,8.5,7.8];
    
    for a = 1:length(Kinks_20mm10cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm10cm{i,a} = csvread(['20mm_',Kinks_20mm10cm{a},test,'Data.csv']);
            BPA20mm10cm{i,a}(:,4) = ones(length(BPA20mm10cm{i}),1)*20;  %col 4 = diameter
            BPA20mm10cm{i,a}(:,5) = 10;
            BPA20mm10cm{i,a}(:,6) = ones(length(BPA20mm10cm{i}),1)*vals_10cm(a); %col5 = kinks
            BPA20mm10cm{i,a}(:,7) = ones(length(BPA20mm10cm{i}),1)*i;%col6 = Test#
            idx = BPA20mm10cm{i,a}(:,3) <=20; %indexing the pressurizing part
            BPA20mm10cm{i,a}(idx,8) = 1; %pressurizing = #1 on column 8, depressurizing = 0;
            BPA20mm10cm{i,a}(:,9) = lo;
            BPA20mm10cm{i,a}(:,10) = l620;
            BPA20mm10cm{i,a}(:,11) = li(a);
            BPA20mm10cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA20mm10cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_10cm; %relative strain
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm10cm = BPA20mm10cm{1};
for a = 1:length(Kinks_20mm10cm)
    for i =2:10
        CurrentData = BPA20mm10cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %remove data points with force below 15N
        AllBPA20mm10cm = vertcat(AllBPA20mm10cm,RealData);
    end
end

%Separating the pressurizing and depressurizing data
id_P = (AllBPA20mm10cm(:,8)==1);
id_DP = (AllBPA20mm10cm(:,8)==0);

AllBPA20mm10cm_P = AllBPA20mm10cm(id_P,1:13);
AllBPA20mm10cm_DP = AllBPA20mm10cm(id_DP,1:13);

figure
subplot 121
grid on
plot(AllBPA20mm10cm(id_P,3),AllBPA20mm10cm(id_P,1),'bo');
subplot 122
plot(AllBPA20mm10cm(id_DP,3),AllBPA20mm10cm(id_DP,1),'ro');
title('20mm10cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on

%% 20mm12cm
Kinks_20mm12cm = {'12cm_Unkinked_Test','12cm_Kinked10mm_Test','12cm_Kinked20mm_Test'};
    vals_12cm = [0,10,20];
    lo = 12;
    l620 = 9.1;
    li = [12,11,10];
    
    for a = 1:length(Kinks_20mm12cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm12cm{i,a} = csvread(['20mm_',Kinks_20mm12cm{a},test,'.csv']);
            BPA20mm12cm{i,a}(:,4) = ones(length(BPA20mm12cm{i}),1)*20;  %col 4 = diameter
            BPA20mm12cm{i,a}(:,5) = 12;                                 %col 5 = length 
            BPA20mm12cm{i,a}(:,6) = ones(length(BPA20mm12cm{i}),1)*vals_12cm(a); %col6 = kinks
            BPA20mm12cm{i,a}(:,7) = ones(length(BPA20mm12cm{i}),1)*i;%col7 = Test#
            idx = BPA20mm12cm{i,a}(:,3) <=23; %indexing the pressurizing part
            BPA20mm12cm{i,a}(idx,8) = 1; %pressurizing = #1 on column 8, depressurizing = 0;
            BPA20mm12cm{i,a}(:,9) = lo;
            BPA20mm12cm{i,a}(:,10) = l620;
            BPA20mm12cm{i,a}(:,11) = li(a);
            BPA20mm12cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA20mm12cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_12cm; %relative strain
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm12cm = BPA20mm12cm{1};
for a = 1:length(Kinks_20mm12cm)
    for i =2:10
        CurrentData = BPA20mm12cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %remove data points with force below 15N
        AllBPA20mm12cm = vertcat(AllBPA20mm12cm,RealData);
    end
end

%Separating the pressurizing and depressurizing data
id_P = (AllBPA20mm12cm(:,8)==1);
id_DP = (AllBPA20mm12cm(:,8)==0);
AllBPA20mm12cm_P = AllBPA20mm12cm(id_P,1:13);
AllBPA20mm12cm_DP = AllBPA20mm12cm(id_DP,1:13);

figure
subplot 121
plot(AllBPA20mm12cm(id_P,3),AllBPA20mm12cm(id_P,1),'bo');
subplot 122
plot(AllBPA20mm12cm(id_DP,3),AllBPA20mm12cm(id_DP,1),'ro');
title('20mm12cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
grid on



%% 20mm 23cm
Kinks_20mm23cm = {'23cm_Unkinked_Test','23cm_Kinked9mm_Test','23cm_Kinked19mm_Test'};
    vals_23cm = [0,9,19];
    lo = 22.5;
    l620 = 17;
    li = [22.5,21.9,20.9];
    
    for a = 1:length(Kinks_20mm23cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm23cm{i,a} = csvread(['20mm_',Kinks_20mm23cm{a},test,'.csv']);
            BPA20mm23cm{i,a}(:,4) = ones(length(BPA20mm23cm{i}),1)*20;  %col 4 = diameter
            BPA20mm23cm{i,a}(:,5) = 23;                                 %col 5 = length 
            BPA20mm23cm{i,a}(:,6) = ones(length(BPA20mm23cm{i}),1)*vals_23cm(a); %col6 = kinks
            BPA20mm23cm{i,a}(:,7) = ones(length(BPA20mm23cm{i}),1)*i;%col7 = Test#
            idx = BPA20mm23cm{i,a}(:,3) <=25; %indexing the pressurizing part
            BPA20mm23cm{i,a}(idx,8) = 1 ;%pressurizing = #1 on column 8, depressurizing = 0;
            BPA20mm23cm{i,a}(:,9) = lo;
            BPA20mm23cm{i,a}(:,10) = l620;
            BPA20mm23cm{i,a}(:,11) = li(a);
            BPA20mm23cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA20mm23cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_23cm; %relative strain
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm23cm = BPA20mm23cm{1};
for a = 1:length(Kinks_20mm23cm)
    for i =2:10
        CurrentData = BPA20mm23cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %remove data points with force below 15N
        AllBPA20mm23cm = vertcat(AllBPA20mm23cm,RealData);
    end
end

%Separating the pressurizing and depressurizing data
id_P = (AllBPA20mm23cm(:,8)==1);
id_DP = (AllBPA20mm23cm(:,8)==0);
AllBPA20mm23cm_P = AllBPA20mm23cm(id_P,1:13);
AllBPA20mm23cm_DP = AllBPA20mm23cm(id_DP,1:13);

figure
subplot 121
plot(AllBPA20mm23cm(id_P,3),AllBPA20mm23cm(id_P,1),'bo');
subplot 122
plot(AllBPA20mm23cm(id_DP,3),AllBPA20mm23cm(id_DP,1),'ro');
title('20mm23cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')

%% 20mm 30cm
Kinks_20mm30cm = {'30cm_Unkinked_Test','30cm_Kinked14mm_Test','30cm_Kinked23mm_Test','30cm_Kinked34mm_Test'};
    vals_30cm = [0,14,23,34];
    lo = 27.4;
    l620 = 20.7;
    li = [27.4,26.1,25.2,24.1];
    
    for a = 1:length(Kinks_20mm30cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm30cm{i,a} = csvread(['20mm_',Kinks_20mm30cm{a},test,'.csv']);
            BPA20mm30cm{i,a}(:,4) = ones(length(BPA20mm30cm{i}),1)*20;  %col 4 = diameter
            BPA20mm30cm{i,a}(:,5) = 30;                                 %col 5 = length 
            BPA20mm30cm{i,a}(:,6) = ones(length(BPA20mm30cm{i}),1)*vals_30cm(a); %col6 = kinks
            BPA20mm30cm{i,a}(:,7) = ones(length(BPA20mm30cm{i}),1)*i;%col7 = Test#
            idx = BPA20mm30cm{i,a}(:,3) <=25; %indexing the pressurizing part
            BPA20mm30cm{i,a}(idx,8) = 1; %pressurizing = #1 on column 8, depressurizing = 0;
            BPA20mm30cm{i,a}(:,9) = lo;
            BPA20mm30cm{i,a}(:,10) = l620;
            BPA20mm30cm{i,a}(:,11) = li(a);
            BPA20mm30cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA20mm30cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_30cm; %relative strain
        end
    end
    
%Combine all 20mm30cm data into a single array
AllBPA20mm30cm = BPA20mm30cm{1};
for a = 1:length(Kinks_20mm30cm)
    for i =2:10
        CurrentData = BPA20mm30cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %remove data points with force below 15N
        AllBPA20mm30cm = vertcat(AllBPA20mm30cm,RealData);
    end
end

%Separating the pressurizing and depressurizing data

id_P = (AllBPA20mm30cm(:,8)==1);
id_DP = (AllBPA20mm30cm(:,8)==0);
AllBPA20mm30cm_P = AllBPA20mm30cm(id_P,1:13);
AllBPA20mm30cm_DP =AllBPA20mm30cm(id_DP,1:13);

figure
subplot 121
plot(AllBPA20mm30cm(id_P,3),AllBPA20mm30cm(id_P,1),'bo');
subplot 122
plot(AllBPA20mm30cm(id_DP,3),AllBPA20mm30cm(id_DP,1),'ro');
title('20mm30cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')

%% 20mm 40cm 
Kinks_20mm40cm = {'40cm_Unkinked_Test','40cm_Kinked35mm_Test','40cm_Kinked46mm_Test','40cm_Kinked69mm_Test'};
    vals_40cm = [0,35,46,69];
    lo = 39.8;
    l620 = 29.9;
    li = [39.8,36.2,35.1,32.8] ;
    
    
    for a = 1:length(Kinks_20mm40cm)
        for i = 1:10
            test = num2str(i);
            BPA20mm40cm{i,a} = csvread(['20mm_',Kinks_20mm40cm{a},test,'Data.csv']);
            BPA20mm40cm{i,a}(:,4) = ones(length(BPA20mm40cm{i}),1)*20;  %col 4 = diameter
            BPA20mm40cm{i,a}(:,5) = 40;                                 %col 5 = length 
            BPA20mm40cm{i,a}(:,6) = ones(length(BPA20mm40cm{i}),1)*vals_40cm(a); %col6 = kinks
            BPA20mm40cm{i,a}(:,7) = ones(length(BPA20mm40cm{i}),1)*i;   %col7 = Test#
            idx = BPA20mm40cm{i,a}(:,3) <=29; %indexing the pressurizing part
            BPA20mm40cm{i,a}(idx,8) = 1 ;%pressurizing = #1 on column 8, depressurizing = 0;
            BPA20mm40cm{i,a}(:,9) = lo;
            BPA20mm40cm{i,a}(:,10) = l620;
            BPA20mm40cm{i,a}(:,11) = li(a);
            BPA20mm40cm{i,a}(:,12)= (lo - li(a))./lo; %strain
            BPA20mm40cm{i,a}(:,13)= ((lo - li(a))./lo)./maxstrain_40cm; %relative strain
        end
    end
    
%Combine all 10mm10cm data into a single array
AllBPA20mm40cm = BPA20mm40cm{1};
for a = 1:length(Kinks_20mm40cm)
    for i =2:10
        CurrentData = BPA20mm40cm{i,a};
        RealData = CurrentData(CurrentData(:,1)>low_force&CurrentData(:,2)<high_pressure,:); %remove data points with force below 15N
        AllBPA20mm40cm = vertcat(AllBPA20mm40cm,RealData);
    end
end
%Separating the pressurizing and depressurizing data
id_P = (AllBPA20mm40cm(:,8)==1);
id_DP = (AllBPA20mm40cm(:,8)==0);
AllBPA20mm40cm_P = AllBPA20mm40cm(id_P,1:13);
AllBPA20mm40cm_DP = AllBPA20mm40cm(id_DP,1:13);


figure
subplot 121
plot(AllBPA20mm40cm(id_P,3),AllBPA20mm40cm(id_P,1),'bo');
subplot 122 
plot(AllBPA20mm40cm(id_DP,3),AllBPA20mm40cm(id_DP,1),'ro');

title('20mm40cm all kinks')
xlabel('Time(s)')
ylabel('Force(N)')
%% Combine all 20mm data into a single array 

AllBPA20mm = vertcat(AllBPA20mm10cm,AllBPA20mm12cm,AllBPA20mm23cm,AllBPA20mm30cm,AllBPA20mm40cm);
AllBPA20mm_P = vertcat(AllBPA20mm10cm_P,AllBPA20mm12cm_P,AllBPA20mm23cm_P,AllBPA20mm30cm_P,AllBPA20mm40cm_P);
AllBPA20mm_DP = vertcat(AllBPA20mm10cm_DP,AllBPA20mm12cm_DP,AllBPA20mm23cm_DP,AllBPA20mm30cm_DP,AllBPA20mm40cm_DP);

