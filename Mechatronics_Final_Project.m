%% Mechatronics Project Data Analysis

clear
close all
clc

fs = 5:5:40;        % [Hz]
pws = 10:5:25;       % [ms]
trials = [1 2];

[PWs, Fs] = meshgrid(pws, fs);

sample_freq = 80;   %[Hz]
sample_period = 1000/sample_freq;   %[ms]

[Pavgs, Pmaxs, Pmins, Favgs, Fmaxs, Fmins] = deal( zeros(length(fs), length(pws), length(trials)) );

for k1 = 1:length(trials)
    for k2 = 1:length(pws)
        for k3 = 1:length(fs)
            
            file_name = sprintf('%0.0f Hz %0.0f ms %0.0f.csv', fs(k3), pws(k2), trials(k1));
            
            data = xlsread(file_name);
            
            Pavgs(k3, k2, k1) = mean(data(:, 1));
            Pmaxs(k3, k2, k1) = max(data(:, 1));
            Pmins(k3, k2, k1) = min(data(:, 1));
            
            %
            
            Favgs(k3, k2, k1) = mean(data(:, 3));
            Fmaxs(k3, k2, k1) = max(data(:, 3));
            Fmins(k3, k2, k1) = min(data(:, 3));
            
            %             ts = sample_period*(0:(size(data, 1)-1));
            %
            %             figure, hold on, grid on, xlabel('Time [ms]'), ylabel('Pressure [kPa]'), title(file_name)
            %             plot(ts, data(:, 1))
            %
            %             figure, hold on, grid on, xlabel('Time [ms]'), ylabel('Force [N]'), title(file_name)
            %             plot(ts, data(:, 3))
            %
            %             figure, hold on, grid on, xlabel('Pressure [kPa]'), ylabel('Force [N]'), title(file_name)
            %             plot(data(:,1), data(:,3))
            
        end
    end
end

%%

Pavgavgs = mean(Pavgs, 3); Favgavgs = mean(Favgs, 3);
Pmaxavgs = mean(Pmaxs, 3); Fmaxavgs = mean(Fmaxs, 3);
Pminavgs = mean(Pmins, 3); Fminavgs = mean(Fmins, 3);

Pposs = Pmaxavgs - Pavgavgs;
Pnegs = Pavgavgs - Pminavgs;

Fposs = Fmaxavgs - Favgavgs;
Fnegs = Favgavgs - Fminavgs;

legstr = cell(1, length(pws));

% Plotting Pressure vs Frequency with different pulse width max/min error bars
figure, hold on, grid on, xlabel('Frequency [Hz]'), ylabel('Pressure [kPa]')

for k = 1:length(pws)
%     plot(fs, Pavgavgs(:, k), '.-', 'Markersize', 15)
    errorbar(fs, Pavgavgs(:, k), Pnegs(:, k), Pposs(:, k), '.-', 'Markersize', 25, 'Linewidth', 2)

    legstr{k} = sprintf('pw = %0.0f ms', pws(k));
end
% legend(legstr, 'Location', 'South', 'Orientation', 'Horizontal')
legend(legstr), title('BPA: Pressure vs. Frequency')

% Plotting Force vs Frequency with different pulse width lines and max/min
% error bars
figure, hold on, grid on, xlabel('Frequency [Hz]'), ylabel('Force [N]')
for k = 1:length(pws)
%     plot(fs, Favgavgs, '.-', 'Markersize', 15)
    errorbar(fs, Favgavgs(:, k), Fnegs(:, k), Fposs(:, k), '.-', 'Markersize', 25, 'Linewidth', 2)
    legstr{k} = sprintf('pw = %0.0f ms', pws(k));
end
% legend(legstr, 'Location', 'South', 'Orientation', 'Horizontal')
legend(legstr), title('BPA: Force vs. Frequency')

% Plotting 3 Dimensional Graph of Pulse Width vs. Frequency vs. Pressure
figure, hold on, grid on, xlabel('Pulse Width [ms]'), ylabel('Frequency [Hz]'), zlabel('Pressure [kPa]'), title('BPA: Pressure vs Pulse Width & Frequency')
surf(PWs, Fs, Pavgavgs), view(-45, 20)
plot3(PWs(:), Fs(:), Pavgavgs(:), '.k', 'Markersize', 15)
%% Getting the raw data for an example
example = xlsread("10 Hz 25 ms 1.csv")
sample_freq = 80;   %[Hz]
sample_period = 1000/sample_freq;   %[ms]

ts = sample_period*(0:(size(example, 1)-1));

figure, hold on, grid on, xlabel('Time [ms]'), ylabel('Pressure [kPa]'), title('10 Hz 25 ms Pressure vs Time')
plot(ts, example(:, 1))

figure, hold on, grid on, xlabel('Time [ms]'), ylabel('Force [N]'), title('10 Hz 25 ms Force vs Time')
plot(ts, example(:, 3))

% xlim([350 500])

figure, hold on, grid on, xlabel('Pressure [kPa]'), ylabel('Force [N]'), title('10 Hz 25 ms Pressure vs Force')
plot(example(:,1), example(:,3))

