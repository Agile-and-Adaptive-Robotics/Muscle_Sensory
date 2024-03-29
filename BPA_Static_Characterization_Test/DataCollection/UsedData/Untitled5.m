Data_10mm_29cm_Kinked41mm_Test9 = csvread('10mm_29cm_Kinked41mm_Test9.csv');
    Force_10mm_29cm_Kinked41mm_Test9_Wrong = Data_10mm_29cm_Kinked41mm_Test9(:,1); %this is actual pressure A0,going thru force eq)
    Pressure_10mm_29cm_Kinked41mm_Test9_Wrong = Data_10mm_29cm_Kinked41mm_Test9(:,2);
    Force_10mm_29cm_Kinked41mm_Test9_A0 = (Pressure_10mm_29cm_Kinked41mm_Test9_Wrong +18.609)/0.7654; % This is Force A0
    Pressure_10mm_29cm_Kinked41mm_Test9_A0 = ((Force_10mm_29cm_Kinked41mm_Test9_Wrong/4.45)+1.963)/0.1535;% This is pressure A0
    Pressure_10mm_29cm_Kinked41mm_Test9 = (Pressure_10mm_29cm_Kinked41mm_Test9_A0*0.7654) -18.609;
    Force_10mm_29cm_Kinked41mm_Test9 = ((Force_10mm_29cm_Kinked41mm_Test9_A0*0.1535)-1.963)*4.45;
    Time_10mm_29cm_Kinked41mm_Test9 = Data_10mm_29cm_Kinked41mm_Test9(:,3);
    
    
    subplot 224
    yyaxis left
    plot(Time_10mm_29cm_Kinked41mm_Test9,Force_10mm_29cm_Kinked41mm_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_29cm_Kinked41mm_Test9,Pressure_10mm_29cm_Kinked41mm_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Kinked41mm Force and Pressure vs Time')
    hold off    
    
    %%svalues(i,2) = ((str2double(readline(s)))*0.7654) -18.609; %Pressure (kPa)         Aug 2
    %for 10mm: % Jan 5 2022 ((A0)*0.1535-1.963)4.45 N | Aug 2 %*1.6475)-30.882)*4.45; %Force(N)           
    %for 20mm: Jan 10 2022 ((A0)*0.392)-4.1786)*4.45