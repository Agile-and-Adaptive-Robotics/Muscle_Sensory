This README File provides an outline of the folder structure, file descriptions, and data outline for the folder '18-05-2026 Literature Comparison and analysis/2026-07-16 Test Data. The structure of this README is broken down into folder -> subfolder -> file -> file contents. 

Folder: 2026-07-17 
	Description: Early Test cases as part of the debugging process
	Contents: .txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length (conversion may not be correct in this version)

Folder: 2026-07-21 
	Description: Early Test cases as part of the debugging process
	Contents: .txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length (conversion may not be correct in this version)

Folder: 2026-07-22 
	Description: Early Test cases as part of the debugging process
	Contents: .txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length (conversion may not be correct in this version)


Folder: 2026-07-28 
	Description: Early Test cases as part of the debugging process
	Contents: .txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length (conversion may not be correct in this version)

Folder: 2026-08-03 
	Description: Early Test cases as part of the debugging process
	Contents: .txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length (conversion may not be correct in this version)


Folder: 2026-08-04 
	Description: Main publication data and processing. 
	Contents:.txt files. files are named in S00XP00X format where S represents measurement series and P represents measurement point. 
			File Contents: MS = Measurement Series, MPT = Measurement point, t (s) = time elapsed since experiment began in milliseconds, Pressure (Psi) = Internal muscle pressure, LW RAW = the raw bit reading of the Liquid wire sensor pin, Displacement RAW = the raw bit reading of the linear potentiometer sensor pin, Length (mm) = the converted sensor value to mm length/displacement from 0 position. 25mm = relaxed muscled. 

		.csv files. files are named in the same format as .txt and correspond to the processed data. 
			File Contents: as in .txt. Additional columns: t_rel(s) = time adjusted to start from 0 in seconds, LW RAW (V) = Liquid wire sensor pin output converted to volts, Length filtered (mm) = muscle displacement from 0 position in mm post filtering, Velocity (mm/s) = muscle velocity calculated using central difference method, LW Filtered (V) = liquid wire sensor voltage post filtering, dv/dt (V/s) = rate of change of liquid wire sensor voltage, Type Ia Firing Rate = Type Ia Firing Rate calculated as per the Prochazka model, FR_Cascaded_Predicted = Type Ia Firing rate as predicted by the cascaded laplace model, FR_Calibrated_Predicted = Type Ia Firing rate as predicted by the cascaded laplace model with adjustments to mean voltage point, FR_Optimized_Predicted = Type Ia Firing rate as predicted by the cascaded laplace model with a scaled dynamic velocity term, FR_FullOptimized_Predicted = Type Ia Firing rate as predicted by the cascaded laplace model with removed edge effects and fully optimized parameters. 

		.png files. files are named in the same format as .txt and correspond to the relevant plotted data. 
			File Contents: 5 row figure. 1 = filtered displacement, 2 = filtered velocity, 3 = firing rate as predicted by global and split models, 4 = liquid wire voltage, 5 = liquid wire rate of change of voltage. 

		7 x plots folders (various): output of specific model optimization parameters for all data runs at various stages of the debugging process. 

Folder: Compact_Plots
	Description: Folder containing data summary plots of each test run. As before, files are named in S00XP00X format where S represents measurement series and P represents measurement point.
	Contents: 3 row figure: 1 = filtered displacement and liquid wire voltage, 2 = filtered velocity and liquid wire rate of change of voltage, 3 = firing rate as predicted by global and split models

Folder: Figures
	Description: Folder containing various outputted iterations of figures for publication
	Contents: Velocity distribution plot, scatter plots of voltage and length with overlaid models in image and vector format, sensor drift and gridded plots for publication. 

Folder: LenV_Plots
	Description: Folder containing plots of each test run for displacement and voltage. As before, files are named in S00XP00X format where S represents measurement series and P represents measurement point.
	Contents: 110 plots of displacement and voltage profiles for test cases. Displacement measured using the linear potentiometer, voltage the liquid wire sensor. 

Folder: Literature Data
	Description: Folder containing digitized plot data from literature and a processing script. 
	Contents: Excel spreadsheets named Prochazka ________ with the blank corresponding to velocity profiles from the paper 'Models of ensemble firing of muscle spindle afferents recorded  during normal locomotion in cats'. File titles describe which plot. 
		  Jupyter source file for plotting the digitized data.  

Folder: Misc. Data
	Description: Old data sets 
	Contents: .txt files 

Folder: Optimized_Peak_Windows
	Description: Plots comparing the firing rate fit of the laplace model at the peak velocity of each test case. 
	Contents: PNG files. As before, files are named in S00XP00X format where S represents measurement series and P represents measurement point.

Folder: Peaks_High_gt80
	Description: Copies of the plots from 'Compact plots' but sorted into high velocity profiles with the maximum velocity in the filename. 
	Contents: PNG Files

Folder: Peaks_Low_lt55
	Description: Copies of the plots from 'Compact plots' but sorted into low velocity profiles with the maximum velocity in the filename. 
	Contents: PNG Files

Folder: Peaks_mid_55_to_80
	Description: Copies of the plots from 'Compact plots' but sorted into medium velocity profiles with the maximum velocity in the filename. 
	Contents: PNG Files

Data Processing
	Description: Jupyter Source file containing all code to process the data and generate the plots in the various folders. 



  


				






