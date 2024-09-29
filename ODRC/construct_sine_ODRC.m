%% ODRC

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. construct recurrent neural networks %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('constructing a reservoir:');

% input connections WIn
WIn = input_weight_amp / sqrt(numIn) * randn(numUnits, numIn);

% feedback connections WFb
WFb = feedback_weight_amp / sqrt(numOut) * randn(numUnits, numOut);

WOsc = osc_weight_amp / sqrt(numOsc) * randn(numUnits, numOsc);

%% recurrent connections W
% connectivity matrix
W_mask = rand(numUnits, numUnits);
W_mask(W_mask <= p_connect) = 1;
W_mask(W_mask < 1) = 0;
W = randn(numUnits, numUnits) * scale;
W = W .* W_mask;
W(logical(eye(numUnits))) = 0;	% set self-connections to zero
W = sparse(W);

% Oscillators
f = fmin + (fmax - fmin) * rand(numOsc, 1);
phi = 2 * pi * rand(numOsc, 1);
pos = 1:n_steps_test;
Osc = sin(2 * pi * f * pos / 1000 + phi);
%Osc(:, n_steps+1:n_steps_test) = zeros(numOsc, interval);
