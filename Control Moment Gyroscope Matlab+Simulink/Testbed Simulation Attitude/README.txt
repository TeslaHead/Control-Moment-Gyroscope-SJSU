  
  [MATLAB & Simulink Simulation for Double Gimbal Control Moment Gyroscope]
			      [Testbed Edition]

-----------------------------------------------------------------------------

By: Jason Nguyen
Team: An Ngo, Khyati Mahajan
Advisor: Professor Yawo Ezunkpe
San Jose State University

---------------------------[Executing MATLAB code]---------------------------

[1] Open "CMG_Testbed_Attitude_Control.m"

[2] Adjust "testbed parameters" to desired values

[3] On "CMG_Testbed_Attitude_Control.m" , lines 81 - 85 can be commented
    out to run preferred simulation.

     -> "CMG_Testbed_Attitude_Openloop();"
	executes an open loop simulation.

     -> "CMG_Testbed_Attitude_Closedloop();"
	executes a simulation for regulating stability using LQR. 
	Default settings have initial conditions set within the LPV model. 
	Adjust freely.

     -> "CMG_Testbed_Attitude_ClosedloopTracking();"
	executes a simulation for improved LQR for tracking. Default settings
	are set for 20 degrees tracking.

[5] Adjustments the simulation time.

[6] Run "CMG_Testbed_Attitude_Control.m" to obtain results


---------------------------[MATLAB code]---------------------------

[MAIN SCRIPT] CMG_Testbed_Attitude_Control.m

*Holds all parameters and calls upon all subscript to run simulations*

[Subscripts] CMG_Testbed_Attitude_Openloop.m
[Subscripts] CMG_Testbed_Attitude_Closedloop.m
[Subscripts] CMG_Testbed_Attitude_ClosedloopTracking.m

*Subscript are called upon and runs simulation model for each simulation*

[Simulink] LPVattitudeLQR.slx
[Simulink] LPVattitudeLQRTracking.slx
[Simulink] LPVattitudeOpenLoop.slx

*Runs the simulation in Simulink*
