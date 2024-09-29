%% ODRC

%%%%%%%%%%%%%
%% 3. test %%
%%%%%%%%%%%%%

disp('testing:');

for j = 1:n_test_loops

    fprintf('  loop: %d/%d  ', j, n_test_loops);

    % initial conditions
    Xv = 1 * (2 * rand(numUnits, 1) - 1);
    X = tanh(Xv);
    Xv_current = Xv;
    Out = WOut * X(1:numOutUnits);

    for i = 1:n_steps_test

        Input = input_pattern(:, i);

        % update RNN units
        %noise = noise_amp * randn(numUnits, 1) * sqrt(dt);
        Xv_current = W * X + WIn * Input + WFb * Out + WOsc * Osc(:, i);% + noise;
        Xv = Xv + ((-Xv + Xv_current) ./ tau) * dt;
        X = tanh(Xv);

        OutUnits_test_history(i, j, :) = X;
        
        % output through readout
        Out = WOut * X(1:numOutUnits);

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
