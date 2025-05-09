%% ------  [Double Gimbal Gyroscope for Satellite]  ------ %%
clc; clear all; close all;
% By: Jason Nguyen

%% --------------  [Spacecraft Parameters]  -------------- %%

% Angular Momentum of Flywheels
h1 = 0.0100;
h2 = 0.0100;

%MIST <https://www.mdpi.com/2226-4310/10/4/378>
Ix = 0.037;
Iy = 0.051;
Iz = 0.021;

%sSAMsat <https://www.mdpi.com/2226-4310/10/4/378>
%Ix = 0.00402;
%Iy = 0.01422;
%Iz = 0.01454;

%MIST <Attitude Control of a 3U CubeSat - Iraqi Satellite (TIGRISAT)>
%Ix = 0.0333;
%Iy = 0.0333;
%Iz = 6.667*10^-3;

% Gimbal Angles
gamma1_min = deg2rad(-90);
gamma1_max = deg2rad(90);
gamma1_initial = deg2rad(0);
gamma1_points = 16+1;

gamma2_min = deg2rad(0);
gamma2_max = deg2rad(180);
gamma2_initial = deg2rad(90);
gamma2_points = 16+1;

%% --------  [Low Earth Orbit (LEO) Conditions]  -------- %%

R_earth = 6371*10^3;    % Radius of Earth
a = 600*10^3;           % Satellite Altitude
r = R_earth + a;        % Radius of Satellite to Center of Earth
u = 3.986*10^14;        % Earth's gravitational parameter
n = sqrt(u/(r^3));      % Angular velocity

%% ----------------  [LQR Weight Matrix]  ---------------- %%

% [Better Capablility in Tracking with the LQR Tracking (Can do Roll and Pitch)] %
 Q = [2,0,0,0,0,0;...
     0,2,0,0,0,0;...
     0,0,.001,0,0,0;...
     0,0,0,1,0,0
     0,0,0,0,1,0
     0,0,0,0,0,1];

% Actuator Weight Matrix
R = [1,0;
    0,1];

%% -----  [Defining LPV Parameters & State-Space]  ----- %%

p1 = linspace(gamma1_min,gamma1_max,gamma1_points);  % Outter Gimbal
p2 = linspace(gamma2_min,gamma2_max,gamma2_points); % Inner Gimbal

fh = @(t,p) cmg(t,p,Ix,Iy,Iz,n,h1,h2,gamma1_min,gamma1_max,gamma2_min,gamma2_max);      % Calls Statespace Function
G = lpvss(["p1","p2"],fh);                  % LPV Statespace

[p1_grid,p2_grid] = ndgrid(p1,p2);
ICs = sample(G,[],p1_grid,p2_grid);         % List of Statespace

%% ---------------- [Controllability]  ---------------- %%

Co = ctrb(ICs(:,:,1,1));
hi(1,:) = rank(Co)

bode(ICs(:,:,1,1));

%% ---------  [Defining Controller LQR Gains]  --------- %%

for i = 1:length(ICs)
    for l = 1:length(ICs)
        [K_gains{i,l},s,P{i,1}] = lqr(ICs(:,:,i,l),Q,R);
        K11(i,l) = K_gains{i,l}(1,1);
        K21(i,l) = K_gains{i,l}(2,1);
        K12(i,l) = K_gains{i,l}(1,2);
        K22(i,l) = K_gains{i,l}(2,2);
        K13(i,l) = K_gains{i,l}(1,3);
        K23(i,l) = K_gains{i,l}(2,3);
        K14(i,l) = K_gains{i,l}(1,4);
        K24(i,l) = K_gains{i,l}(2,4);
        K15(i,l) = K_gains{i,l}(1,5);
        K25(i,l) = K_gains{i,l}(2,5); 
        K16(i,l) = K_gains{i,l}(1,6);
        K26(i,l) = K_gains{i,l}(2,6);
    end
