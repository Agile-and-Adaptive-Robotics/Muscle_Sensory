%% 20mm 3D plots
clc;

%Calculating strains and relative strains (20mm) 
    maxstrain_10cm = (9.8-7.6)/9.8;
    maxstrain_12cm = (12-9.1)/12;
    maxstrain_23cm = (22.5-17)/22.5;
    maxstrain_30cm = (27.4-20.7)/27.4;
    maxstrain_40cm = (39.8-29.9)/39.8;
%Strain calculation 20mm: (10cm,12cm,23cm,30cm,40cm)
    strain_20mm10cm = (AllBPA20mm10cm(:,9) - AllBPA20mm10cm(:,11))./AllBPA20mm10cm(:,9);
    strain_20mm12cm = (AllBPA20mm12cm(:,9) - AllBPA20mm12cm(:,11))./AllBPA20mm12cm(:,9);
    strain_20mm23cm = (AllBPA20mm23cm(:,9) - AllBPA20mm23cm(:,11))./AllBPA20mm23cm(:,9);
    strain_20mm30cm = (AllBPA20mm30cm(:,9) - AllBPA20mm30cm(:,11))./AllBPA20mm30cm(:,9);
    strain_20mm40cm = (AllBPA20mm40cm(:,9) - AllBPA20mm40cm(:,11))./AllBPA20mm40cm(:,9);
    relative_strain_20mm10cm = strain_20mm10cm./maxstrain_10cm;
    relative_strain_20mm12cm = strain_20mm12cm./maxstrain_12cm;
    relative_strain_20mm23cm = strain_20mm23cm./maxstrain_23cm;
    relative_strain_20mm30cm = strain_20mm30cm./maxstrain_30cm;
    relative_strain_20mm40cm = strain_20mm40cm./maxstrain_40cm;
    
%% plot all separately to see the differences (20mm all lengths and
%%kinks,all tests) 
figure
plot3(AllBPA20mm10cm(:,2),relative_strain_20mm10cm,AllBPA20mm10cm(:,1),'.');
hold on
plot3(AllBPA20mm12cm(:,2),relative_strain_20mm12cm,AllBPA20mm12cm(:,1),'.');
plot3(AllBPA20mm23cm(:,2),relative_strain_20mm23cm,AllBPA20mm23cm(:,1),'.');
plot3(AllBPA20mm30cm(:,2),relative_strain_20mm30cm,AllBPA20mm30cm(:,1),'.');
plot3(AllBPA20mm40cm(:,2),relative_strain_20mm40cm,AllBPA20mm40cm(:,1),'.');
xlabel('pressure (kPa)')
zlabel('Force(N)')
zlim ([0 1200])
ylabel('Relative Strain')
title('20mm: Force-pressure-normalized strain relationship')
legend('10cm','12cm','23cm','30cm','40cm');
grid on
hold off

%% Plot P and DP separately
figure
subplot 121
plot3(AllBPA20mm10cm_P(:,2),AllBPA20mm10cm_P(:,13),AllBPA20mm10cm_P(:,1),'.');
hold on
plot3(AllBPA20mm12cm_P(:,2),AllBPA20mm12cm_P(:,13),AllBPA20mm12cm_P(:,1),'.');
plot3(AllBPA20mm23cm_P(:,2),AllBPA20mm23cm_P(:,13),AllBPA20mm23cm_P(:,1),'.');
plot3(AllBPA20mm30cm_P(:,2),AllBPA20mm30cm_P(:,13),AllBPA20mm30cm_P(:,1),'.');
plot3(AllBPA20mm40cm_P(:,2),AllBPA20mm40cm_P(:,13),AllBPA20mm40cm_P(:,1),'.');
xlabel('pressure (kPa)')
zlabel('Force(N)')
ylabel('Relative Strain')
title('20mm: (P) Force-pressure-normalized strain relationship')
legend('10cm','12cm','23cm','30cm','40cm');
grid on
hold off

subplot 122
plot3(AllBPA20mm10cm_DP(:,2),AllBPA20mm10cm_DP(:,13),AllBPA20mm10cm_DP(:,1),'.');
hold on
plot3(AllBPA20mm12cm_DP(:,2),AllBPA20mm12cm_DP(:,13),AllBPA20mm12cm_DP(:,1),'.');
plot3(AllBPA20mm23cm_DP(:,2),AllBPA20mm23cm_DP(:,13),AllBPA20mm23cm_DP(:,1),'.');
plot3(AllBPA20mm30cm_DP(:,2),AllBPA20mm30cm_DP(:,13),AllBPA20mm30cm_DP(:,1),'.');
plot3(AllBPA20mm40cm_DP(:,2),AllBPA20mm40cm_DP(:,13),AllBPA20mm40cm_DP(:,1),'.');
xlabel('pressure (kPa)')
zlabel('Force(N)')
ylabel('Relative Strain')
title('20mm: (DP) Force-pressure-normalized strain relationship')
legend('10cm','12cm','23cm','30cm','40cm');
grid on
hold off
