clc
clear

coeff1, coeff2 = getCoefficients(potlength, resistance);


%% 
%function coeff1, coeff2 = getCoefficients()
%coeff1 is the array of coefficients of the calibration of the
%potentiometer
%coeff2 is the array of coefficients of the calibration of the strain gauge
%potlength and resistance are manual measurements 

arduino = serialport("COM5", 9600);
fopen(arduino);

% Prompt the user to enter measurements
n = input('Enter the number of measurements: ');
resistance = zeros(1,n);
potlength = zeros(1,n);
potbits = zeros(1,n);
potlength = zeros(1,n);

% 7 for both works fine, depends on the number of trials you take. In
% Arduino increments are set up so that 7 trials covers about the full range.(0
% 1500 2000 2500 3000 3500 4000)

% Input each measurement
for i = 1:n
    resistance(i) = input(['Enter resistance measurement (Ohms) ', num2str(i), ': ']);
    potlength(i) = input(['Enter length measurement (mm) ', num2str(i), ': ']);

    fprintf(arduino,'%c', 'R');

    trialdata = fscanf(arduino);
    trialdata = str2num(trialdata)
    

    potbits(i) = trialdata(1);
    strainbits(i) = trialdata(2);
    disp(["PWM Value =" + trialdata(3)]);
end

coeff1 = polyfit(potbits, potlength,1);
coeff2 = polyfit(strainbits, resistance,1);

fitline1 = coeff1(1)*potbits+coeff1(2)
fitline2 = coeff2(1)*strainbits+coeff2(2)

figure;
title("Potentiometer Calibration");
xlabel("potbits");
ylabel("Measured Length (mm)")
scatter(potbits, potlength);
hold on
plot(potbits, fitline1);

figure;
title("Strain Gauge Calibration");
xlabel("strainbits");
ylabel("Measured Voltage (V)")
scatter(strainbits, resistance);
hold on
plot(strainbits,fitline2);

delete(arduino);