%% --------------------  [Simulink]  -------------------- %%

tf = 500000;
%tf = 50000000;

open_system('LPVattitudeOpenLoop');
OL = sim('LPVattitudeOpenLoop');

%% ----------------------  [Plot]  ---------------------- %%

% Roll
figure;

hold on;
subplot(3,1,1);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,1),"Color","#0072BD");
legend('Roll');
title('Open-Loop Response [Roll]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 30000]);
grid on;

% Pitch
subplot(3,1,2);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,2),"Color","#D95319");
legend('Pitch');
title('Open-Loop Response [Pitch]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 500000]);
grid on;

% Yaw
subplot(3,1,3);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw');
title('Open-Loop Response [Yaw]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 50000]);
grid on;

% Yaw Rate
figure;
hold on;
subplot(3,1,1);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,1),"Color","#0072BD");
legend('Roll Rate');
title('Open-Loop Response [Roll Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 30000]);
grid on;

% Pitch Rate
subplot(3,1,2);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,2),"Color","#D95319");
legend('Pitch Rate');
title('Open-Loop Response [Pitch Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 500000]);
grid on;

% Roll Rate
subplot(3,1,3);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw Rate');
title('Open-Loop Response [Yaw Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 50000]);
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
title('Open-Loop Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

subplot(2,2,4);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,2),"Color","#D95319");
legend('Inner Gimbal');
title('Open-Loop Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

%eig(out.simout.signals.values(:,:,1))
%eig(out.simout.signals.values(:,8,8))
%eig(ICs(:,:,9,9))
