  %This function is written to be used with 2 arduino sketches
%(1) SLoadCell_ZeroFactorSketch, when protocol_id == 1
%(2) Knee TorqueTest, when protocol_id == 2
%if protocol_id == 2, then the 'total' variable is how many data points
%to collect (should be at least 10000 to get reliable data)

function [Data, Stats] = PressureTest(protocol_id,port,varargin) 

    p = inputParser;
    addRequired(p,'protocol_id');
    addRequired(p,'port');
    addOptional(p,'total',4500);
    addOptional(p,'experimentNum',9);
    parse(p,protocol_id,port,varargin{:});
    
    protocol_id = num2str(p.Results.protocol_id);
    port = strjoin({'COM',num2str(p.Results.port)},'');
    total = p.Results.total;
    experimentNum = p.Results.experimentNum;
    
    %remove scientific notation
    format short g

    %Initialize serial port 
    s = serialport(port,9600);

    while s.NumBytesAvailable < 1               
        write(s,string(protocol_id),'string');
        pause(0.25);
    end
    %the arduino sends sends the string "running" when it receives the
    %protocol_id, which increases the value of s.NumBytesAvailable and 
    %breaks the loop

    write(s,string(total),'string')
    readline(s)
    %writes the amount of data points to collect, reads once to clear
    %the "running" string from the buffer before reading the data

    svalues = zeros(total,2);   %creates array for the data
    clf;                        %clears graph from any previous tests

        %graph pressure in red
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
                                        
        svalues(i,2) = str2double(readline(s))*0.741-105;
        svalues(i,1) = str2double(readline(s))/1000;
        %read data to each column and convert units when needed
        %column 1 is force, converting lbs to N
% %         %column 2 is pressure, converting analog value (1-1023) to
        %kPa
        %column 3 is the time that the data was collected,
        %converting milliseconds to seconds

            addpoints(Pressure,svalues(i,1),svalues(i,2));  
            %add pressure and time data
            
    end

    %Use the following bit of code to find some basic statistics about the data
    %that has been collected.  The operating assumption here is that collecting 
    %6000 data points will be enough for the system to have reached equilibriam,
    %and that the last 500 data points will exists outside of the transient
    %system response.

    %**NOTE: If protocol_id == '1', either comment out the following code,
    %or change the range of data on which the basic statistics are calculated.

    pressureData = svalues(1:total,2);

    %Pressure stats
    stats(1,1) = mean(pressureData);
    stats(2,1) = median(pressureData);
    stats(3,1) = mode(pressureData);
    stats(4,1) = min(pressureData);
    stats(5,1) = max(pressureData);
    stats(6,1) = std(pressureData);

    rows = {'Mean','Median','mode','min','max','Standard Deviation'};
    columns = {'Pressure'};
    stats = array2table(stats,'RowNames',rows,'VariableNames',columns);

    Data = svalues;
    Stats = stats;
    
    
%     filename = strjoin('Experiment',experimentNum);
%     save(filename,data);
%     disp(filename);

end