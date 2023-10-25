%% 20mm Data (load mat file to csv) and convert data to Pressure and Force. (Test9) 
% 20mm 12cm Unkinked - Loading data
Data_20mm_12cm_Unkinked_Test9 = csvread('20mm_12cm_Unkinked_Test9.csv');
    Force_20mm_12cm_Unkinked_Test9 = ((Data_20mm_12cm_Unkinked_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_12cm_Unkinked_Test9 = Data_20mm_12cm_Unkinked_Test9(:,2);
    Time_20mm_12cm_Unkinked_Test9 = Data_20mm_12cm_Unkinked_Test9(:,3);
        % Removing low force data
        Data_20mm_12cm_Unkinked_Test9 = [Force_20mm_12cm_Unkinked_Test9,Pressure_20mm_12cm_Unkinked_Test9,Time_20mm_12cm_Unkinked_Test9];
        Data_20mm_12cm_Unkinked_Test9(Data_20mm_12cm_Unkinked_Test9(:,1)<10,:)=[];    
    %10mm Kinked
    Data_20mm_12cm_Kinked10mm_Test9 = csvread('20mm_12cm_Kinked10mm_Test9.csv');
    Force_20mm_12cm_Kinked10mm_Test9 = ((Data_20mm_12cm_Kinked10mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_12cm_Kinked10mm_Test9 = Data_20mm_12cm_Kinked10mm_Test9(:,2);
    Time_20mm_12cm_Kinked10mm_Test9 = Data_20mm_12cm_Kinked10mm_Test9(:,3); 
     % Removing low force data
        Data_20mm_12cm_Kinked10mm_Test9 = [Force_20mm_12cm_Kinked10mm_Test9,Pressure_20mm_12cm_Kinked10mm_Test9,Time_20mm_12cm_Kinked10mm_Test9];
        Data_20mm_12cm_Kinked10mm_Test9(Data_20mm_12cm_Kinked10mm_Test9(:,1)<10,:)=[]; 
    %20mm Kinked
    Data_20mm_12cm_Kinked20mm_Test9 = csvread('20mm_12cm_Kinked20mm_Test9.csv');
    Force_20mm_12cm_Kinked20mm_Test9 = ((Data_20mm_12cm_Kinked20mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_12cm_Kinked20mm_Test9 = Data_20mm_12cm_Kinked20mm_Test9(:,2);
    Time_20mm_12cm_Kinked20mm_Test9 = Data_20mm_12cm_Kinked20mm_Test9(:,3);
        % Removing low force data
        Data_20mm_12cm_Kinked20mm_Test9 = [Force_20mm_12cm_Kinked20mm_Test9,Pressure_20mm_12cm_Kinked20mm_Test9,Time_20mm_12cm_Kinked20mm_Test9];
        Data_20mm_12cm_Kinked20mm_Test9(Data_20mm_12cm_Kinked20mm_Test9(:,1)<10,:)=[]; 

% 20mm 23cm Unkinked - Loading data
Data_20mm_23cm_Unkinked_Test9 = csvread('20mm_23cm_Unkinked_Test9.csv');
    Force_20mm_23cm_Unkinked_Test9 = ((Data_20mm_23cm_Unkinked_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_23cm_Unkinked_Test9 = Data_20mm_23cm_Unkinked_Test9(:,2);
    Time_20mm_23cm_Unkinked_Test9 = Data_20mm_23cm_Unkinked_Test9(:,3);
     % Removing low force data
        Data_20mm_23cm_Unkinked_Test9 = [Force_20mm_23cm_Unkinked_Test9,Pressure_20mm_23cm_Unkinked_Test9,Time_20mm_23cm_Unkinked_Test9];
        Data_20mm_23cm_Unkinked_Test9(Data_20mm_23cm_Unkinked_Test9(:,1)<10,:)=[];    
    %Kinked 9mm
    Data_20mm_23cm_Kinked9mm_Test9 = csvread('20mm_23cm_Kinked9mm_Test9.csv');
    Force_20mm_23cm_Kinked9mm_Test9 = ((Data_20mm_23cm_Kinked9mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_23cm_Kinked9mm_Test9 = Data_20mm_23cm_Kinked9mm_Test9(:,2);
    Time_20mm_23cm_Kinked9mm_Test9 = Data_20mm_23cm_Kinked9mm_Test9(:,3);
  	 % Removing low force data
     Data_20mm_23cm_Kinked9mm_Test9 = [Force_20mm_23cm_Kinked9mm_Test9,Pressure_20mm_23cm_Kinked9mm_Test9,Time_20mm_23cm_Kinked9mm_Test9];
     Data_20mm_23cm_Kinked9mm_Test9(Data_20mm_23cm_Kinked9mm_Test9(:,1)<10,:)=[];    
    %Kinked 19mm
    Data_20mm_23cm_Kinked19mm_Test9 = csvread('20mm_23cm_Kinked19mm2_Test9.csv');
    Force_20mm_23cm_Kinked19mm_Test9 = ((Data_20mm_23cm_Kinked19mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_23cm_Kinked19mm_Test9 = Data_20mm_23cm_Kinked19mm_Test9(:,2);
    Time_20mm_23cm_Kinked19mm_Test9 = Data_20mm_23cm_Kinked19mm_Test9(:,3);
  	 % Removing low force data
     Data_20mm_23cm_Kinked19mm_Test9 = [Force_20mm_23cm_Kinked19mm_Test9,Pressure_20mm_23cm_Kinked19mm_Test9,Time_20mm_23cm_Kinked19mm_Test9];
     Data_20mm_23cm_Kinked19mm_Test9(Data_20mm_23cm_Kinked19mm_Test9(:,1)<10,:)=[]; 
% 20mm 30cm Unkinked - Loading data
Data_20mm_30cm_Unkinked_Test9 = csvread('20mm_30cm_Unkinked_Test9.csv');
    Force_20mm_30cm_Unkinked_Test9 = ((Data_20mm_30cm_Unkinked_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_30cm_Unkinked_Test9 = Data_20mm_30cm_Unkinked_Test9(:,2);
    Time_20mm_30cm_Unkinked_Test9 = Data_20mm_30cm_Unkinked_Test9(:,3);
  	     % Removing low force data
        Data_20mm_30cm_Unkinked_Test9 = [Force_20mm_30cm_Unkinked_Test9,Pressure_20mm_30cm_Unkinked_Test9,Time_20mm_30cm_Unkinked_Test9];
         Data_20mm_30cm_Unkinked_Test9(Data_20mm_30cm_Unkinked_Test9(:,1)<10,:)=[];  
    %14mm Kink
    Data_20mm_30cm_Kinked14mm_Test9 = csvread('20mm_30cm_Kinked14mm_Test9.csv');
    Force_20mm_30cm_Kinked14mm_Test9 = ((Data_20mm_30cm_Kinked14mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_30cm_Kinked14mm_Test9 = Data_20mm_30cm_Kinked14mm_Test9(:,2);
    Time_20mm_30cm_Kinked14mm_Test9 = Data_20mm_30cm_Kinked14mm_Test9(:,3);
  	    % Removing low force data
         Data_20mm_30cm_Kinked14mm_Test9 = [Force_20mm_30cm_Kinked14mm_Test9,Pressure_20mm_30cm_Kinked14mm_Test9,Time_20mm_30cm_Kinked14mm_Test9];
         Data_20mm_30cm_Kinked14mm_Test9(Data_20mm_30cm_Kinked14mm_Test9(:,1)<10,:)=[];    
    %23mm Kink
    Data_20mm_30cm_Kinked23mm_Test9 = csvread('20mm_30cm_Kinked23mm_Test9.csv');
    Force_20mm_30cm_Kinked23mm_Test9 = ((Data_20mm_30cm_Kinked23mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_30cm_Kinked23mm_Test9 = Data_20mm_30cm_Kinked23mm_Test9(:,2);
    Time_20mm_30cm_Kinked23mm_Test9 = Data_20mm_30cm_Kinked23mm_Test9(:,3);
  	 % Removing low force data
     Data_20mm_30cm_Kinked23mm_Test9 = [Force_20mm_30cm_Kinked23mm_Test9,Pressure_20mm_30cm_Kinked23mm_Test9,Time_20mm_30cm_Kinked23mm_Test9];
     Data_20mm_30cm_Kinked23mm_Test9(Data_20mm_30cm_Kinked23mm_Test9(:,1)<10,:)=[];   
   %34mm Kinked
   Data_20mm_30cm_Kinked34mm_Test9 = csvread('20mm_30cm_Kinked34mm_Test9.csv');
    Force_20mm_30cm_Kinked34mm_Test9 = ((Data_20mm_30cm_Kinked34mm_Test9(:,1)*0.392)-4.1786)*4.45;
    Pressure_20mm_30cm_Kinked34mm_Test9 = Data_20mm_30cm_Kinked34mm_Test9(:,2);
    Time_20mm_30cm_Kinked34mm_Test9 = Data_20mm_30cm_Kinked34mm_Test9(:,3);
  	 % Removing low force data
     Data_20mm_30cm_Kinked34mm_Test9 = [Force_20mm_30cm_Kinked34mm_Test9,Pressure_20mm_30cm_Kinked34mm_Test9,Time_20mm_30cm_Kinked34mm_Test9];
     Data_20mm_30cm_Kinked34mm_Test9(Data_20mm_30cm_Kinked34mm_Test9(:,1)<10,:)=[];    
%% Check data
figure %20mm 12cm
    sgtitle('20mm 12cm BPA Static Pressure and Force')
    subplot 311
    yyaxis left
    plot(Data_20mm_12cm_Unkinked_Test9(:,3),Data_20mm_12cm_Unkinked_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_12cm_Unkinked_Test9(:,3),Data_20mm_12cm_Unkinked_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    subplot 312
    yyaxis left
    plot(Data_20mm_12cm_Kinked10mm_Test9(:,3),Data_20mm_12cm_Kinked10mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_12cm_Kinked10mm_Test9(:,3),Data_20mm_12cm_Kinked10mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('10mm Kinked Force and Pressure vs Time')
    subplot 313
    yyaxis left
    plot(Data_20mm_12cm_Kinked20mm_Test9(:,3),Data_20mm_12cm_Kinked20mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_12cm_Kinked20mm_Test9(:,3),Data_20mm_12cm_Kinked20mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('20mm Kinked Force and Pressure vs Time')
figure %20mm 23cm
    sgtitle('20mm 23cm BPA Static Pressure and Force')
    subplot 311
    yyaxis left
    plot(Data_20mm_23cm_Unkinked_Test9(:,3),Data_20mm_23cm_Unkinked_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_23cm_Unkinked_Test9(:,3),Data_20mm_23cm_Unkinked_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')

    subplot 312
    yyaxis left
    plot(Data_20mm_23cm_Kinked9mm_Test9(:,3),Data_20mm_23cm_Kinked9mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_23cm_Kinked9mm_Test9(:,3),Data_20mm_23cm_Kinked9mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('9mm Kinked Force and Pressure vs Time')

    subplot 313
    yyaxis left
    plot(Data_20mm_23cm_Kinked19mm_Test9(:,3),Data_20mm_23cm_Kinked19mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_23cm_Kinked19mm_Test9(:,3),Data_20mm_23cm_Kinked19mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('19mm Kinked Force and Pressure vs Time')
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
    plot(Data_20mm_30cm_Kinked34mm_Test9(:,3),Data_20mm_30cm_Kinked34mm_Test9(:,1));
    ylim([-10,1500])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Data_20mm_30cm_Kinked34mm_Test9(:,3),Data_20mm_30cm_Kinked34mm_Test9(:,2));
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('34mm Kinked Force and Pressure vs Time')



%% Plotting Figures - Pressure vs Force

figure
    plot(Data_20mm_12cm_Unkinked_Test9(:,2),Data_20mm_12cm_Unkinked_Test9(:,1));
    hold on
    plot(Data_20mm_12cm_Kinked10mm_Test9(:,2),Data_20mm_12cm_Kinked10mm_Test9(:,1));
    plot(Data_20mm_12cm_Kinked20mm_Test9(:,2),Data_20mm_12cm_Kinked20mm_Test9(:,1));
    hold off
    legend('Unkink','10mm','20mm')
    title('20mm 12cm BPA')
    xlabel('Pressure(kPa')
    ylabel('Force(N)')
 figure
    plot(Data_20mm_23cm_Unkinked_Test9(:,2),Data_20mm_23cm_Unkinked_Test9(:,1));
    hold on
    plot(Data_20mm_23cm_Kinked9mm_Test9(:,2),Data_20mm_23cm_Kinked9mm_Test9(:,1));
    plot(Data_20mm_23cm_Kinked19mm_Test9(:,2),Data_20mm_23cm_Kinked19mm_Test9(:,1));
    hold off
    legend('Unkink','9mm','19mm')
    title('20mm 23cm BPA')
    xlabel('Pressure(kPa')
    ylabel('Force(N)')
figure
    plot(Data_20mm_30cm_Unkinked_Test9(:,2),Data_20mm_30cm_Unkinked_Test9(:,1));
    hold on
    plot(Data_20mm_30cm_Kinked14mm_Test9(:,2),Data_20mm_30cm_Kinked14mm_Test9(:,1));
    plot(Data_20mm_30cm_Kinked23mm_Test9(:,2),Data_20mm_30cm_Kinked23mm_Test9(:,1));
    plot(Data_20mm_30cm_Kinked34mm_Test9(:,2),Data_20mm_30cm_Kinked34mm_Test9(:,1));
    hold off
    legend('Unkink','14mm','23mm','34mm')
    title('20mm 23cm BPA')
    xlabel('Pressure(kPa')
    ylabel('Force(N)')


 