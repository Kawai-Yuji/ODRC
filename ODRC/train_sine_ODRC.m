%% ODRC

%%%%%%%%%%%%%%%%%%%%%%
%% 2. train readout %%
%%%%%%%%%%%%%%%%%%%%%%

disp('training readout:');

% initial readout connections WOut(postsyn,presyn)
WOut = zeros(numOut, numOutUnits);

% P matrix for readout learning
P = eye(numOutUnits) / delta;

%% main loops
for j = 1:n_learn_loops

    fprintf('  loop: %d/%d  ', j, n_learn_loops);

    % initial conditions
    Xv = 1 * (2 * rand(numUnits, 1) - 1);
    X = tanh(Xv);
    Xv_current = Xv;
    Out = WOut * X(1:numOutUnits);

	train_window = 0;

	for i = 1:n_steps

        Input = input_pattern(:, i);

        %% update RNN units
        %noise = noise_amp * randn(numUnits, 1) * sqrt(dt);
        Xv_current = W * X + WIn * Input + WFb * Out + WOsc * Osc(:, i);% + noise;
        Xv = Xv + ((-Xv + Xv_current) ./ tau) * dt;
        X = tanh(Xv);

        OutUnits_learn_history(i, j, :) = X;

        % output through readout
        Out = WOut * X(1:numOutUnits);

		% start-end training window
		if i == start_train_n
			train_window = 1;
		end
        if i == end_train_n
			train_window = 0;
		end

		%% train readout
		if (train_window == 1) && (rem(i, learn_every) == 0)
			% update error
			error = target_Out(:, i) - Out;

            P_old = P;
			P_old_X = P_old * X(1:numOutUnits);
			den = 1 + X(1:numOutUnits)' * P_old_X;
			P = P_old - (P_old_X * P_old_X') / den;

			% update output weights
            WOut = WOut + error * (P_old_X / den)';
        end

        Out_learn_history(:, i, j) = Out;
    end

    % performance
     for n = 1:numOut
         R = corrcoef(Out_learn_history(n, start_train_n:end_train_n, j), target_Out(n, start_train_n:end_train_n));
         R2_learn(n, j) = R(1, 2)^2;
         fprintf('R^2(%d)=%.3f, ', n, R2_learn(n, j));
     end
     fprintf('\n');
     fprintf('              ');
     for n = 1:numOut
         Error_learn(n, j) = sqrt(mean((Out_learn_history(n, start_train_n:end_train_n, j) - target_Out(n, start_train_n:end_train_n)) .^ 2));
         fprintf('MSE(%d)=%.3f, ', n, Error_learn(n, j));
     end
 	 fprintf('\n');
end
