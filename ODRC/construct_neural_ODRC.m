%% ODRC

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. construct recurrent neural networks %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('constructing RNN modules:');

% input connections WIn
WIn_osc = input_weight_amp / sqrt(numIn) * randn(numUnits_osc, numIn, numOsc);
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

W_osc = zeros(numUnits_osc, numUnits_osc, numOsc);
Resample = zeros(1, numOsc);

%% resampling W
for k = 1:numOsc
    if rem(k, round(numOsc / 10)) == 0
        fprintf('  oscillator %2d/%2d\n', k, numOsc);
    end

    while 1

        % connectivity matrix
        W_mask = rand(numUnits_osc, numUnits_osc);
        W_mask(W_mask <= p_connect) = 1;
        W_mask(W_mask < 1) = 0;
        W_osc(:, :, k) = randn(numUnits_osc, numUnits_osc) * scale_osc;
        W_osc(:, :, k) = W_osc(:, :, k) .* W_mask;
        Wk = W_osc(:, :, k);
        Wk(logical(eye(numUnits_osc))) = 0;	% set self-connections to zero
        W_osc(:, :, k) = sparse(Wk);

        % initial conditions
        Xv = 1 * (2 * rand(numUnits_osc, 1) - 1);
        X = tanh(Xv);

        OutOsc_history = zeros(1, check_duration);

        for i = 1:check_duration
            if i < reset_duration
                Input = 1;
            else
                Input = 0;
            end

            %% update RNN units
            %noise = noise_amp * randn(numUnits, 1) * sqrt(dt);
            Xv_current = W_osc(:, :, k) * X + WIn_osc(:, :, k) * Input;% + noise;
            Xv = Xv + ((-Xv + Xv_current) ./ tau_osc) * dt;
            X = tanh(Xv);
            OutOsc_history(i) = X(1);
        end

        [Out_min, Out_max] = bounds(OutOsc_history((reset_duration+1000):check_duration));
        if (Out_max - Out_min) > resample_threshold
            break
        else
            Resample(k) = 1;
        end
    end
end
fprintf("  %d oscillators were resampled.\n", sum(Resample));


% oscillators
Osc = zeros(numOsc, n_steps_test);