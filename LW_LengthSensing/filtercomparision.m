[b,a] = butter(1,.2,'low');    

fpass = 5;
fs = 100;

smooth1 = smoothdata(resistance, "rloess",13);
smooth2 = smoothdata(resistance, "sgolay",13);
smooth3 = filtfilt(b,a,resistance);
smooth4 = lowpass(resistance, fpass,fs);

figure;
plot(time, resistance);
hold on
plot(time, smooth1);
plot(time, smooth2);
plot(time, smooth4);

legend("Raw Data", "smooth1", "smooth2", "smooth3")

%% 
function newdata = Fourier(data)
    freqData = fft(data)

end