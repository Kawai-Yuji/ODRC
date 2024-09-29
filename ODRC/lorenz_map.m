%% ODRC
% Lorenz map

j = 1;
figure(7)
t = 1;
z_train = Out_test_history(3, (start_train_n+1):end_train_n, j);
Osc_train = islocalmax(z_train);
x_train = z_train(Osc_train);
y_train = circshift(x_train, -1);
l_train = length(x_train);
plot(x_train(1:(l_train-1)), y_train(1:(l_train-1)), '.b', 'MarkerSize',15)
hold on;

z_test = Out_test_history(3, (end_train_n+1):n_steps_test, j);
Osc_test = islocalmax(z_test);
x_test = z_test(Osc_test);
y_test = circshift(x_test, -1);
l_test = length(x_test);
plot(x_test(1:(l_test-1)), y_test(1:(l_test-1)), '.r', 'MarkerSize',15)
hold off;
xlim([0.1 0.9]);
ylim([0.1 0.9]);