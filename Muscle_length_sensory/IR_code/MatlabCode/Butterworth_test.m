close all
clc
clear

%test 2nd order Butterworth filter 
fc = 4;
wc = 2*pi*fc;
z = 0.707
s = tf('s');
G = (wc^2)/(s^2+2*z*wc*s+(wc)^2)
Ts = 1/50;
Gd = c2d(G, Ts, 'zoh')
z = tf('z', Ts);
figure
bode(G)
figure
bode(Gd)
