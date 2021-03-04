import visualData
import readData
import numpy as np


# test integration of the classes
path = {'raw 1': 'rawData3.txt',
            'raw 2': 'rawData4.txt',
            'raw 3': 'rawData5.txt',
            'raw 4': 'rawData6.txt',
            'raw 5 static:': 'rawData7_static.txt',
            'raw 6 static:': 'rawData8_static.txt',
            'raw 7 static:': 'rawData9_static.txt'}

# instantiate the data
data = readData.Data(path)
# put the data into a 3D array
rawArr = data.readData2Array()
makePlots = visualData.plottingRoutine(rawArr)
