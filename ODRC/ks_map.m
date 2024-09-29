%% ODRC
%% plot for the Kuramoto-Sivashinsky system

close all

figure(1);

j = 1;
% target
subplot(3,1,1);
pcolor(time_axis_test - start_train, 1:numOut, target_Out(:, 1:length(time_axis_test)))
shading interp
caxis([-0.8 0.8]);
colorbar
xlim([time_axis_test([1 end]) - start_train]);
ylabel('x', 'fontsize', fsize);
xlabel('time (ms)');

% prediction
subplot(3,1,2);
pcolor(time_axis_test - start_train, 1:numOut, squeeze(Out_test_history(:, 1:length(time_axis_test), j)))
shading interp
caxis([-0.8 0.8]);
colorbar
xlim([time_axis_test([1 end]) - start_train]);
ylabel('x', 'fontsize', fsize);
xlabel('time (ms)');

% target - prediction
error_ks = target_Out(:, 1:length(time_axis_test)) - squeeze(Out_test_history(:, 1:length(time_axis_test), j));
subplot(3,1,3);
pcolor(time_axis_test - start_train, 1:numOut, error_ks)
shading interp
colorbar
xlim([time_axis_test([1 end]) - start_train]);
ylabel('x', 'fontsize', fsize);
xlabel('time (ms)');

colormap turbo
