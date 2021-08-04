

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
    addOptional(p,'total_in',5000);
    addOptional(p,'total_out',2000);
    addOptional(p,'pw_in',0);
    addOptional(p,'period_in',1);
    addOptional(p,'pw_out',0);
    addOptional(p,'period_out',1);
    parse(p, protocol_id,port,varargin{:});

    protocol_id = p.Results.protocol_id;
    port = strjoin({'COM',num2str(p.Results.port)},'');   
    total_in = num2str(p.Results.total_in);
    total_out = num2str(p.Results.total_out);
    pw_in = num2str(p.Results.pw_in);
    period_in = num2str(p.Results.period_in);
    pw_out = num2str(p.Results.pw_out);
    period_out = num2str(p.Results.period_out);

    format short g      %remove scientific notation

    %Initialize serial port 
    s = serialport(port,9600);

    while s.NumBytesAvailable < 1               
        write(s,string(protocol_id),'string');
        pause(0.25);
    end

    %the arduino sends sends the string "running" when it receives the
    %protocol_id, which increases the value of s.NumBytesAvailable and 
    %breaks the loop

    vars = strjoin({total_in,total_out,pw_in,period_in,pw_out,period_out},',');
    %format variables to be easily read by the arduino

    disp(vars);
    write(s,vars,'string'); 
    total_in = str2num(total_in);
    total_out = str2num(total_out);
    total = total_in + total_out;
    readline(s);
    %writes the data for the arduino, reads once to clear
    %the "running" string from the buffer before reading the data
    
    svalues = zeros(total,5);   %creates array for the data readings
    clf;                        %clears graph from any previous tests

    yyaxis left     %graph force on left axis in blue
    Force = animatedline('color','blue');
    ylim([-50,300]);
    ylabel('Force (N)');

    yyaxis right    %graph pressure on right in red
    Pressure = animatedline('color','red');
    ylim([10,700]);
    ylabel('Pressure (kPa)');

    %the load cell data will sometimes spike unexpectedly which
    %causes problems in data collection

    prev = 1;   
    %since the spikes can span over multiple data readings, 
    %this variable keeps track of the last data point not in the spike 
    %and compares new data against it until it finds one that is within
    %100 N, which indicates that the spike has ended

    for i = 1:total
        
        svalues(i,1) = str2double(readline(s));         %raw force
        svalues(i,2) = str2double(readline(s));         %raw pressure
        svalues(i,3) = svalues(i,1)*0.00505+(2/300000); %force (N)
        svalues(i,4) = svalues(i,2)*395/512-115;        %pressure (kPa)
        svalues(i,5) = str2num(readline(s))/1000;                %time (seconds)
       
        if i > 1

        %i > 1 because the spike detection references a previous i
        %value, which doesn't exist if the loop started at the minimum
        %i value

            if abs(svalues(i-prev,3)-svalues(i,3))<100  

            %check if next value is more than
            %100 N away from the last known value

                prev = 1;
                addpoints(Force,svalues(i,5),svalues(i,3)); 
                %if so, add the force data

            else

                svalues(i,3) = svalues(i-prev,3);   
                %otherwise, replace it with the last known data point
                disp('spike');                      
                disp(svalues(i,5));
                prev = prev+1;                        
                %increase the amount of points since 
                %the last value outside of the spike

            end                                     

            addpoints(Pressure,svalues(i,5),svalues(i,4));  
            %add pressure and time data

        end
    end

    addpoints(Force,svalues(i,5),svalues(i,3));     %add data to graph
    addpoints(Pressure,svalues(i,5),svalues(i,4));
    drawnow  

    %Use the following bit of code to find some basic statistics about the data
    %that has been collected.  The operating assumption here is that collecting 
    %6000 data points will be enough for the system to have reached equilibriam,
    %and that the last 500 data points will exists outside of the transient
    %system response.

    %**NOTE: If protocol_id == '1', either comment out the following code,
    %or change the range of data on which the basic statistics are calculated.

    forceData = svalues(500:total,3);
    pressureData = svalues(500:total,4);
    rawForce = svalues(500:total,2);
    rawPressure = svalues(500:total,1);
    
    %Force stats
    stats = zeros(6,4);
    stats(1,4) = mean(forceData);
    stats(2,4) = median(forceData);
    stats(3,4) = mode(forceData);
    stats(4,4) = min(forceData);
    stats(5,4) = max(forceData);
    stats(6,4) = std(forceData);

    %Pressure stats
    stats(1,3) = mean(pressureData);
    stats(2,3) = median(pressureData);
    stats(3,3) = mode(pressureData);
    stats(4,3) = min(pressureData);
    stats(5,3) = max(pressureData);
    stats(6,3) = std(pressureData);
    
    %Raw Force
    stats(1,2) = mean(rawForce);
    stats(2,2) = median(rawForce);
    stats(3,2) = mode(rawForce);
    stats(4,2) = min(rawForce);
    stats(5,2) = max(rawForce);
    stats(6,2) = std(rawForce);
    
    %Raw Pressure
    stats(1,1) = mean(rawPressure);
    stats(2,1) = median(rawPressure);
    stats(3,1) = mode(rawPressure);
    stats(4,1) = min(rawPressure);
    stats(5,1) = max(rawPressure);
    stats(6,1) = std(rawPressure);

    %stats table
    rows = {'Mean','Median','mode','min','max','Standard Deviation'};
    columns = {'Raw Pressure','Raw Force','Force','Pressure'};
    stats = array2table(stats,'RowNames',rows,'VariableNames',columns);

    
    Data = svalues;
    Stats = stats;

end    