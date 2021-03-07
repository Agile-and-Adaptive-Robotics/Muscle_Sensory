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
        :param fitOrder: order of the poly fit
        :param fitSet: which data set to do the fit
        :return:
        """
        if fitSet is None:
            Exception('Please define which data set to fit')
        if isinstance(fitSet, tuple):
            idx_x = np.isfinite(self.data[:, 0, fitSet[-1]])
            idx_y = np.isfinite(self.data[:, 1, fitSet[-1]])
            x2fit = self.data[idx_x, 0, fitSet[-1]]  # create x array to perform fit
            y2fit = self.data[idx_y, 1, fitSet[-1]]  # create y array to perform fit
            for each in fitSet[0:-1]:
                idx_x = np.isfinite(self.data[:, 0, each])
                idx_y = np.isfinite(self.data[:, 1, each])
                x2fit = np.append(x2fit, self.data[idx_x, 0, each])
                y2fit = np.append(y2fit, self.data[idx_y, 1, each])
        elif isinstance(fitSet, int):
            # polyfit cannot handle NaN values so need to filter them out.
            idx_x = np.isfinite(self.data[:, 0, fitSet])
            idx_y = np.isfinite(self.data[:, 1, fitSet])
            x2fit = self.data[idx_x, 0, fitSet]  # create x array to perform fit
            y2fit = self.data[idx_y, 1, fitSet]  # create y array to perform fit
        else:
            Exception('Fit set must be a tuple or int')
            return
        coefficient = np.polyfit(x2fit, y2fit, fitOrder)
        return coefficient, x2fit, y2fit
