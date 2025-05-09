% By: Jason Nguyen
%% ------------------------  [Simulink]  ------------------------ %%

tf = 30000;
open_system('LPVattitudeLQR');
OL = sim('LPVattitudeLQR');

%% ------------------------  [Plot]  ------------------------ %%

% Yaw
figure;
hold on;
subplot(3,1,1);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,1),"Color","#0072BD");
legend('Roll');
title('LQR Response [Roll]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 100]);
ylim([min(OL.Attitude_Angles.signals.values(:,1))-5 max(OL.Attitude_Angles.signals.values(:,1))+5]);

grid on;

% Pitch
subplot(3,1,2);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,2),"Color","#D95319");
legend('Pitch');
title('LQR Response [Pitch]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 100]);
ylim([min(OL.Attitude_Angles.signals.values(:,2))-5 max(OL.Attitude_Angles.signals.values(:,2))+5]);

grid on;

% Roll
subplot(3,1,3);
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw');
title('LQR Response [Yaw]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.Attitude_Angles.time(1) 30000]);
ylim([min(OL.Attitude_Angles.signals.values(:,3))-5 max(OL.Attitude_Angles.signals.values(:,3))+5]);

grid on;

% Yaw Rate
figure;
hold on;
subplot(3,1,1);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,1),"Color","#0072BD");
legend('Roll Rate');
title('LQR Response [Roll Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 100]);
ylim([min(OL.Attitude_Angles_Rates.signals.values(:,1))-0.1 max(OL.Attitude_Angles_Rates.signals.values(:,1)+0.1)]);
grid on;

% Pitch Rate
subplot(3,1,2);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,2),"Color","#D95319");
legend('Pitch Rate');
title('LQR Response [Pitch Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 100]);
ylim([min(OL.Attitude_Angles_Rates.signals.values(:,2))-0.1 max(OL.Attitude_Angles_Rates.signals.values(:,2)+0.1)]);

%xlim([OL.Attitude_Angles_Rates.time(1) 500000]);
grid on;

% Roll Rate
subplot(3,1,3);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw Rate');
title('LQR Response [Yaw Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
xlim([OL.Attitude_Angles_Rates.time(1) 100]);
ylim([min(OL.Attitude_Angles_Rates.signals.values(:,3)) max(OL.Attitude_Angles_Rates.signals.values(:,3))]);

%xlim([OL.Attitude_Angles_Rates.time(1) 50000]);
grid on;

% Gimbal Results
figure;
hold on;
subplot(2,2,1);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,1),"Color","#0072BD");
legend('Outer Gimbal');
title('LQR Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');

%xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
xlim([OL.gamma_output.time(1) 50]);
ylim([min(OL.gamma_output.signals.values(:,1))-20 max(OL.gamma_output.signals.values(:,1))+20]);

grid on;

subplot(2,2,2);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,2),"Color","#0072BD");
legend('Inner Gimbal');
title('LQR Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
xlim([OL.gamma_output.time(1) OL.gamma_output.time(length(OL.gamma_output.time(:)))]);
ylim([min(OL.gamma_output.signals.values(:,2))-20 max(OL.gamma_output.signals.values(:,2))+20]);

grid on;

subplot(2,2,3);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,1),"Color","#D95319");
legend('Outer Gimbal');
title('LQR Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Deg/s]');
xlim([OL.gamma_output_rates.time(1) 50]);
%xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;

subplot(2,2,4);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,2),"Color","#D95319");
legend('Inner Gimbal');
title('LQR Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Deg/s]');
xlim([OL.gamma_output_rates.time(1) 50]);
%xlim([OL.gamma_output_rates.time(1) OL.gamma_output_rates.time(length(OL.gamma_output_rates.time(:)))]);
grid on;