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
    
%% 
Kinks_10mm13cm = {'13cm_Unkinked_Test','13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test'};
lo = 12;
l620 = 10;
li = [12,11.6,11.2,10.8];
vals_13cm= [0,4,8,12]; 
    for a = 1:length(Kinks_10mm13cm)
        for i =1:10
            test = num2str(i);
            BPA10mm13cm{i,a} = csvread(['10mm_',Kinks_10mm13cm{a},test,'.csv'])
            BPA10mm13cm{i,a}(:,4) = ones(length(BPA10mm13cm{i}),1)*10;  %col 4 = diameter
            BPA10mm13cm{i,a}(:,5) = 13;
            BPA10mm13cm{i,a}(:,6) = ones(length(BPA10mm13cm{i}),1)*vals_13cm(a); %col6 = kinks
            BPA10mm13cm{i,a}(:,7) = ones(length(BPA10mm13cm{i}),1)*i%col7 = Test#
            idx = BPA10mm13cm{i,a}(:,3) <27; %indexing the pressurizing part
            idx_DP = BPA10mm13cm{i,a}(:,3) >=27;
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
        %RealData= CurrentData(CurrentData(:,1)>15,:); %need to remove this (CurrentData(:,1)>15,:) to CurrentData(:,1)
        AllBPA10mm13cm=vertcat(AllBPA10mm13cm,CurrentData);
    end
end