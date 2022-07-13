%% 10mm - 3d plot for selected data with strain calculations (Test 9 only) 
% 10mm all
close all;
% figure
% 
% strain_10mm = 100*(AllBPA10mm(:,9)-AllBPA10mm(:,11))./AllBPA10mm(:,9); %percent
% % maxstrain_10mm = (12-10)/12; %this is wrong! 
% % relative_strain_10mm = strain_10mm./maxstrain_10mm;
% % AllBPA10mm(:,12) = relative_strain_10mm; %percent
% plot3(AllBPA10mm(:,2),relative_strain_10mm,AllBPA10mm(:,1),'.')
% xlabel('pressure (kPa)')
% zlabel('Force(N)')
% ylabel('Strain(%)')

%% Calculating strains and relative strains
%10mm
    maxstrain_13cm = (12-10)/12;
    maxstrain_23cm = (22-18.5)/22;
    maxstrain_27cm = (25.7-21.8)/25.7;
    maxstrain_29cm = (28.1-23.5)/28.1;
    maxstrain_30cm = (28.1-24)/28.1;

%strain calculation (13cm, 23cm, 27cm, 29cm, 30cm)   
%(comment!!: should do at LoadAll10mmData before splitting pressurizing and
%depressurizing!!!!) 
    strain_10mm13cm = (AllBPA10mm13cm(:,9) - AllBPA10mm13cm(:,11))./AllBPA10mm13cm(:,9);
    strain_10mm23cm = (AllBPA10mm23cm(:,9) - AllBPA10mm23cm(:,11))./AllBPA10mm23cm(:,9);
    strain_10mm27cm = (AllBPA10mm27cm(:,9) - AllBPA10mm27cm(:,11))./AllBPA10mm27cm(:,9);
    strain_10mm29cm = (AllBPA10mm29cm(:,9) - AllBPA10mm29cm(:,11))./AllBPA10mm29cm(:,9);
    strain_10mm30cm = (AllBPA10mm30cm(:,9) - AllBPA10mm30cm(:,11))./AllBPA10mm30cm(:,9);
    relative_strain_10mm13cm = strain_10mm13cm./maxstrain_13cm;
    relative_strain_10mm23cm = strain_10mm23cm./maxstrain_23cm;
    relative_strain_10mm27cm = strain_10mm27cm./maxstrain_27cm;
    relative_strain_10mm29cm = strain_10mm29cm./maxstrain_29cm;
    relative_strain_10mm30cm = strain_10mm30cm./maxstrain_30cm;
    

%% Plot all separately to see the differences (10mm all lengths and kinks) 
%10mm 13cm
figure
plot3(AllBPA10mm13cm(:,2),relative_strain_10mm13cm,AllBPA10mm13cm(:,1),'.');
hold on
plot3(AllBPA10mm23cm(:,2),relative_strain_10mm23cm,AllBPA10mm23cm(:,1),'.');
plot3(AllBPA10mm27cm(:,2),relative_strain_10mm27cm,AllBPA10mm27cm(:,1),'.');
plot3(AllBPA10mm29cm(:,2),relative_strain_10mm29cm,AllBPA10mm29cm(:,1),'.');
plot3(AllBPA10mm30cm(:,2),relative_strain_10mm30cm,AllBPA10mm30cm(:,1),'.');
xlabel('pressure (kPa)')
zlabel('Force(N)')
ylabel('Relative Strain')
title('10mm: Force-pressure-normalized strain relationship')
legend('13cm','23cm','27cm','29cm','30cm');
grid on
hold off

