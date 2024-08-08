%Bessel Filter
Fs = 100;             % Sampling frequency
N = 5;                 %Filter Order
fc = 15;              % Cutoff Frequency
[z,p,k] = besself(N,fc);          % Bessel analog filter design
[num,den]=zp2tf(z,p,k);           % Convert to transfer function form
[numd,dend]=bilinear(num,den,Fs);

%Butterworth + Lowpass
[b,a] = butter(1,.2,'low');    
fpass = 10
fs = 100

%Filters
smooth1 = smoothdata(strainbits, "rloess",13);
smooth2 = smoothdata(strainbits, "sgolay",13);
smooth3 = filtfilt(b,a, strainbits);
smooth4 = lowpass(strainbits, fpass,fs);
smooth5 = filtfilt(numd,dend,strainbits);

figure;
plot(time, strainbits);
hold on
plot(time, smooth4);
title("lowpass filter")

figure;
plot(time, strainbits);
hold on
plot(time, smooth5);
title("bessel filter")
%% 

disp("Data variance is " + var(strainbits));
disp("Filter variance is " + var(smooth5));

