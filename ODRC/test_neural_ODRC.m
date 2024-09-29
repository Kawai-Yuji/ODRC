%% reBASICS

%%%%%%%%%%%%%
%% 3. test %%
%%%%%%%%%%%%%

disp('testing:');

for j = 1:n_test_loops

    fprintf('  loop: %d/%d  ', j, n_test_loops);

    % initial conditions
    Xv_osc = 1 * (2 * rand(numUnits_osc, numOsc) - 1);
    X_osc = tanh(Xv_osc);
    Xv_current_osc = Xv_osc;
    Out_osc = X_osc(1, :)';

    Xv = 1 * (2 * rand(numUnits, 1) - 1);
    X = tanh(Xv);
    Xv_current = Xv;
    Out = WOut * X(1:numOutUnits);

    for i = 1:n_steps_test

        Input = input_pattern(:, i);

        % update RNN units
        if i <= n_steps_test
            %noise_osc = noise_amp * randn(numUnits_osc, numOsc) * sqrt(dt);
            for k = 1:numOsc
                Xv_current_osc(:, k) = W_osc(:, :, k) * X_osc(:, k) + WIn_osc(:, :, k) * Input;% + noise_osc(:, k);
            end
            Xv_osc = Xv_osc + ((-Xv_osc + Xv_current_osc) ./ tau_osc) * dt;
            X_osc = tanh(Xv_osc);
            Out_osc = X_osc(1, :)';
        else
            Out_osc = zeros(numOsc, 1);
        end

        %noise = noise_amp * randn(numUnits, 1) * sqrt(dt);
        Xv_current = W * X + WIn * Input + WFb * Out + WOsc * Out_osc;% + noise;
        Xv = Xv + ((-Xv + Xv_current) ./ tau) * dt;
        X = tanh(Xv);

        OutUnits_test_history(i, j, :) = X;
        
        % output through readout
        Out = WOut * X(1:numOutUnits);

        Osc(:, i) = Out_osc;
        Out_test_history(:, i, j) = Out;
    end

    % performance
     for n = 1:numOut
         R = corrcoef(Out_test_history(n, start_train_n:end_train_n, j), target_Out(n, start_train_n:end_train_n));
         R2_test(n, j) = R(1, 2)^2;
         fprintf('R^2(%d)=%.3f, ', n, R2_test(n, j));
     end
     fprintf('\n');
     fprintf('              ');
     for n = 1:numOut
        Error_test(n, j) = sqrt(mean((Out_test_history(n, start_train_n:end_train_n, j) - target_Out(n, start_train_n:end_train_n)) .^ 2, 2));
        fprintf('MSE(%d)=%.3f, ', n, Error_test(n, j));
     end
     fprintf('\n');
end