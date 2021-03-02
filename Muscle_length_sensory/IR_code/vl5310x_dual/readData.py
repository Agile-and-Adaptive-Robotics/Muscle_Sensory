import numpy as np
import pathlib as Path
import pandas as pd


class readData(object):
    """
    This class reads the text dat and output the data array 
    """

    def __init__(self, pathToFile):
        print(f'<- Create readData object')
        assert isinstance(pathToFile, dict), 'Path must be a list of directories'
        self._pathToFile = pathToFile
        self._listOfArrays = self._parseData()

    def _parseDataSingle(self, singlePath):
        raw1_pd = pd.read_csv(singlePath, delimiter="\t", header=None)
        return raw1_pd

    def _parseData(self):
        """
        Output a list structure that contains the parsed data.
        :return:
        """
        self._listOfArrays = []
        counter = 0
        for fileName, eachFile in self._pathToFile.items():
            self._listOfArrays.append(self._parseDataSingle(eachFile))
            counter += 1
        return self._listOfArrays

    def readData2Array(self):
        """
        Output 3D array from the input paths.
        This is done by allocating an 3D array first then fill in the values with NaN
        :return:
        """
        counter = 0
        maxLen = 0
        maxLenIdx = 0
        # create an array with the length of each array in list
        # sizeArr = np.zeros(len(self._listOfArrays))
        for item in self._listOfArrays:
            sizeEle = len(item)
            if sizeEle > maxLen:
                maxLen = sizeEle
                maxLenIdx = counter
            counter += 1
        # get size of the largest array
        buf = np.asarray(self._listOfArrays[maxLenIdx])
        # allocate a 3D array based on the size of the largest array
        arraySize = buf.shape + (len(self._listOfArrays),)
        array3D = np.zeros(arraySize)
        array3D[:, :, :] = -999
        # reset counter for another loop
        counter = 0
        counter1 = 0  # counter variable
        counter2 = 0  # counter variable
        for item in self._listOfArrays:
            buf = np.asarray(item)
            print(buf.shape)
            print(buf[:, 0])
            for i in buf[:, counter2]:
                for j in buf[counter1, :]:
                    array3D[counter1, counter2, counter] = buf[counter1, counter2]
                    counter2 += 1
                counter2 = 0  # reset counter 2
                counter1 += 1
            counter1 = 0  # reset counter 1
            counter += 1
        return array3D


# run code condition
RunAll = True
# TODO: clean up print statements

if RunAll and __name__ == "__main__":
    # define path
    path = {'raw 1': 'rawData3.txt',
            'raw 2': 'rawData4.txt',
            'raw 3': 'rawData5.txt',
            'raw 4': 'rawData6.txt'}

    # instantiate and read data
    data = readData(path)
    raw = data.readData2Array()
    print(raw)
