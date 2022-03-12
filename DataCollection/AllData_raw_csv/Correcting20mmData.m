% Correcting 20mm DATA: CHANGING THE force output from AO to (N) 
%NOTE: RUN THIS CODE ONLY ONCE. RUning more than once will over process the
%data and write over current data. 


%% 20mm 10cm (12.4cm): Unkink, 13mm, 20mm (Pressure and Force Column = A0 Raw)
Kinks_20mm10cm = {'10cm_Unkinked_Test','10cm_Kinked13mm_Test','10cm_Kinked20mm_Test'};

for a = 1:length(Kinks_20mm10cm)
    a
    for i=1:10
        i
        test=num2str(i);
        k = sprintf('20mm_%s%sData.csv',Kinks_20mm10cm{a},test)
        Data = csvread(k)
        Force = (((Data(:,1))*0.392) -4.1786)*4.45;
        Pressure = (Data(:,2)*0.7654)-18.609
        Data(:,1) = Force;
        Data(:,2) = Pressure;

    end
end


%% 20mm 12cm (15cm) : Unkinked, 10mm, 20mm (Force output = A0 raw, Pressure = kPA)
Kinks_20mm12cm = {'12cm_Unkinked_Test','12cm_Kinked10mm_Test','12cm_Kinked20mm_Test'};

for a = 1:length(Kinks_20mm12cm)
    a
    for i=1:10
        i
        test=num2str(i);
        k = sprintf('20mm_%s%s.csv',Kinks_20mm12cm{a},test)
        Data=csvread(k);
        Force = ((Data(:,1)*0.392) - 4.1786)*4.45;
        Data(:,1) = Force;

    end
end

%% 20mm 23cm (25.3cm): Unkinked, 9mm, 19mm
Kinks_20mm23cm = {'23cm_Unkinked_Test','23cm_Kinked9mm_Test','23cm_Kinked19mm_Test'};

for a = 1:length(Kinks_20mm23cm)
    a
    for i=1:10
        i
        test=num2str(i);
        k = sprintf('20mm_%s%s.csv',Kinks_20mm23cm{a},test)
        Data=csvread(k);
        Force = ((Data(:,1)*0.392) - 4.1786)*4.45;
        Data(:,1) = Force;
    end
end


%% 20mm 30cm (30cm) : Unkinked, 14mm, 23mm, 34mm
Kinks_20mm30cm = {'30cm_Unkinked_Test','30cm_Kinked14mm_Test','30cm_Kinked23mm_Test','30cm_Kinked34mm_Test'};

for a = 1:length(Kinks_20mm30cm)
    a
    for i=1:10
        i
        test=num2str(i);
        k = sprintf('20mm_%s%s.csv',Kinks_20mm30cm{a},test)
        Data=csvread(k);
        Force = ((Data(:,1)*0.392) - 4.1786)*4.45;
        Data(:,1) = Force;
    end
end


%% 20mm 40cm (42.7cm): Unkinked, 35mm, 46mm, 69mm(Pressure and Force Column = A0 Raw)
Kinks_20mm40cm ={'40cm_Unkinked_Test','40cm_Kinked35mm_Test','40cm_Kinked46mm_Test','40cm_Kinked69mm_Test'};

for a = 1:length(Kinks_20mm40cm)
    a
    for i=1:10
        i
        test=num2str(i);
        k = sprintf('20mm_%s%sData.csv',Kinks_20mm40cm{a},test)
        Data=csvread(k);
        Force = (((Data(:,1))*0.392) -4.1786)*4.45;
        Pressure = (Data(:,2)*0.7654)-18.609
        Data(:,1) = Force;
        Data(:,2) = Pressure;
    end
end
