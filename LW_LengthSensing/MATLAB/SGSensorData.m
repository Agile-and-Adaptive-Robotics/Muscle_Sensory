%Live plotting
clc
clear
arduino = serialport("COM5",9600);

potbits= [];
strainbits = [];
straindisp = [];
timeData = [];
potbitsfilter = [];

% 
figure;
dispplot = plot(0, 0, 0, 0, 'r','linewidth',1);
title("Displacement vs Time");
xlabel("Time (ms)");
ylabel("Displacement");
% 
% figure;
% resdispplot = scatter(0, 0, 'b');
% title("Resistance vs Displacement");
% xlabel("Displacement");
% ylabel("Resistance");
% axis([-56.5 -54.5 2.78 2.81]);

% sgplot = plot(0, 0, 'g','linewidth',1);
% title("Strain Gauge Voltage")
% 
% figure;
% potdispplot = plot(0, 0, 0, 0, 'r','linewidth',1);
% title("Potentiometer Displacement");
% xlabel("Time (ms)");
% ylabel("Displacement");
% 

% figure;
% srplot = plot(0, 0, 0, 0, 'r','linewidth',1);
% title("Strain Rate");
% xlabel("Time (ms)");
% ylabel("Velocity");

figure;
strainplot = plot(0, 0, 'r','linewidth',1);
title("Strain");
xlabel("Time (ms)");
ylabel("Strain");


numSize = 5;
waitingRoom = zeros(1, numSize);

while 1
    data = readline(arduino);
    stext = str2num(data);

    potbits(end+1) = stext(1); % Pot reading
    strainbits(end+1) = (stext(2)); %SG voltage
    straindisp(end+1) = stext(3); %SG disp
    timeData(end+1) = stext(4); %time

    waitingRoom = [waitingRoom(2:end), stext(1)]

    if mod(length(timeData), numSize) == 0

    %Smooth data
    %straindispfilter = smoothdata(straindisp, "rloess", 13);
    filterdata = smoothdata(waitingRoom);
    potbitsfilter = [potbitsfilter, filterdata];
   % strainbitsfilter = smoothdata(strainbits, "rlowess", 14);
    % 
    % potlength = -0.0997.*potbits + 226;
    % displacement = 163.15 - potlength;
    % resistance = 0.00139.*strainbits + 2.68;
    % 
    % potlengthfilt = -0.0997.*potbits + 226;
    % displacementfilt = 163.15 - potlengthfilt;
    % resistancefilt = 0.00139.*strainbitsfilter + 2.68;
    % 
    % velocity = diff(displacementfilt) ./ diff(timeData);
    % 
    % strain = displacementfilt/163.15;
    % normalstrain = (strain - min(strain))./(max(strain)-min(strain));
    % strainrate = diff(strain)./diff(timeData);

    %Plots
    dispplot(1).YData = potbits;
    dispplot(1).XData = timeData;
    dispplot(2).YData = potbitsfilter;
    dispplot(2).XData = timeData;
    % % plot
    % resdispplot(1).YData = resistance;
    % resdispplot(1).XData = displacement;

    % potdispplot(1).YData = displacement;
    % potdispplot(1).XData = timeData;
    % potdispplot(2).YData = displacementfilt;
    % potdispplot(2).XData = timeData;

    % sgplot.YData = resistance;
    % sgplot.XData = timeData;

    % srplot(1).YData = velocity;
    % srplot(1).XData = timeData(1:end-1);

    % strainplot(1).YData = strain;
    % strainplot(1).XData = timeData;

     drawnow;
   end
end