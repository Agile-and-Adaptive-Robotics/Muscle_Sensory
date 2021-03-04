import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


class plottingRoutine(object):
    """
    This class does all kind of plotting depending on the method
    """

    def __init__(self, data):
        """
        initialize input data. Expect a 3D array
        :param data:
        """
        assert isinstance(data, np.ndarray), '>> Data must be numpy 3D array'
        assert len(data.shape) == 3, '>> Input data must be 3D'
        print('-> Create plotting routine object.')
        self.data = data

    def plotSeries(self, t_array):
        """
        method to plot time series, input is time array
        :return:
        """
        pass
