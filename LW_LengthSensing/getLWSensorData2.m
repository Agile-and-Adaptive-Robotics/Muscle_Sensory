%RUN THIS SECTION FIRST !!
clc
clear
data = readData();

%% Use Data (RUN THIS SECOND)

potbits = transpose(data.potbits);
strainbits = transpose(data.strainbits);
straindisp = transpose(data.straindisp);
time = transpose(data.time);
pulselength = (data.pulselength);
pressure = transpose(data.pressure);

potlength = -0.0997.*potbits + 226;
displacement = 163.15 - potlength;
resistance = 0.00139.*strainbits + 2.68;

[b,a] = butter(1,.2,'low');             

resistancefilt = resistance; %filtfilt(b,a,resistance);
lengthfilt = filtfilt(b,a,potlength);
displacementfilt = 163.15 - lengthfilt;

%% PLOTTING

figure
plot(potlength)
hold on
plot(lengthfilt)

timemod = time(200:end)
displacementfiltmod = displacementfilt(200:end);
resistancefiltmod = resistancefilt(200:end);

% timemodinflate = time(2200:2500);
% displacementfiltmodinflate = displacementfilt(2200:2500);
% resistancefiltmodinflate = resistancefilt(2200:2500);
% timemoddeflate = time(2500:2700);
% displacementfiltmoddeflate = displacementfilt(2500:2700);
% resistancefiltmoddeflate = resistancefilt(2500:2700);

t = linspace(min(time),max(time),length(displacement));

% figure
% hold on
% plot(displacementfiltmodinflate,resistancefiltmodinflate)
% plot(displacementfiltmoddeflate,resistancefiltmoddeflate)
% legend('inflate','deflate')


figure
plot(time, potbits)
title('Displacement vs Time')


figure
scatter(displacementfiltmod, resistancefiltmod)
title('Resistance vs. Displacement (all)')

strain = displacementfiltmod./163.15;
normalstrain = (strain - min(strain))./(max(strain)-min(strain));
strainrate = diff(strain)./diff(timemod);
% normalstrainrate = (strainrate-min(strainrate))./(max(strainrate)-min(strainrate));
%Strainrate = [strainrate(277:469);strainrate(661:845);strainrate(1030:1213);strainrate(1397:1582);strainrate(1765:1950);strainrate(2134:2320);strainrate(2505:2682);strainrate(2867:3052)];


%Displacement = [displacementfiltmod(277:469);displacementfiltmod(661:845);displacementfiltmod(1030:1213);displacementfiltmod(1397:1582);displacementfiltmod(1765:1950);displacementfiltmod(2134:2320);displacementfiltmod(2505:2682);displacementfiltmod(2867:3052)];
%Resistance = [resistancefiltmod(277:469);resistancefiltmod(661:845);resistancefiltmod(1030:1213);resistancefiltmod(1397:1582);resistancefiltmod(1765:1950);resistancefiltmod(2134:2320);resistancefiltmod(2505:2682);resistancefiltmod(2867:3052)];
%figure
%scatter(Displacement,Resistance)
%title('Resistance vs. displacement only deflate')

%Strain = (Displacement)./163.15;
%normalStrainrate = diff(Strain)./diff(time);
normalresistance = (resistancefiltmod - 2.9)./ 0.507;

velocity = diff(displacementfiltmod) ./ diff(timemod);
figure
plot(timemod(1:end-1),velocity)
title('Strain Rate')

%Velocity = [velocity(277:469);velocity(661:845);velocity(1030:1213);velocity(1397:1582);velocity(1765:1950);velocity(2134:2320);velocity(2505:2682);velocity(2867:3052)];
% strainrate = diff(strain)./diff(timemod);

%DATA_INFLATE_0SEC = [Strain normalresistance Strainrate];

figure
plot(timemod,resistancefiltmod)
title('Strain Gauge Voltage')
ylim([2.82, 2.85]);

figure
plot(timemod, displacementfiltmod)
title('Potentiometer Displacement')


%% Ok let's make this more efficient

[maxdisp, maxLOCS] = findpeaks(displacementfiltmod,'MinPeakProminence',10);
[mindisp, minLOCS] = findpeaks(-displacementfiltmod,'MinPeakProminence',10);

figure
hold on
plot(timemod, displacementfiltmod)
plot(timemod(maxLOCS), maxdisp,'.')
plot(timemod(minLOCS), -mindisp,'.')

%% FOR INFLATE:
% Strainrate = zeros(1000,1);
% for i= 1:length(minLOCS)
%     Strainrate = strainrate(minLOCS(i):maxLOCS(i));
% end

% 
% Strain = zeros(1000,1);
% for i= 1:length(minLOCS)
%     Strain = strain(minLOCS(i):maxLOCS(i));
% end
% 
% Resistance = zeros(1000,1);
% for i= 1:length(minLOCS)
%     Resistance = normalresistance(minLOCS(i):maxLOCS(i));
% end      
% 
% Time = zeros(1000,1);
% for i= 1:length(minLOCS)
%     Time = timemod(minLOCS(i):maxLOCS(i));
% end   

