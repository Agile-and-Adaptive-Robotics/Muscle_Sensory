potlength = -0.251459226164492*potbits + 223.786788686759;
vdl = strainbits ./ potlength;

%Remove DC Offset
meanValue = mean(vdl); 
signal = vdl - meanValue;

Fs = 100; %Sampling Frequency
% Perform Fourier Transform
L = length(signal); % Length of signal
Y = fft(signal); %fourier
f = Fs*(0:(L/2))/L; % Frequency range for plotting

resolution = Fs/L;

% Compute magnitude
P2 = abs(Y/L); % Two-sided spectrum
P1 = P2(1:L/2+1); % Single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1); % Adjust amplitude

% Plot the spectrum
figure;
plot(f, P1);
title('Single-Sided Amplitude Spectrum of Signal');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

%Peaks are frequenceis you may want to filter out (noise, etc)

%% Filter
%Bessel Filter
Fs = 100;             % Sampling frequency
N = 5;                 %Filter Order
fc = 15;              % Cutoff Frequency
[z,p,k] = besself(N,fc);          % Bessel analog filter design
[num,den]=zp2tf(z,p,k);           % Convert to transfer function form
[numd,dend]=bilinear(num,den,Fs);

filterdata = filtfilt(numd,dend,vdl);
plot(time,filterdata);
hold on
plot(time,vdl)
ylabel("V/L")
xlabel("Time (ms)")
%% Voltage to Length

% V --> Filter --> 1/TF --> L

sys = tf(num,den);

filtervoltage = filtfilt(numd,dend,strainbits);

s = tf('s');
length = filtervoltage*inv(sys);

