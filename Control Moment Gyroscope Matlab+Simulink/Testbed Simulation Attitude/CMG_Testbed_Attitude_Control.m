%% --------  [Double Gimbal Gyroscope for Testbed]  -------- %%
% MATLAB code used to run a LPV model and a gain-scheduling LQR
% controller for a control moment gyroscope testbed. Code also 
% runs simulations that test the dynamics of the model. This 
% included open-loop, closed-loop, and closed-loop tracking 
% simulation.
% By: Jason Nguyen

clc; clear all; close all;

%% ------------------  [Simulation Time]  ------------------ %%

tf = 50; %Simulation Run-time

%% ----------------- [Testbed Parameters]  ----------------- %%


h1 = 0.005;      % flywheel angular momentum 1 [kg*m^2/s]
h2 = 0.005;      % flywheel angular momentum 2 [kg*m^2/s]
Iy =  0.02;      % moment of inertia about the y-axis
total_h = - (h1 + h2)/Iy;

% Gimbal Angles
gamma1_min = deg2rad(-90); % lower bound
gamma1_max = deg2rad(90); % upper bound
gamma1_initial = deg2rad(0); % initial condition for outer gimbal

gamma2_min = deg2rad(-90); % lower bound
gamma2_max = deg2rad(90); % upper bound
gamma2_initial = deg2rad(0); % initial condition for inner gimbal

%% -----------------  [LQR Weight Matrix]  ----------------- %%

% State Weight Matrix
Q = [50,0;
    0,5];

% Actuator Weight Matrix
R = [10,0;
    0,10];

%% -------  [Defining LPV Parameters & State-Space]  ------- %%

fh = @(t,p) cmg(t,p,total_h,gamma1_min,gamma1_max,gamma2_min,gamma2_max,Iy);
G = lpvss(["p1","p2"],fh);

p1 = linspace(gamma1_min,gamma1_max,10); % setting intervals for LPV model
p2 = linspace(gamma2_min,gamma2_max,10); % setting intervals for LPV model

[p1_grid,p2_grid] = ndgrid(p1,p2);

ICs = sample(G,[],p1_grid,p2_grid);

%% -------------  [LPV State-Space Equation]  ------------- %%

function [A,B,C,D,E,dx0,x0,u0,y0,Delays] = cmg(t,p,AM,gamma1_min,gamma1_max,gamma2_min,gamma2_max,Iy)

    p(1) = max(gamma1_min,min(p(1),gamma1_max));
    p(2) = max(gamma2_min,min(p(2),gamma2_max));

    A = [0 1 ; 0 0/Iy];
    B = [0 0 ; AM*sin(p(2)) AM*cos(p(2))];
    C = [1 0 ; 0 1];
    D = [0 0; 0 0];
    E = [];

    % no offsets or delays
    dx0 = []; x0 = []; u0 = []; y0 = []; Delays = [];

end

%% ----------  [Defining Controller LQR Gains]  ---------- %%

length(ICs);
for i = 1:length(ICs)
for l = 1:length(ICs)
K_gains{i,l} = lqr(ICs(:,:,i,l),Q,R);
K1(i,l) = K_gains{i,l}(1,1);
K2(i,l) = K_gains{i,l}(1,2);
K3(i,l) = K_gains{i,l}(2,1);
K4(i,l) = K_gains{i,l}(2,2);
end
end

%% --------------------  [Simulink]  -------------------- %%
% Note: Comment out function to remove preferred simulations

CMG_Testbed_Attitude_Openloop();

CMG_Testbed_Attitude_Closedloop();

CMG_Testbed_Attitude_ClosedloopTracking();