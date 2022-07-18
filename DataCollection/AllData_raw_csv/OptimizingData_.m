%% Optimizing Data - Curve fitting via optimization
% BPA Parameters
    lo = 12;
    li = 12;
    l620 = 10;
    diameter = 10;
    lengths = 29;
    testnumber = 3;
    %state = 'P'; %P= pressurizig, DP = depressurizing

%assigning data: P,F,t   k = sprintf('10mm_%s%s.csv',Kinks_10mm13cm{a},test)
    %Pressurizing
        data_P = eval(sprintf('AllBPA%dmm%dcm_P',diameter,lengths));
        data_force_P = data_P(:,1);
        data_pressure_P = data_P(:,2);
        data_time_P = data_P(:,3);
        data_test_P = data_P(:,7);
        data_strain_P = data_P(:,12);
        data_relativestrain_P = data_P(:,13);
    %Depressurizing
        data_DP = eval(sprintf('AllBPA%dmm%dcm_DP',diameter,lengths));
        data_force_DP = data_DP(:,1);
        data_pressure_DP = data_DP(:,2);
        data_time_DP = data_DP(:,3);
        data_test_P = data_DP(:,7);
        data_strain_DP = data_DP(:,12);
        data_relativestrain_DP = data_DP(:,13);
 %plot to check data
 figure
 subplot 121
 plot(data_pressure_P,data_force_P,'b.'); %data = AllBPA10mm30cm(AllBPA10mm30cm(:,5)==bpalength& AllBPA10mm30cm(:,6)==b&AllBPA10mm30cm(:,7)==i,:)
 title('Pressurizing');
 xlabel('Pressure(kPa)');
 ylabel('Force(N)');
 grid on
 
 subplot 122
 plot(data_pressure_DP,data_force_DP,'r.')
 title('Depressurizing')
 xlabel('Pressure(kPa)')
 ylabel('Force(N)')
 grid on
 
 
% COMMENT: need to separate by test number too. 
