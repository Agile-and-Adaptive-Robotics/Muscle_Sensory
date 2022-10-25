function [Data] = ValvePWM_2022(protocol_id,port,varargin)
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
    format short g
    
    %Initialize Serial port
    s = serialport("COM3",115200)
    while s.NumBytesAvailable < 1 %if theres no byte available, write a string to create 
        write(s,string(protocol_id),'string');
    end
    vars = strjoin({total,pw_in,period_in,pw_out,period_out},',');
    disp(vars);
    write(s,vars,'string');
    total=str2num(total);
    readline(s);
    svalues = zeros(total,3);
    clf;
    
    
    prev =1 ; % this prev variable is made to keep track of last data point not in spieke
    for i = 1:total
        svalues(i,1) = ((((str2double(readline(s)))*0.1535)-1.963)*4.45); %force (N)
        svalues(i,2) = ((((str2double(readline(s))))*0.7654) -18.609); %Pressure (kPa)         Aug 2
        svalues(i,3) = (str2double(readline(s))/1000); %Time(s)
        
        if i >1
            if abs(svalues(i-prev,1) - svalues(i,1))<1000
                prev = 1;
   %             addpoints(Force,svalues(i,3),svalues(i,1));
            else
                svalues(i,1) = svalues(i-prev,1);
                disp('spike');
                disp(svalues(i,3));
                prev = prev +1;
            end
            %addpoints(Pressure,svalues(i,3),svalues(i,2));
        end
    end
%     addpoints(Force,svalues(i,3),svalues(i,1));     %add data to graph
%     addpoints(Pressure,svalues(i,3),svalues(i,2));
%     drawnow  

Data = svalues
end
        
    