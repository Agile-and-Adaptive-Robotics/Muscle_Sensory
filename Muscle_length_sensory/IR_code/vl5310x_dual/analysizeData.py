import numpy as np
import pandas as pd
from readData import Data


class analyzeData(Data):
    """
    This class analyzes data
    """

    def __init__(self, pathToFile):
        if pathToFile is None:
            Exception('Need to give path to files')
        super().__init__(pathToFile=pathToFile)
        self.data = super().readData2Array()
        self.keys = super().returnKeys()
        # get number of files
        self.z_len = len(self.data[0, 0, :])

    def defineFit(self, fitOrder=3, fitSet=None):
        """
        Calculate the poly fit params with default fit order = 3
        Fitset defines the array that fit would use to calculate.
        Fitset can be multiple arrays where the data can be pooled together to make fit params
        :param fitOrder, fitSet:
        :return:
        """
        if fitSet is None:
            Exception('Please define which data set to fit')
        assert isinstance(fitSet, tuple), 'Fit set index must be a tuple'
        # Create the raw data array where the fit params can be constructed
        x2fit = self.data[:, 0, fitSet[-1]]  # create x array to perform fit
        y2fit = self.data[:, 1, fitSet[-1]]  # create y array to perform fit
        if len(fitSet) != 1:
            for each in fitSet[0:-1]:
                x2fit = np.append(x2fit, self.data[:, 0, each])
                y2fit = np.append(y2fit, self.data[:, 1, each])

        coefficient = np.polyfit(x2fit, y2fit, fitOrder)
        return coefficient
