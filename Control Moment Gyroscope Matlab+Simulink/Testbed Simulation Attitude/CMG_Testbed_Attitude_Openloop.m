%% --------------------  [Simulink]  -------------------- %%

open_system('Testbed_OpenLoop');
OL = sim('Testbed_OpenLoop');

%% ----------------------  [Plot]  ---------------------- %%

figure;
hold on;
subplot(2,1,1);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,1),"Color","#0072BD");
legend('Yaw');
title('Open-Loop Response [Yaw]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
grid on;

% Pitch Rate
subplot(2,1,2);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,1),"Color","#D95319");
legend('Yaw Rate');
title('Open-Loop Response [Yaw Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Degrees/s]');
grid on;

% Gimbal Results
figure;
hold on;
subplot(2,2,1);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,1),"Color","#0072BD");
legend('Outer Gimbal');
title('Open-Loop Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
grid on;

subplot(2,2,2);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,2),"Color","#0072BD");
legend('Inner Gimbal');
title('Open-Loop Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
grid on;

subplot(2,2,3);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,1),"Color","#D95319");
legend('Outer Gimbal');
title('Open-Loop Response [Outer Gimbal Rate]');
xlabel('Time [Seconds]');
ylabel('Angle Rate[Degrees/s]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

subplot(2,2,4);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,2),"Color","#D95319");
legend('Inner Gimbal');
title('Open-Loop Response [Inner Gimbal Rate]');
xlabel('Time [Seconds]');
ylabel('Angle Rate[Degrees/s]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

figure;
hold on;
Gpole = pole(ICs);
Gpole = Gpole(:);
plot(real(Gpole),imag(Gpole),'bx');
title('Eigenvalue');
xlabel('Real');
ylabel('Imag')
grid on;
pole = eig(ICs(:,:,1,1))