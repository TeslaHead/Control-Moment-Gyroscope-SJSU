%% --------------------  [Simulink]  -------------------- %%

open_system('Testbed_ClosedLoopTracking');
OL = sim('Testbed_ClosedLoopTracking');

%% ----------------------  [Plot]  ---------------------- %%

figure;
subplot(2,1,1);
hold on;
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,1),"Color","#0072BD");
plot(OL.Input.time(:),OL.Input.signals.values(:,1),"Color","#77AC30",'LineStyle','--');
legend('Yaw','Desired Yaw');
title('LQR Track Response [Yaw]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
%xlim([OL.Attitude_Angles.time(1) OL.Attitude_Angles.time(:)]);
grid on;

% Yaw Rate
subplot(2,1,2);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,1),"Color","#D95319");
legend('Yaw Rate');
title('LQR Track Response [Yaw Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Degrees/s]');
%xlim([OL.Attitude_Angles_Rates.time(1) 50000]);
grid on;

% Gimbal Results
figure;
hold on;
subplot(2,2,1);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,1),"Color","#0072BD");
legend('Outer Gimbal');
title('LQR Track Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
grid on;

subplot(2,2,2);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,2),"Color","#0072BD");
legend('Inner Gimbal');
title('LQR Track Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
grid on;

subplot(2,2,3);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,1),"Color","#D95319");
legend('Outer Gimbal');
title('LQR Track [Outer Gimbal Rate]');
xlabel('Time [Seconds]');
ylabel('Angle Rate[Deg/s]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

subplot(2,2,4);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,2),"Color","#D95319");
legend('Inner Gimbal');
title('LQR Track [Inner Gimbal Rate]');
xlabel('Time [Seconds]');
ylabel('Angle Rate [Deg/s]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;