Strain_inf = [normalstrain(minLOCS(1):maxLOCS(1)); normalstrain(minLOCS(2):maxLOCS(2)); normalstrain(minLOCS(3):maxLOCS(3)); normalstrain(minLOCS(4):maxLOCS(4)); normalstrain(minLOCS(5):maxLOCS(5)); normalstrain(minLOCS(6):maxLOCS(6)); normalstrain(minLOCS(7):maxLOCS(7)); normalstrain(minLOCS(8):maxLOCS(8))];
Time_inf = [timemod(minLOCS(1):maxLOCS(1)); timemod(minLOCS(2):maxLOCS(2)); timemod(minLOCS(3):maxLOCS(3)); timemod(minLOCS(4):maxLOCS(4)); timemod(minLOCS(5):maxLOCS(5)); timemod(minLOCS(6):maxLOCS(6)); timemod(minLOCS(7):maxLOCS(7)); timemod(minLOCS(8):maxLOCS(8))];
Strainrate_inf = [strainrate(minLOCS(1):maxLOCS(1)); strainrate(minLOCS(2):maxLOCS(2)); strainrate(minLOCS(3):maxLOCS(3)); strainrate(minLOCS(4):maxLOCS(4)); strainrate(minLOCS(5):maxLOCS(5)); strainrate(minLOCS(6):maxLOCS(6)); strainrate(minLOCS(7):maxLOCS(7)); strainrate(minLOCS(8):maxLOCS(8))];
Resistance_inf = [normalresistance(minLOCS(1):maxLOCS(1)); normalresistance(minLOCS(2):maxLOCS(2)); normalresistance(minLOCS(3):maxLOCS(3)); normalresistance(minLOCS(4):maxLOCS(4)); normalresistance(minLOCS(5):maxLOCS(5)); normalresistance(minLOCS(6):maxLOCS(6)); normalresistance(minLOCS(7):maxLOCS(7)); normalresistance(minLOCS(8):maxLOCS(8))];

figure
plot(Strain_inf, Resistance_inf,'o')

%% FOR DEFLATE: 

Strain_def = [normalstrain(maxLOCS(1):minLOCS(2)); normalstrain(maxLOCS(2):minLOCS(3)); normalstrain(maxLOCS(3):minLOCS(4)); normalstrain(maxLOCS(4):minLOCS(5)); normalstrain(maxLOCS(5):minLOCS(6)); normalstrain(maxLOCS(6):minLOCS(7)); normalstrain(maxLOCS(7):minLOCS(8)); normalstrain(maxLOCS(8):minLOCS(9))];
Time_def = [timemod(maxLOCS(1):minLOCS(2)); timemod(maxLOCS(2):minLOCS(3)); timemod(maxLOCS(3):minLOCS(4)); timemod(maxLOCS(4):minLOCS(5)); timemod(maxLOCS(5):minLOCS(6)); timemod(maxLOCS(6):minLOCS(7)); timemod(maxLOCS(7):minLOCS(8)); timemod(maxLOCS(8):minLOCS(9))];
Strainrate_def = [strainrate(maxLOCS(1):minLOCS(2)); strainrate(maxLOCS(2):minLOCS(3)); strainrate(maxLOCS(3):minLOCS(4)); strainrate(maxLOCS(4):minLOCS(5)); strainrate(maxLOCS(5):minLOCS(6)); strainrate(maxLOCS(6):minLOCS(7)); strainrate(maxLOCS(7):minLOCS(8)); strainrate(maxLOCS(8):minLOCS(9))];
Resistance_def = [normalresistance(maxLOCS(1):minLOCS(2)); normalresistance(maxLOCS(2):minLOCS(3)); normalresistance(maxLOCS(3):minLOCS(4)); normalresistance(maxLOCS(4):minLOCS(5)); normalresistance(maxLOCS(5):minLOCS(6)); normalresistance(maxLOCS(6):minLOCS(7)); normalresistance(maxLOCS(7):minLOCS(8)); normalresistance(maxLOCS(8):minLOCS(9))];

figure
plot(Time_inf, Strain_inf,'o')

%% Package and Send

DATA_INFLATE_5SEC = [Strain_inf Resistance_inf Strainrate_inf];
DATA_DEFLATE_10 = [Strain_def Resistance_def Strainrate_def];

%% readData Function

%Stores Arduino data into "pressure", "potbits", "strainbits", "straindisp","time" variables
function data = readData()

% Initialize the serial port on the correct port, with a baud rate
arduino = serialport("COM5",9600)

% Determine how many sets of data to collect
sets_to_collect = 800; % Total number of readings

% Read the data and store in cell array
stext = cell(sets_to_collect, 1);

disp("Collecting Data...")

for i = 1:sets_to_collect  % Assume the first read is now complete
    data = readline(arduino);
    stext{i} = str2num(data);
end

%Initialize matrices to store data
potbitsData = zeros(sets_to_collect, 1);
strainbitsData = zeros(sets_to_collect, 1);
straindispData = zeros(sets_to_collect, 1);
pulselengthData = zeros(sets_to_collect, 1);
pressureData = zeros(sets_to_collect, 1);
timeData = zeros(sets_to_collect, 1);

%Store the resulting data in each matrix, grab all rows of each column for
%each data set
for i = 1:sets_to_collect
    potbitsData(i) = stext{i}(1);
    strainbitsData(i) = stext{i}(2);
    straindispData(i) = stext{i}(3);
    pulselengthData(i) = stext{i}(4);
    pressureData(i) = stext{i}(5);
    timeData(i) = stext{i}(6);
end

%Package the data for output
data = struct('potbits', potbitsData, 'strainbits', strainbitsData, 'straindisp', straindispData, 'pulselength', pulselengthData, 'pressure', pressureData,'time', timeData);

disp("Data Collected! :)")

% Close the port before ending the function
clear s

end
