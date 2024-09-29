%% ODRC

% input function
start_pulse_n = round(start_pulse / dt);
reset_duration_n = round(reset_duration / dt);
start_train_n = round(start_train / dt);

input_pattern = zeros(numIn, n_steps_test);
input_pattern(1, start_pulse_n:(start_pulse_n + reset_duration_n - 1)) = input_pulse_value * ones(1, reset_duration_n);


% target output function
end_train_n = round(end_train / dt);

% Chaos attractor
target_Out = zeros(numOut, n_steps_test);
discard_n = round(discard / dt);
start_n = round(start_train / dt);
chaos_n = n_steps_test + discard_n - start_n;

% Lorenz
ds = 5;
chaos = lorenz(chaos_n, ds);

% Rossler
% ds = 15; % downsampling rate of lorenz attractor. The orbit becomes ds times faster.
% chaos = rossler(chaos_n, ds);

% [min_x, max_x] = bounds(chaos(1, (discard_n+1):chaos_n));
% [min_y, max_y] = bounds(chaos(2, (discard_n+1):chaos_n));
% [min_z, max_z] = bounds(chaos(3, (discard_n+1):chaos_n));
% target_Out(1, (start_n+1):n_steps_test) = ready_level + (chaos(1, (discard_n+1):chaos_n) - min_x) / (max_x - min_x) * (peak_level - ready_level);
% target_Out(2, (start_n+1):n_steps_test) = ready_level + (chaos(2, (discard_n+1):chaos_n) - min_y) / (max_y - min_y) * (peak_level - ready_level);
% target_Out(3, (start_n+1):n_steps_test) = ready_level + (chaos(3, (discard_n+1):chaos_n) - min_z) / (max_z - min_z) * (peak_level - ready_level);

% Kuramoto-Sivashinsky
% N = 64;
% L = 22;
% h = 0.1;
% a0 = zeros(N-2,1);
% a0(1:4) = 0.6;
% [tt, at] = ksfmstp(a0, L, h, chaos_n, 1);
% [x, ut] = ksfm2real(at, L);
% min_ks = min(min(ut(1:numOut, (discard_n+1):chaos_n)));
% max_ks = max(max(ut(1:numOut, (discard_n+1):chaos_n)));
% target_Out(:, (start_n+1):n_steps_test) = ready_level + (ut(1:numOut, (discard_n+1):chaos_n) - min_ks) / (max_ks - min_ks) * (peak_level - ready_level);

% Timing
peak_time = start_train + interval;
bell = normpdf(time_axis, peak_time, peak_width);
target_Out = ready_level_timing + ((peak_level_timing - ready_level_timing) / max(bell)) * bell;

% performance (Peason's correlation coefficient)
R2_learn = zeros(numOut, n_learn_loops);
R2_test = zeros(numOut, n_test_loops);
Error_learn = zeros(numOut, n_test_loops);
Error_test = zeros(numOut, n_test_loops);

% Store history
Out_learn_history = zeros(numOut, n_steps, n_learn_loops);
OutUnits_learn_history = zeros(n_steps, n_learn_loops, numUnits);
Out_test_history = zeros(numOut, n_steps_test, n_test_loops);
OutUnits_test_history = zeros(n_steps_test, n_test_loops, numUnits);