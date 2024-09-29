%% ODRC
%% parameters

%%%%% recurrent neural networks %%%%%%
%numUnits = 100;				% number of recurrent units of each reservoir
p_connect = 0.1;				% sparsity parameter (probability of connection)
%g = 1.5;						% synaptic strength scaling factor
scale = g / sqrt(p_connect * numUnits);	% scaling for the recurrent matrix
numIn = 1;	                % number of input units
%numOut = 3;						% number of output units for the task
tau = 10.0;

% neural oscillators
numUnits_osc = 100;
g_osc = 1.2;
scale_osc = g_osc / sqrt(p_connect * numUnits_osc);	% scaling for the recurrent matrix
tau_osc = 20;
check_duration = 5000;
resample_threshold = 0.5;

% input weight parameter
input_weight_amp = 5.0;
                
% training & loops
learn_every = 2;      % skip time points
n_learn_loops = 10;   % number of training loops
n_test_loops = 10;           % number of test loops

% recursive least squares
delta = 10.0;                   % P matrix initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% input parameters
input_pulse_value = 2.0;
start_pulse = 200;		% (ms)
reset_duration = 50;	% (ms)

% training duration
start_train = start_pulse + reset_duration;
end_train = start_train + interval + 200;

% output parameters
ready_level = -0.8;
peak_level = 0.8;
ready_level_timing = 0.2;
peak_level_timing = 1;
discard = 3000; % (ms)
peak_width = 30;

% numerics
dt = 1;					% numerical integration time step
tmax = end_train;
n_steps = fix(tmax / dt);			% number of integration time points
n_steps_test = n_steps + interval_test;			% number of integration time points
time_axis = [0:dt:tmax-dt];
time_axis_test = [0:dt:n_steps_test-dt];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawing
lwidth = 2;
lwidth2 = 1.5;
fsize = 10;