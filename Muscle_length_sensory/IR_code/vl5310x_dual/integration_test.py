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
        'R7 some static': 'rawData9_static.txt'}

# instantiate the data
data = readData.Data(path)
# put the data into a 3D array
rawArr = data.readData2Array()
keys = data.returnKeys()
makePlots = visualData.plottingRoutine(path)
# makePlots.plotTimeSeries(specificPlots=(5, 6))
# makePlots.plotDiff(showPlots=False, specificPlots=(5, 6))
# makePlots.plotSeriesLadder(specificPlots=(4, 5, 6))
fitOrder, xfit, yfit = makePlots.plotFit(fitOrder=4, fitSet=2, showPlots=False)
# make simple plot
ylabel = 'Y'
xlabel = 'X'
title = 'Title'
makePlots.plotSimpleScatter(x=rawArr[:, 0, 1], y=rawArr[:, 1, 1], xlabel=xlabel,
                            ylabel=ylabel, title=title, showPlots=False)
# test overplot function
makePlots.o_plot(x=rawArr[:, 0, 5], y=rawArr[:, 1, 5], showPlots=False)
makePlots.o_plot(x=rawArr[:, 0, 6], y=rawArr[:, 1, 6], showPlots=False)
makePlots.o_plot(x=xfit, y=yfit, LinePlot=True)
# print(fitOrder)
makePlots.showAllPlots()
print(fitOrder)
