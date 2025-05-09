  
  [MATLAB & Simulink Simulation for Double Gimbal Control Moment Gyroscope]
			    [Testbed HARDWARE Edition]

-----------------------------------------------------------------------------

By: Jason Nguyen
Team: An Ngo, Khyati Mahajan
Advisor: Professor Yawo Ezunkpe
San Jose State University

---------------------------[Executing MATLAB code]---------------------------

[1] Open "CMG_Statespace.m"

[2] Adjust "testbed parameters" to desired values

[3] Run "CMG_Statespace.m" to obtain results

[4] Open "CMG_Testbed.slx"

[5] Connect LIPO battery with testbed device, wait for ESC to turn on

[6] Connect testbed device with a USB-C, run "Run with IO", wait for
    ESCs to confirm they are armed through buzzing.

[6] To start the device, press "Initialize" on the Simulink model
    and let device bootup and calibrate.

[7] Once bootup is complete, use "user-input signal" to set a desired
    angle. Let the device run after inputting signal.

[8] To turn off device, press "initialize" and stop Simulink model.

---------------------------[MATLAB code]---------------------------

[MAIN SCRIPT] CMG_Statespace.m

[Simulink] CMG_Testbed.slx
[Simulink] DevelopmentESP32_Centering.slx
