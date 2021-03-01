import numpy as np
import pathlib as Path
import pandas as pd


class readData(object):
    """
    This class reads the text dat and output the data array 
    """

    def __init__(self, pathToFile):
        assert isinstance(pathToFile, str), 'Path must be string'
        self._pathToFile = pathToFile

    def parseData(self):
        raw1_pd = pd.read_csv(self._pathToFile, delimiter="\t", header=None)
        return raw1_pd

    def 

# run code condition
RunAll = True

if RunAll and __name__ == "__main__":
    # define path
    path = "rawData3.txt"

    # instantiate and read data
    data1 = readData(path)
    raw_data1 = data1.parseData()
