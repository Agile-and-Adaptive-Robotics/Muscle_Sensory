

%This function is written to be used with 2 arduino sketches
%(1) SLoadCell_ZeroFactorSketch, when protocol_id == 1
%(2) ValvePWM, when protocol_id == 2

%Best results when ran like this:
%[data,stats] = ValvePWM()
%arguments in ValvePWM() go as follows:
%ValvePWM(port,protocol_id,total,pw,period)
%port is which port the arduino is connected to, you only need to specify
%the number, so if the port is "COM5" then the port argument should be 5,
%total is the amount of data points to collect (should be greater than 
%10000 when protocol_id is 2, pw is the pulse width and the period is the 
%period, both in milliseconds Note that only the protocol_id and port
%arguments are required, the others can be  ignored and will be set to 
%their default values: total:50000, pw:0, perod:1 (the default values won't
%oscillate the valve and will keep it open for the duration of the test)

function [Data, Stats] = ValvePWM(protocol_id,port,varargin) 

    p = inputParser;
    addRequired(p,'protocol_id');
    addRequired(p,'port');
    addOptional(p,'total',50000);
    addOptional(p,'pw_in',0);
    addOptional(p,'period_in',1);
    addOptional(p,'pw_out',0);
    addOptional(p,'period_out',1);
    parse(p, protocol_id,port,varargin{:});

    protocol_id = p.Results.protocol_id;
    port = strjoin({'COM',num2str(p.Results.port)}, '');   
    total = num2str(p.Results.total);
    pw_in = num2str(p.Results.pw_in);
    period_in = num2str(p.Results.period_in);
    pw_out = num2str(p.Results.pw_out);
    period_out = num2str(p.Results.period_out);

    format short g      %remove scientific notation

    %Initialize serial port 
    s = serialport(port,115200);

    while s.NumBytesAvailable < 1               
        write(s,string(protocol_id),'string');
    end

    %the arduino sends sends the string "running" when it receives the
    %protocol_id, which increases the value of s.NumBytesAvailable and 
    %breaks the loop

    vars = strjoin({total,pw_in,period_in,pw_out,period_out},',');
    %format variables to be easily read by the arduino
    disp(vars);

    write(s,vars,'string'); 
    total = str2num(total);
    readline(s);
    %writes the data for the arduino, reads once to clear
    %the "running" string from the buffer before reading the data

    svalues = zeros(total,3);   %creates array for the data readings
    clf;                        %clears graph from any previous tests

    yyaxis left     %graph force on left axis in blue
    Force = animatedline('color','Blue');
    ylim([-100,1040]);
    ylabel('Force (N)');

    yyaxis right    %graph pressure on right in red
    Pressure = animatedline('color','red');
    ylim([0,800]);
    ylabel('Pressure (kPa)');

    %the load cell data will sometimes spike unexpectedly which
    %causes problems in data collection
 
    prev = 1;   
    %since the spikes can span over multiple data readings, 
    %this variable keeps track of the last data point not in the spike 
    %and compares new data against it until it finds one that is within
    %100 N, which indicates that the spike has ended

    for i = 1:total
        %for 10mm: % Jan 5 2022 ((A0)*0.1535-1.963)4.45 N | Aug 2 %*1.6475)-30.882)*4.45; %Force(N)           
        %for 20mm: Jan 10 2022 ((A0)*0.392)-4.1786)*4.45
        svalues(i,1) = (((str2double(readline(s)))));%*0.392)-4.1786)*4.45; %Force (N)
        svalues(i,2) = ((str2double(readline(s)))*0.7654) -18.609; %Pressure (kPa)         Aug 2
        svalues(i,3) = str2double(readline(s))/1000; %Time(s)

        %read data to each column and convert units when needed
        %column 1 is force, converting lbs to N
        %column 2 is pressure, converting analog value (1-1023) to
        %kPa
        %column 3 is the time that the data was collected,
        %converting milliseconds to seconds

        if i > 1

        %i > 1 because the spike detection references a previous i
        %value, which doesn't exist if the loop started at the minimum
        %i value

            if abs(svalues(i-prev,1)-svalues(i,1))<1000  

            %check if next value is more than
            %100 N away from the last known value

                prev = 1;
                addpoints(Force,svalues(i,3),svalues(i,1)); 
                %if so, add the force data

            else

                svalues(i,1) = svalues(i-prev,1);   
                %otherwise, replace it with the last known data point
                disp('spike');                      
                disp(svalues(i,3));
                prev = prev+1;                        
                %increase the amount of points since 
                %the last value outside of the spike

            end                                     

            addpoints(Pressure,svalues(i,3),svalues(i,2));  
            %add pressure and time data

        end
    end

    addpoints(Force,svalues(i,3),svalues(i,1));     %add data to graph
    addpoints(Pressure,svalues(i,3),svalues(i,2));
    drawnow  

    %Use the following bit of code to find some basic statistics about the data
    %that has been collected.  The operating assumption here is that collecting 
    %6000 data points will be enough for the system to have reached equilibriam,
    %and that the last 500 data points will exists outside of the transient
    %system response.

    %**NOTE: If protocol_id == '1', either comment out the following code,
    %or change the range of data on which the basic statistics are calculated.

    forceData = svalues(500:total*1,1);
    pressureData = svalues(500:total,2);

    %Force stats
    stats = zeros(6,2);
    stats(1,1) = mean(forceData);
    stats(2,1) = median(forceData);
    stats(3,1) = mode(forceData);
    stats(4,1) = min(forceData);
    stats(5,1) = max(forceData);
    stats(6,1) = std(forceData);

    %Pressure stats
    stats(1,2) = mean(pressureData);
    stats(2,2) = median(pressureData);
    stats(3,2) = mode(pressureData);
    stats(4,2) = min(pressureData);
    stats(5,2) = max(pressureData);
    stats(6,2) = std(pressureData);

    %stats table
    rows = {'Mean','Median','mode','min','max','Standard Deviation'};
    columns = {'Force','Pressure'};
    stats = array2table(stats,'RowNames',rows,'VariableNames',columns);

    
    Data = svalues;
    Stats = stats;

end    