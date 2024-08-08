% Parameters
n = length(strainbits);          % Number of time steps
Q = 1E-6;        % Process noise covariance (adjust as needed) 1E-6
R = .2^4;       % Measurement noise covariance (adjust as needed) .1^4

% Generate noisy measurements
z = strainbits

% Initialize Kalman filter variables
x_hat = zeros(1, n); % Estimated state
P = zeros(1, n);     % Covariance
x_hat(1) = strainbits(1);        % Initial state estimate
P(1) = 1;            % Initial covariance

% Kalman filter loop
for k = 2:n
    % Prediction
    x_hat_minus = x_hat(k-1); % State prediction
    P_minus = P(k-1) + Q;     % Covariance prediction
    
    % Update
    K = P_minus / (P_minus + R); % Kalman Gain
    x_hat(k) = x_hat_minus + K * (z(k) - x_hat_minus); % State update
    P(k) = (1 - K) * P_minus;    % Covariance update
end

% Plot results
figure;
plot(z, 'r', 'DisplayName', 'Noisy Measurements'); 
hold on;
plot(x_hat, 'b', 'DisplayName', 'Kalman Filter Estimate');
xlabel('Time step');
ylabel('Value');
legend;
title('Kalman Filter Estimation of Noisy Signal');