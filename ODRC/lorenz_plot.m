%% ODRC
% Plot for Lorenz trajectories

figure(4)
j = 1;
for q = 1:numOut
    subplot(numOut,1,q);
    plot(time_axis_test(1:length(target_Out(q, :))) - start_train, target_Out(q, :), 'g-', 'linewidth', lwidth);
    hold on;

    plot(time_axis((start_train_n+1):end_train_n) - start_train, Out_learn_history(q, (start_train_n+1):end_train_n, j), 'b-', 'linewidth', lwidth);
    plot(time_axis((end_train_n+1):n_steps) - start_train, Out_learn_history(q, (end_train_n+1):n_steps, j), 'r-', 'linewidth', lwidth);

    ylabel('Input/2, output, target', 'fontsize', fsize);
    ylim([ready_level-0.2 peak_level+0.2]);
    xlim([time_axis([1 end]) - start_train]);
end

figure(5)

plot3(Out_test_history(1, (start_train_n+1):end_train_n, j), Out_test_history(2, (start_train_n+1):end_train_n, j), Out_test_history(3, (start_train_n+1):end_train_n, j), '-b', 'linewidth', lwidth)
hold on;
plot3(Out_test_history(1, (end_train_n+1):n_steps_test, j), Out_test_history(2, (end_train_n+1):n_steps_test, j), Out_test_history(3, (end_train_n+1):n_steps_test, j), '-r', 'linewidth', lwidth)
grid on;

figure(6)
for q = 1:numOut
    subplot(numOut,1,q);
    plot(time_axis_test(1:length(target_Out(q, :))) - start_train, target_Out(q, :), 'g-', 'linewidth', lwidth);
    hold on;

    plot(time_axis((start_train_n+1):end_train_n) - start_train, Out_test_history(q, (start_train_n+1):end_train_n, j), 'b-', 'linewidth', lwidth);
    plot(time_axis_test((end_train_n+1):n_steps_test) - start_train, Out_test_history(q, (end_train_n+1):n_steps_test, j), 'r-', 'linewidth', lwidth);

    ylabel('Input/2, output, target', 'fontsize', fsize);
    ylim([ready_level-0.2 peak_level+0.2]);
    xlim([time_axis_test([1 end]) - start_train]);
end