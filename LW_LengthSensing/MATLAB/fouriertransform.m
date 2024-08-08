Fs = 100;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 800;             % Length of signal
t = (0:L-1)*T;        % Time vector

F = fft(strainbits)

figure;
plot(Fs/L*(0:L-1),abs(F),"LineWidth",1)
title("Complex Magnitude of fft Spectrum")
xlabel("f (Hz)")
ylabel("|fft(X)|")

figure;
plot(Fs/L*(-L/2:L/2-1),abs(fftshift(F)),"LineWidth",1)
title("fft Spectrum in the Positive and Negative Frequencies")
xlabel("f (Hz)")
ylabel("|fft(X)|")


P2 = abs(F/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1)

figure;
f = Fs/L*(0:(L/2));
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")