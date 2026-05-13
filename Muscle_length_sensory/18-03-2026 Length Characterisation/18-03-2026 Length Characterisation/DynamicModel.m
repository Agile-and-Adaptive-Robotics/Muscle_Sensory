%% Dynamic model
clear; clc; close all
%% --- Load CSV ---
data = readtable('S001P001.csv', 'VariableNamingRule', 'preserve');
data.Properties.VariableNames;


%% --- Extract columns using EXACT names from your CSV ---
delD        = data.("delta d (m)");        % displacement (m)
strain      = data.("strain");
kdot        = data.("strain rate (1/s)");  % strain rate (1/s)
P           = data.("Pressure (Psi)");     % pressure (psi or kPa? convert later)
time        = data.("t_rel(s)");          % time (s)
PWMi      = data.("PWMi");
PWMe      = data.("PWMe");

isOpen    = PWMi == 190;   % valve pressurizing
isExhaust = PWMe == 255;   % valve exhausting
%% --- Geometry ---
L0   = 0.155;       % rest length (m)
Lmin = 0.1313;      % minimum length (m)

kmax = (L0 - Lmin) / L0;   % maximum strain

%strain = delD ./ L0;

relstrain = strain ./ kmax;

kdot_norm = kdot ./ kmax;

Pn = P * 6.894757/ 620; %Pressure converted from psi to kPa and normalized

%% --- Stiffness ---
%from Bolen et al. 2026
c0 = 0.5682;
c1 = 4.254;
c2 = 0.5597;

K = -c0*c1 .* exp(-c1*relstrain) ...
    - 2*c2 .* relstrain .* Pn .* exp(-c2*(relstrain.^2));

%% --- Elastic force ---
F_elastic = c0*(exp(-c1*relstrain) - 1) ...
            + Pn .* exp(-c2*(relstrain.^2));

%% --- Identify damping c(kdot_norm) ---
kdot_norm = smooth(kdot_norm, 15);
mask = abs(kdot_norm) > 1e-3;

c_samples = -F_elastic(mask) ./ kdot_norm(mask);
kdot_norm_samples = kdot_norm(mask);

%% --- Build lookup table ---
nbins = 40;   % number of bins for smoothing

edges = linspace(min(kdot_norm_samples), max(kdot_norm_samples), nbins+1);

% bin(i) = which bin sample i belongs to
[~,~,bin] = histcounts(kdot_norm_samples, edges);

% average c values inside each bin
c_lut = accumarray(bin, c_samples, [nbins 1], @mean, NaN);

% bin centers
kdot_lut = 0.5 * (edges(1:end-1) + edges(2:end));

% remove empty bins
valid = ~isnan(c_lut);
kdot_lut = kdot_lut(valid);
c_lut    = c_lut(valid);

% interpolation function
c = @(kd) interp1(kdot_lut, c_lut, kd, 'linear', 'extrap');


%% --- Viscous force ---
F_visc = c(kdot_norm) .* kdot_norm;

F_model = F_elastic + F_visc;

%% Find max and min kdot_norm
[kdot_max, i1] = max(kdot_norm)
[kdot_min, i2] = max(-kdot_norm)

Fmax1 = F_elastic(i1)
Fmax2 = F_elastic(i2)

c1 = Fmax1/kdot_max
c2 = Fmax2/kdot_min


%% Figures
figure; 
plot(kdot_lut, c_lut, 'o-');
xlabel('Normalized strain rate \dot{k}^*');
ylabel('Damping c(\dot{k}^*)');
title('Identified Damping Lookup Table');
grid on;

figure;
plot(time, F_elastic, 'LineWidth', 1.5); hold on;
plot(time, F_visc, 'LineWidth', 1.5);
plot(time, F_model, 'k', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Force (N)');
legend('F_{elastic}','F_{visc}','F_{model}');
title('Elastic, Viscous, and Total Force vs Time');
grid on;

figure;
subplot(3,1,1);
plot(time, relstrain);
ylabel('relstrain');
title('Normalized Strain');

subplot(3,1,2);
plot(time, kdot_norm);
ylabel('kdot\_norm');
title('Normalized Strain Rate');

subplot(3,1,3);
plot(time, Pn);
ylabel('Pn');
xlabel('Time (s)');
title('Normalized Pressure');

figure;
plot(Pn, relstrain, '.');
xlabel('Normalized Pressure P_n');
ylabel('Normalized Strain \epsilon^*');
title('Strain vs Pressure');
grid on;

figure; hold on;
scatter(Pn(isOpen),    relstrain(isOpen),    20, 'r', 'filled');
scatter(Pn(isExhaust), relstrain(isExhaust), 20, 'b', 'filled');
xlabel('Normalized Pressure P_n');
ylabel('Normalized Strain \epsilon^*');
legend('Valve Open','Valve Exhaust');
title('Strain vs Pressure (Valve State Colored)');