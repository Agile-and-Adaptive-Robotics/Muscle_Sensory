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
fitOrder = makePlots.plotFit(fitOrder=2, fitSet=(4, 5, 6), showPlots=True)
# print(fitOrder)
# makePlots.showAllPlots()

