figure %20mm 30cm
    sgtitle('20mm 30cm BPA Static Pressure and Force')
    subplot 221
    yyaxis left
    plot(Data_20mm_30cm_Unkinked_Test9(:,3),Data_20mm_30cm_Unkinked_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_30cm_Unkinked_Test9(:,3),Data_20mm_30cm_Unkinked_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')

    subplot 222
    yyaxis left
    plot(Data_20mm_30cm_Kinked14mm_Test9(:,3),Data_20mm_30cm_Kinked14mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_30cm_Kinked14mm_Test9(:,3),Data_20mm_30cm_Kinked14mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('14mm Kinked Force and Pressure vs Time')

    subplot 223
    yyaxis left
    plot(Data_20mm_30cm_Kinked23mm_Test9(:,3),Data_20mm_30cm_Kinked23mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_30cm_Kinked23mm_Test9(:,3),Data_20mm_30cm_Kinked23mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('23mm Kinked Force and Pressure vs Time')

    subplot 224
    yyaxis left
    plot(Data_20mm_23cm_Kinked34mm_Test9(:,3),Data_20mm_30cm_Kinked34mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_30cm_Kinked34mm_Test9(:,3),Data_20mm_30cm_Kinked34mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('34mm Kinked Force and Pressure vs Time')