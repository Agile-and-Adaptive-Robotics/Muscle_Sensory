Data_10mm_13cm_Unkinked_Test9 = csvread('10mm_13cm_Unkinked_Test9.csv');
Data_10mm_13cm_Unkinked_Test9(Data_10mm_13cm_Unkinked_Test9(:,1)<10,:)=[];

% Condition to remove
%%
Force_10mm_13cm_Unkinked_Test9_Wrong = Data_10mm_13cm_Unkinked_Test9(:,1);
    Force_10mm_13cm_Unkinked_Test9_A0=((Force_10mm_13cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test9_Offset = Force_10mm_13cm_Unkinked_Test9_A0 - min(Force_10mm_13cm_Unkinked_Test9_A0);
    Force_10mm_13cm_Unkinked_Test9 = (((Force_10mm_13cm_Unkinked_Test9_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test9 =Data_10mm_13cm_Unkinked_Test9(:,2);
    Time_10mm_13cm_Unkinked_Test9 = Data_10mm_13cm_Unkinked_Test9(:,3);
    
    figure
    sgtitle('10mm 13cm BPA Static Pressure and Force')
    subplot 221
    yyaxis left
    plot(Time_10mm_13cm_Unkinked_Test9,Force_10mm_13cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Unkinked_Test9,Pressure_10mm_13cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off   
