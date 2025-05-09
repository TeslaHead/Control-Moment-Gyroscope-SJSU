close all;
%% ------------------------  [Simulink]  ------------------------ %%

tf = 10000;

%tf = 50000000;
open_system('LPVattitudeLQRTracking');
OL = sim('LPVattitudeLQRTracking');

%% ------------------------  [Plot]  ------------------------ %%

% Yaw
figure;
subplot(3,1,1);
hold on;
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,1),"Color","#0072BD");
legend('Roll');
title('LQR Response [Roll]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
grid on;

% Pitch
subplot(3,1,2);
hold on;
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,2),"Color","#D95319");
plot(OL.Input.time(:),OL.Input.signals.values(:,2),"Color","#77AC30",'LineStyle','--');
legend('Pitch','Input');
title('LQR Response [Pitch]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
grid on;

% Roll
subplot(3,1,3);
hold on;
plot(OL.Attitude_Angles.time(:),OL.Attitude_Angles.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw','Input');
title('LQR Response [Yaw]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');
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
grid on;

% Pitch Rate
subplot(3,1,2);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,2),"Color","#D95319");
legend('Pitch Rate');
title('LQR Response [Pitch Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
grid on;

% Roll Rate
subplot(3,1,3);
plot(OL.Attitude_Angles_Rates.time(:),OL.Attitude_Angles_Rates.signals.values(:,3),"Color","#7E2F8E");
legend('Yaw Rate');
title('LQR Response [Yaw Rate]');
xlabel('Time [Seconds]');
ylabel('Angular [Deg/s]');
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
grid on;

subplot(2,2,2);
plot(OL.gamma_output.time(:),OL.gamma_output.signals.values(:,2),"Color","#0072BD");
legend('Inner Gimbal');
title('LQR Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Degrees]');

grid on;

subplot(2,2,3);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,1),"Color","#D95319");
legend('Outer Gimbal');
title('LQR Response [Outer Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Deg/s]');
grid on;

subplot(2,2,4);
plot(OL.gamma_output_rates.time(:),OL.gamma_output_rates.signals.values(:,2),"Color","#D95319");
legend('Inner Gimbal');
title('LQR Response [Inner Gimbal]');
xlabel('Time [Seconds]');
ylabel('Angle [Deg/s]');
grid on;