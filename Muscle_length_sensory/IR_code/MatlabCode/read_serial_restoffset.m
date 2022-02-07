% This program reads the serial data from the
% vl5310x_restoffset_calibration.ino and do some plotting and analysis to
% the code

clear;
clc;
close all;

%% connect to serial port
port = "COM5";
s = serial(port, 'BaudRate', 115200, 'Terminator', 'CR');
fopen(s);

%% read the serial port
n = 0;
collect_time = 2; % how long to run sample collection in minutes
sensor_f = 100; % sampling frequency of sensor defined in the Arduino code
n_sample = collect_time*60*sensor_f;
% prep file for writing
timenow = clock;
file_name = 'sensor_data_'+string(timenow(2))+string(timenow(3))+string(timenow(4))+string(timenow(5));
path = 'D:\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\MatlabCode\'+file_name+'.dat';
file = fopen(path, 'w');
while n <= n_sample
    data = fgets(s);
    fprintf(file, '%s', data);
    disp(data);
    n = n+1;
end
fclose(s);
fclose(file);
disp('Done collecting data')

%% open the file and do some analysis
file = fopen(path, 'r');
raw_data = fscanf(file, '%f');
fprintf('Mean: %f\nRange: %f\nStd dev: %f\n', mean(raw_data), max(raw_data)-min(raw_data), std(raw_data))

x = linspace(0, collect_time*60, length(raw_data));
figure
plot(x, raw_data)
% do a runner average
bin = 200; % size of bin for running average
container = zeros(1, 50);
fin_arr = zeros(1, round(length(raw_data)/bin));
a = 0;
for n=1:length(fin_arr)
    fin_arr(n) = mean(raw_data((n-1)*bin+1:n*bin));
end
x1 = linspace(0, collect_time*60, length(fin_arr));
% do a fit of raw data to check drift
fit_raw = polyfit(reshape(x,[1,length(x)]), reshape(raw_data,[1,length(raw_data)]), 1);
yfit = fit_raw(1)*x + fit_raw(2);
fprintf('Fit params: slope=%f mm/s, intercept=%f\n', fit_raw(1), fit_raw(2))
hold on
plot(x1, fin_arr, 'LineWidth', 3)
plot(x, yfit, 'LineWidth', 2)
legend('Raw data', 'Running mean', 'Linfit raw data')
xlabel('Time (s)')
ylabel('Distance (mm)')
title('Sensor drift - running average ' + string(bin) + ' samples')

