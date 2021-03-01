import numpy as np
import pathlib as Path
import pandas as pd


class readData(object):
    """
    This class reads the text dat and output the data array 
    """

    def __init__(self, pathToFile):
        assert isinstance(pathToFile, dict), 'Path must be a list of directories'
        self._pathToFile = pathToFile

    def _parseDataSingle(self, singlePath):
        raw1_pd = pd.read_csv(singlePath, delimiter="\t", header=None)
        return raw1_pd

    def parseData(self):
        """
        output a dict structure that contains the parsed data
        :return:
        """
        out = []
        counter = 0
        print(self._pathToFile)
        for fileName, eachFile in self._pathToFile.items():
            print(counter, eachFile)
            out.append(self._parseDataSingle(eachFile))
            counter += 1
        return out

# run code condition
RunAll = True

if RunAll and __name__ == "__main__":
    # define path
    path = {'raw 1': 'rawData3.txt',
            'raw 2': 'rawData4.txt',
            'raw 3': 'rawData5.txt'}

    print((path))
    # instantiate and read data
    data1 = readData(path)
    raw_data1 = data1.parseData()

    type(raw_data1)
    print(raw_data1)
