% this program analyzes the fit function and explore different ways to do
% self calibration 

clc
clear
close all

%% given the prime 2nd order polynomial calibration function with the
% following coefficients
init_coff = [1, 2, 8];
% plot the prime calibration equation
prime_x = linspace(-10, 10, 100);
prime_y = init_coff(1)*prime_x.^2+init_coff(2)*prime_x+init_coff(3);
figure
plot(prime_x, prime_y)

% calculate h1, k1 from the prime function
h1 = -init_coff(2)/(2*init_coff(1));
k1 = init_coff(3)-init_coff(1)*h1^2;

%% test the calibration functions from 
A1 = [-1.09692296e-3, 1.37987122, 42.6527258];
A2 = [8.10760207e-3, -9.98528132e-1, 2.0965191e2];
A3 = [-1.39475417e-3, 1.9017045, -7.59346726e-1];

X1 = linspace(110, 160, 100);
X2 = linspace(140, 200, 100);
X3 = linspace(155, 210, 100);

Y1 = A1(1)*X1.^2+A1(2)*X1+A1(3);
Y2 = A2(1)*X2.^2+A2(2)*X2+A2(3);
Y3 = A3(1)*X3.^2+A3(2)*X3+A3(3);

figure
plot(X1, Y1)
hold on
plot(X2, Y2)
plot(X3, Y3)
ylabel('Internal Sensor')
xlabel('External Sensor')
title('Fit functions for different initial muscle lengths')
legend('15cm', '20cm', '26cm')