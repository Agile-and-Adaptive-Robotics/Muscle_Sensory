import visualData
import readData
import numpy as np
from pathlib import Path

# test integration of the classes
path = {'R1 dynamic BPA': 'rawData3.txt',
        'R2 dynamic BPA': 'rawData4.txt',
        'R3 dynamic BPA': 'rawData5.txt',
        'R4 dynamic BPA': 'rawData6.txt',
        'R5 static': 'rawData7_static.txt',
        'R6 some static': 'rawData8_static.txt',
        'R7 some static': 'rawData9_static.txt',
        'R8 2 sensors dynamic': 'rawData10_2Sensors_dynamic.txt'}
# instantiate the data
data = readData.Data(path)
# put the data into a 3D array
rawArr = data.readData2Array()
keys = data.returnKeys()
# instantiate plotting routine
makePlots = visualData.plottingRoutine(path)
# plot time series of all plots
makePlots.plotSeriesLadder()  # generate all time series plots
# create fit for dynamic data and static data
# dynamic data index 0
coefficients_dyn, x_new_dyn, y_new_dyn = makePlots.plotFit(fitOrder=4, fitSet=0, showPlots=False)
# static data index 5 and 6
coefficients_sta, x_new_sta, y_new_sta = makePlots.plotFit(fitOrder=1, fitSet=7, showPlots=False)

# plot scatter static data
title = 'Data of 2 sensors in same environment'
ylabel = 'Distance Sensor 1 (mm)'
xlabel = 'Distance Sensor 2 (mm)'
makePlots.plotSimpleScatter(x=rawArr[:, 0, 5], y=rawArr[:, 1, 5],
                            ylabel=ylabel, xlabel=xlabel, title=title)
# overlap scatter of different static data set
makePlots.o_plot(x=rawArr[:, 0, 6], y=rawArr[:, 1, 6])
# overlap scatter of fitted data
makePlots.o_plot(x=x_new_sta, y=y_new_sta, LinePlot=True)
# overlap scatter of different data set
makePlots.o_plot(x=rawArr[:, 0, 7], y=rawArr[:, 1, 7])
# overlap scatter of different data set
makePlots.o_plot(x=rawArr[:, 0, 4], y=rawArr[:, 1, 4])

# plot scatter dynamic data
title = 'Dynamic data of External sensor and BPA sensor'
makePlots.plotSimpleScatter(x=rawArr[:, 0, 2], y=rawArr[:, 1, 2],
                            ylabel=ylabel, xlabel=xlabel, title=title)
# overlap scatter of different static data set
makePlots.o_plot(x=rawArr[:, 0, 3], y=rawArr[:, 1, 3])
# overlap scatter of fitted data
makePlots.o_plot(x=x_new_dyn, y=y_new_dyn, LinePlot=True)

# show all plots
makePlots.showAllPlots()
