%% ODRC
%% plot

close all

%%%%%%%%%%%%%
%% learning %%
%%%%%%%%%%%%%
figure(1);

% outputs
subplot(5,1,1);
for j = 1:n_learn_loops
    plot(time_axis - start_train, Out_learn_history(1, 1:length(time_axis), j), 'linewidth', lwidth2);
    hold all;
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylabel('FORCE Outputs', 'fontsize', fsize);
xlabel('time (ms)');

% reservoir dynamics
subplot(5,1,[2 3]);
for j = 1:n_learn_loops
    for k = 1:10
        plot(time_axis - start_train, OutUnits_learn_history(1:length(time_axis), j, k) + 2 * k, 'linewidth', lwidth2);
        hold all;
    end
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylabel('FORCE Dyamics', 'fontsize', fsize);
xlabel('time (ms)');

% Oscillator outputs
subplot(5,1,[4 5]);
for j = 1:n_learn_loops
    for k = 1:10
        plot(time_axis - start_train, Osc(k, 1:length(time_axis)) + 2 * k, 'linewidth', lwidth2);
        hold all;
    end
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylabel('Module outputs', 'fontsize', fsize);
xlabel('time (ms)');


%%%%%%%%%%%%%
%% testing %%
%%%%%%%%%%%%%
figure(2)

% outputs
subplot(5,1,1);
for j = 1:n_test_loops
    plot(time_axis - start_train, Out_test_history(1, 1:n_steps, j), 'linewidth', lwidth2);
    hold all;
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylim([-1 1]);
ylabel('Module outputs', 'fontsize', fsize);

% reservoir dynamics
subplot(5,1,[2 3]);
for j = 1:n_test_loops
    for k = 1:10
        plot(time_axis - start_train, OutUnits_test_history(1:n_steps, j, k) + 2 * k, 'linewidth', lwidth2);
        hold all;
    end
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylabel('FORCE dynamics', 'fontsize', fsize);

% Oscillator outputs
subplot(5,1,[4 5]);
for j = 1:n_test_loops
    for k = 1:10
        plot(time_axis - start_train, Osc(k, 1:n_steps) + 2 * k, 'linewidth', lwidth2);
        hold all;
    end
end
hold on
xlim([time_axis([1 end]) - start_train]);
ylabel('Module outputs', 'fontsize', fsize);