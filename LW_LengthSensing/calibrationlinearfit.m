clc
clear

coeff1, coeff2 = getCoefficients(potlength, resistance);


%% 
function coeff1, coeff2 = getCoefficients(potlength, resistance)
%coeff1 is the array of coefficients of the calibration of the
%potentiometer
%coeff2 is the array of coefficients of the calibration of the strain gauge
%potlength and resistance are manual measurements 

arduino = serialport("COM5", 9600);

%% 
% Prompt the user to enter measurements
n = input('Enter the number of resistance measurements: ');
resistance = zeros(1, n);

z = input('Enter the number of length measurements: ');
potlength = zeros(1, z);

% 8 for both works fine, depends on the number of trials you take 

% Input each measurement
for i = 1:n
    resistance(i) = input(['Enter resistance measurement ', num2str(i), ': ']);
    potbits(end+1) = trialdata(1);
    potlength(i) = input(['Enter length measurement ', num2str(i), ': ']);
    strainbits(end+1) = trialdata(2);

    fprintf(s, 'R');

    trialdata = readline(arduino);
    trialdata = str2num(trialdata);

    potbits(end+1) = trialdata(1);
    strainbits(end+1) = trialdata(2);
end

coeff1 = polyfit(potbits, potlength,1);
coeff2 = polyfit(strainbits, resistance,1);

end