end

%% ---------------------  [Poles]  --------------------- %%

Gpole = pole(ICs);
Gpole = Gpole(:);

plot(real(Gpole),imag(Gpole),'bx');
title('Pole-Zero Map');
xlabel('Real');
ylabel('Imag')
grid on;

%% ----  [Defining Dynamical Model for State-Space]  ---- %%

function [A,B,C,D,E,dx0,x0,u0,y0,Delays] = cmg(t,p,Ix,Iy,Iz,n,h1,h2,gamma1_min,gamma1_max,gamma2_min,gamma2_max)

    p(1) = max(gamma1_min,min(p(1),gamma1_max));
    p(2) = max(gamma2_min,min(p(2),gamma2_max));

    A = [0 0 0 1 0 0
        0 0 0 0 1 0
        0 0 0 0 0 1
        (-4*(n^2)*(Iy-Iz)-(h1+h2)*n*sin(p(2)))/Ix 0 0 0 (-(h1+h2)*cos(p(2))*sin(p(1)))/Ix (n*(Ix-Iy+Iz)-(h1+h2)*sin(p(2)))/Ix
        (n*(h1+h2)*cos(p(2))*cos(p(1)))/Iy (3*(n^2)*(Iz-Ix))/Iy (-n*(h1+h2)*cos(p(2))*sin(p(1)))/Iy ((h1+h2)*cos(p(2))*sin(p(1)))/Iy 0 ((h1+h2)*cos(p(2))*cos(p(1)))/Iy
        0 0 ((n^2)*(Ix-Iy)-n*(h1+h2)*sin(p(2)))/Iz (n*(-Ix+Iy-Iz)+(h1+h2)*sin(p(2)))/Iz ((h1+h2)*cos(p(2))*cos(p(1)))/Iz 0];

    B = -(h1+h2)*[0 0
        0 0
        0 0 
        -sin(p(1))*cos(p(2))/Ix -cos(p(1))*sin(p(2))/Ix
        sin(p(2))/Iy cos(p(2))/Iy
        -cos(p(1))*cos(p(2))/Iz sin(p(1))*sin(p(2))/Iz];

    C = [1 0 0 0 0 0
        0 1 0 0 0 0
        0 0 1 0 0 0
        0 0 0 1 0 0
        0 0 0 0 1 0
        0 0 0 0 0 1];

    D = [0 0
        0 0
        0 0
        0 0
        0 0
        0 0];

    E = [];
    % no offsets or delays
    dx0 = []; x0 = []; u0 = []; y0 = []; Delays = [];

end

Q1 = [1,0,0,0,0,0,0,0,0,0,0,0;...
      0,1,0,0,0,0,0,0,0,0,0,0;...
      0,0,1,0,0,0,0,0,0,0,0,0;...
      0,0,0,1,0,0,0,0,0,0,0,0;
      0,0,0,0,1,0,0,0,0,0,0,0;
      0,0,0,0,0,1,0,0,0,0,0,0;
      0,0,0,0,0,0,1,0,0,0,0,0;
      0,0,0,0,0,0,0,1,0,0,0,0;
      0,0,0,0,0,0,0,0,1,0,0,0;
      0,0,0,0,0,0,0,0,0,1,0,0;
      0,0,0,0,0,0,0,0,0,0,1,0;
      0,0,0,0,0,0,0,0,0,0,0,1;];

R = [1,0;
    0,1];

%% ---------------  [Determine Controllability]  --------------- %%

for i = 1:length(ICs)
    for l = 1:length(ICs)
        Co_rank(i,l) = rank(ctrb(ICs(:,:,i,l)));
    end
end

%% --------------------  [Simulink]  -------------------- %%

%CMG_Spacecraft_Attitude_Control_Openloop();

CMG_Spacecraft_Attitude_Control_LQR();

%CMG_Spacecraft_Attitude_Control_LQRTracking();