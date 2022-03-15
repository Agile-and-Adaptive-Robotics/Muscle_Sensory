%Correcting all 10mm data to produce correct force and pressure output
%(AllData_raw_csv folder) 

% RUN THIS CODE ONLY ONCE. RUNNING IT >1 risks, processing the data too
% many times. 

%DONT RUN THIS CODE AT ALL
%% 10mm 13cm
Kinks_10mm13cm = {'13cm_Unkinked_Test','13cm_Kinked4mm_Test','13cm_Kinked8mm_Test','13cm_Kinked12mm_Test'};
    vals_13cm= [0,4,8,12]; 

    for a = 1:length(Kinks_10mm13cm)
        a
        for i=1:10
            i
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm13cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1);
            Force_A0 = ((Force_wrong/4.45)+30.882)/1.6475;
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            csvwrite(k,Data)
        end
    end

  %% 10mm 23cm: Note: unkinked and kinked data have different correction equations
%Unkinked
Kinks_10mm23cm = {'23cm_Unkinked_Test'}%, '23cm_Kinked14mm_Test','23cm_Kinked30mm_Test'};
    vals_23cm= [0];
    for a = 1:length(Kinks_10mm23cm)
        for i = 1:10
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm23cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1);
            Force_A0 = ((Force_wrong/4.45)+30.882)/1.6475;
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            csvwrite(k,Data)
        end
    end

    %Kinked: Force output is the Force_A0 output, hence we only need to
    %apply the Loadcell Equation
    Kinks_10mm23cm = {'23cm_Kinked14mm_Test','23cm_Kinked30mm_Test'};
    vals_23cm= [14,30];
    for a = 1:length(Kinks_10mm23cm)
        a
        for i = 1:10
            i
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm23cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1);
            Force_A0 = (Force_wrong);
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            csvwrite(k,Data)
        end
    end
  %% 10mm 30cm: All force column in Data is the Arduino Ouput, hence we only need to apply load EQ. 
Kinks_10mm30cm = {'30cm_Unkinked_Test','30cm_Kinked12mm_Test','30cm_Kinked22mm_Test','30cm_Kinked33mm_Test'}; 
    vals_30cm=[0,12,22,33];
    for a = 1:length(Kinks_10mm30cm)
        a
        for i = 1:10
            i
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm30cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1);
            Force_A0 = (Force_wrong);
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            csvwrite(k,Data)
        end
    end

%% 10mm27cm: Force and Pressure pin switched

Kinks_10mm27cm = {'27cm_Unkinked_Test', '27cm_Kinked7mm_Test','27cm_Kinked15mm_Test','27cm_Kinked31mm_Test'};
    for a = 1:length(Kinks_10mm27cm)
        a
        for i = 1:10
            i
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm27cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1); 
            Pressure_wrong = Data(:,2);
            
            Force_A0 = ((Pressure_wrong + 18.609)/0.7654);
            Pressure_A0 = ((Force_wrong/4.45)+1.963)/0.1535;

            Pressure = (Pressure_A0*0.7654)-18.609;
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            Data(:,2) = Pressure;
            csvwrite(k,Data)
        end
    end





%% 10mm29cm
Kinks_10mm29cm = {'29cm_Unkinked_Test', '29cm_Kinked17mm_Test','29cm_Kinked28mm_Test','29cm_Kinked41mm_Test'};
    for a = 1:length(Kinks_10mm29cm)
        a
        for i = 1:10
            i
            test = num2str(i);
            k = sprintf('10mm_%s%s.csv',Kinks_10mm29cm{a},test)
            Data = csvread(k);
            Force_wrong = Data(:,1); 
            Pressure_wrong = Data(:,2);
            
            Force_A0 = ((Pressure_wrong + 18.609)/0.7654);
            Pressure_A0 = ((Force_wrong/4.45)+1.963)/0.1535;

            Pressure = (Pressure_A0*0.7654)-18.609;
            Force = ((Force_A0*0.1535)-1.963)*4.45;
            Data(:,1) = Force;
            Data(:,2) = Pressure;
            csvwrite(k,Data)
        end
    end






