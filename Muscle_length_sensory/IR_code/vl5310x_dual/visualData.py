import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from readData import Data


class plottingRoutine(Data):
    """
    This class does all kind of plotting depending on the method
    """

    # TODO: consider using bokeh for plotting

    def __init__(self, pathtoFile, showPlots=False):
        """
        initialize input data. Expect a 3D array
        :param data:
        """
        print('-> Create plotting routine object.')
        super().__init__(pathToFile=pathtoFile)
        self.data = super().readData2Array()
        self.keys = super().returnKeys()
        self.showPlots = showPlots
        # define sampling period to make time array
        self.tPeriod = 0.093
        # get number of files
        self.z_len = len(self.data[0, 0, :])

    def plotTimeSeries(self, showPlots=False):
        """
        method to plot time series, input is time array
        :return:
        """
        print('>> Plot time series.')
        # create control array for for-loop
        controlArr = np.arange(self.z_len)
        for counter in controlArr:
            time = np.linspace(0, self.tPeriod * len(self.data[:, 0, 0]), len(self.data[:, 0, 0]))
            fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(12, 5))
            axes.plot(time, self.data[:, 0, counter])
            axes.plot(time, self.data[:, 1, counter])
            axes.set_ylabel("Distance(mm)")
            axes.set_xlabel("Time (s)")
            axes.set_title(str(self.keys[counter]) + ' Plot')
        if showPlots:
            plt.show()

    def plotDiff(self, showPlots=False):
        """
        method to plot delta of the 2 sensors, input is time array
        :return:
        """
        print('>> Plot delta between sensors.')
        # create control array for for-loop
        controlArr = np.arange(self.z_len)
        for counter in controlArr:
            time = np.linspace(0, self.tPeriod * len(self.data[:, 0, 0]), len(self.data[:, 0, 0]))
            fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(12, 5))
            axes.plot(time, self.data[:, 0, counter] - self.data[:, 1, counter])
            axes.set_ylabel("Delta (mm)")
            axes.set_xlabel("Time (s)")
            axes.set_title(str(self.keys[counter]) + ' Plot')
        if showPlots:
            plt.show()

    def showAllPlots(self):
        """
        Command to show all plots.
        :return:
        """
        plt.show()
