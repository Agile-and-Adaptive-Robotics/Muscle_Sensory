% BPA parameters 
% 10mm

lo = {12,22,26,28.1}; %resting lengths for 10mm BPA
li_12 = {12,11.6,11.2,10.8}; %initial kink lengths for 10mm 12cm
li_22 = {21.9,20.5,18.9};
li_26 ={25.7,25,24.2,22.6};
li_28 = {28.1,26.9,25.9,24.8};

%% checking the separated data
figure
plot(AllBPA10mm13cm_P(:,3),AllBPA10mm13cm_P(:,1),'.');
figure
plot(AllBPA10mm13cm_DP(:,3),AllBPA10mm13cm_DP(:,1),'.');

