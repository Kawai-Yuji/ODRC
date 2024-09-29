%% ODRC (oscillation-driven reservoir computing)
% Written by Yuji Kawai

% Y. Kawai, T. Morita, J. Park, and M. Asada,
% "Oscillations enhance time-series prediction in reservoir computing with feedback"
% 2024.


clear;

%% main parameters
interval = 20000;
interval_test = 0;

numOsc = 10;
fmin = 0.1;
fmax = 1;
numUnits = 400;
numOutUnits = numUnits;

g = 1.5;
feedback_weight_amp = 3.0;
osc_weight_amp = 0.5;
%noise_amp = 0;
numOut = 1;

PLOT = 1;


%% simulation
param_ODRC;

construct_sine_ODRC;
%construct_neural_ODRC;

% IO setting
io_ODRC;

%% Sinusoidal ODRC
train_sine_ODRC; % train readout
test_sine_ODRC;% test

%% Neural ODRC
%train_neural_ODRC; % train readout
%test_neural_ODRC;% test

% plot
if PLOT == 1
    plot_ODRC
    %lorenz_plot
    %lorenz_map
    %ks_map
end