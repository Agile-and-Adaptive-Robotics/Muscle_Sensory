This README File provides an outline of the folder structure and file descriptions for the folder 'Muscle_length_sensory'. The structure of this README is broken down into folder -> subfolder -> file -> file contents where appropriate.

Folder: 18-03-2026 Length Characterisation (old)
	Description: Old length characterization testing data. Contains three sub folders corresponding to testing on the respective dates in the folder name. Each folder contains Metadata, Raw data text files, processed csv files, processing python code, and some plots. The goal of this work was to characterize the sensor and muscle response when applying increasing/decreasing PWM signals to the proportional valves to inflate or deflate the muscle. This data was not used in the present publication.  
	Contents: Three Subfolders containing Metadata, Raw data text files, processed csv files, processing python code, and some plots.

	SubFolder: 18-03-2026 Length Characterisation
		Description: The goal of this work was to characterize the sensor and muscle response when applying increasing/decreasing PWM signals to the proportional valves to inflate or deflate the muscle. This was the first attempt that this data recoding method. 
		Contents: 18-03-2026 Length Characterisation README explains the contents

	SubFolder: 26-03-2026 Length Characterisation
		Description: The goal of this work was to characterize the sensor and muscle response when applying increasing/decreasing PWM signals to the proportional valves to inflate or deflate the muscle. This was the first attempt that this data recoding method. 
		Contents: 26-03-2026 Length Characterisation README explains the contents

	SubFolder: 31-03-2026 Length Characterisation
		Description: The goal of this work was to characterize the sensor and muscle response when applying increasing/decreasing PWM signals to the proportional valves to inflate or deflate the muscle. This was the first attempt that this data recoding method. 
		Contents: 31-03-2026 Length Characterisation README explains the contents

Folder: 18-05-2026 Literature Comparison and analysis
	Description: All testing data used for publication. The goal of this work was to characterize the Liquid Wire sensor and build representative models for Type Ia afferent firing rate.   
	Contents: Internal README outlines the full contents. 

Folder: 2026 Liquid Wire Test Code
	Description: Folder of Arduino scripts for actuating the BPA and recording data. 
	Contents: 2026_02_03_Liquid_Wire_Data_Sweep.ide: Arduino script that produces the data in folder 18-03-2026 Length Characterisation (old). 
		  2026_03_24_Pulse_testing.ide: Arduino script that produces a pulsed pressure output and collects the data. This did not function very well because the solenoid valves couldn't open fast enough. 
		  2026_03_25_random_actuation.ide: Arduino script to randomly actuate the muscle. This did not function very well because the solenoid valves couldn't open fast enough. 
	Subfolder: 2026_07_08 Twin Boards
		   Description: Folder containing the Arduino.ide test code used for publication. 
		   Contents: 2026_07_09_Data_logging.ide: Script to use one Arduino board as a datalogger to an SD card. 
			     2026_0X_XX_Motion_Profile.ide: Different script versions and methods for creating motion profiles. 
					_07_14: Creating profile from specific data points and using closed loop control. 
					_07_17: Creating profile using distinct intervals of fast and slow operation.
					_07_26: Using some closed loop control to detect when a certain length is reached. 
					_07_28: Integration of limit switches into the control and using solenoid valves. 
					_08_03: Use of limit switches, proportional, and PWM valves. Final script used for testing. 
			     Teensy_analog_read.ide: Script to debug the data reading process and actuating the muscle. 

Folder: Debugging
	Description: Arduino script used for communicating with the board to test the sensor outputs.
	Contents: 2025-12-02_Debugging_Script.ide

Folder: docs
	Description: Contains datasheets for the relevant components
	Contents: ina125.pdf: voltage amplifier used in this experiment
		  Kelly-pneumatics.pdf: proportional valve
		  linear potentiometer.pdf: linear potentiometer
		  max232.pdf: alternative amplifier
		  Pressure Sensor.pdf: Pressure sensor
		  snosc16d.pdf: alternative amplifier
		  trimmer.pdf: voltage trimmer
		  vl5310x.pdf: time of flight range sensor		  

Folder: IR Sensing
	Description: Older work conducted in the lab relating to Infrared sensing of muscle length. Contents are unknown by the present author of this README. 

		