  
  [MATLAB & Simulink Simulation for Double Gimbal Control Moment Gyroscope]
			    [Spacecraft Edition]

-----------------------------------------------------------------------------

By: Jason Nguyen
Team: An Ngo, Khyati Mahajan
Advisor: Professor Yawo Ezunkpe
San Jose State University

---------------------------[Executing MATLAB code]---------------------------

[1] Open "CMG_Spacecraft_Attitude_Control.m"

[2] Adjust "spacecraft parameters" to desired values

[3] On "CMG_Spacecraft_Attitude_Control.m" , lines 178 - 182 can be commented
    out to run preferred simulation.

     -> "CMG_Spacecraft_Attitude_Control_Openloop();"
	executes an open loop simulation. Default settings are set with no 
	gimbal actuation to analyze the stability of spacecraft.

     -> "CMG_Spacecraft_Attitude_Control_LQR();"
	executes a simulation for regulating stability using LQR. 
	Default settings have initial conditions set within the LPV model. 
	Adjust freely.

     -> "CMG_Spacecraft_Attitude_Control_LQRTracking();"
	executes a simulation for improved LQR for tracking. Default settings
	are set for 20 degrees tracking for a finite amount of time.

[5] Adjustments the simulation time can be individually adjusted in each 
    subscript .m file. Individual times where given as each simulation
    may need to ran longer to see the overall response.

[6] Run "CMG_Spacecraft_Attitude_Control.m" to obtain results


---------------------------[MATLAB code]---------------------------

[MAIN SCRIPT] CMG_Spacecraft_Attitude_Control.m

*Holds all parameters and calls upon all subscript to run simulations*

[Subscripts] CMG_Spacecraft_Attitude_Control_Openloop.m
[Subscripts] CMG_Spacecraft_Attitude_Control_LQR.m
[Subscripts] CMG_Spacecraft_Attitude_Control_LQRTracking.m

*Subscript are called upon and runs simulation model for each simulation*

[Simulink] LPVattitudeLQR.slx
[Simulink] LPVattitudeLQRTracking.slx
[Simulink] LPVattitudeOpenLoop.slx

*Runs the simulation in Simulink*
