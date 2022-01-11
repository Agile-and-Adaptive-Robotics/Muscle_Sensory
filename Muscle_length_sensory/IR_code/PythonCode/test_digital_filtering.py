from read_IR_data import DataHandler
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np
from scipy import stats


class DataFiltering(DataHandler):
    def __init__(self, filepath):
        super().__init__(filepath)

    def plot_psd(self, idx, save=False):
        """plot the power spectrum density of each data segment"""
        if not isinstance(idx, list):
            print("Input a list, even list of one element")

        fig, axs = plt.subplots(2, 1, sharex='all')

        for each in idx:
            self.read_header_data(each)
            data_segment = self._str2array(idx=each)
            time = data_segment[:, 0]
            sen1 = data_segment[:, 1]
            sen2 = data_segment[:, 2]
            for sensor_idx, each_sensor in enumerate([sen1, sen2]):
                sampF = float(self.header['Sampling Frequency'])  # Hz
                dt = 1 / sampF
                n = len(time)
                fhat = np.fft.fft(each_sensor, n)
                PSD = fhat * np.conj(fhat) / n
                freq = (1 / (dt * n)) * np.arange(n)
                L = np.arange(1, np.floor(n / 2), dtype='int')
                axs[sensor_idx].plot(freq[L], PSD[L], color='b')
                axs[sensor_idx].set_ylabel(f'Sensor {sensor_idx}')
                plt.xlim(freq[L[0]], freq[L[-1]])
                plt.xscale('log')

            axs[0].set_title(f'PSD external sensor vs. internal sensor Data ID {each}')
            axs[1].set_xlabel('Frequency (Hz)')
            if save:
                title = f'PSD Data ID {each}'
                plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500, bbox_inches='tight')
            for each_ax in axs:
                each_ax.clear()

    def butterworth_filter(self, idx):
        """Test digital butterworth filter. Return the filtered sen1 and sen2
        http://www.schwietering.com/jayduino/filtuino/index.php?characteristic=bu&passmode=lp&order=2&usesr=usesr&sr=100&frequencyLow=2&noteLow=&noteHigh=&pw=pw&calctype=float&run=Send"""
        data_segment = self._str2array(idx=idx)
        time = data_segment[:, 0]
        sen1 = data_segment[:, 1]
        sen2 = data_segment[:, 2]

        # preallocate array for faster processing
        ft_sen1 = np.zeros_like(sen1)
        ft_sen2 = np.zeros_like(sen2)

        # apply filter
        # 1Hz 2nd order Butterworth
        # coff = [9.446918438401618072e-4, -0.91497583480143362955, 1.91119706742607298189]
        # 2Hz 2nd order Butterworth
        coff = [3.621681514928615665e-3, -0.83718165125602272969, 1.82269492519630826877]
        v1 = 0
        v2 = 0
        # sensor 1
        for i in range(len(sen1)):
            if i == len(sen1) - 1:
                break
            v0 = v1
            v1 = v2
            v2 = (coff[0] * sen1[i]) + (coff[1] * v0) + (coff[2] * v1)
            ft_sen1[i] = v0 + v2 + 2 * v1
        # sensor 2
        v1 = 0
        v2 = 0
        for i in range(len(sen2)):
            if i == len(sen2) - 1:
                break
            v0 = v1
            v1 = v2
            v2 = (coff[0] * sen2[i]) + (coff[1] * v0) + (coff[2] * v1)
            ft_sen2[i] = v0 + v2 + 2 * v1

        return ft_sen1, ft_sen2

    def plot_butterworth_filter(self, idx, save=False):
        """plot the filtered data from bitterworth_filter method"""
        if not isinstance(idx, list):
            print("Input a list, even list of one element")

        fig, axs = plt.subplots(2, 1, sharex='all')

        for each in idx:
            self.read_header_data(each)
            sampF = float(self.header['Sampling Frequency'])
            data_segment = self._str2array(idx=each)
            time = data_segment[:, 0]/sampF
            sen1 = data_segment[:, 1]
            sen2 = data_segment[:, 2]
            # calculate filtered data
            ft_s1, ft_s2 = self.butterworth_filter(each)
            # plot filter data
            axs[0].plot(time, sen1, time, ft_s1)
            axs[1].plot(time, sen2, time, ft_s2)

            axs[0].set_title(f'Filtered data Data ID {each}')
            axs[1].set_xlabel('Time')
            if save:
                title = f'Filtered Data ID {each}'
                plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500, bbox_inches='tight')
            plt.show()
            for each_ax in axs:
                each_ax.clear()

    def plot_psd_filtered_data(self, idx, save=False):
        """plot psd of the filtered data"""
        if not isinstance(idx, list):
            print("Input a list, even list of one element")

        fig, axs = plt.subplots(4, 1, sharex='all')

        for each in idx:
            self.read_header_data(each)
            data_segment = self._str2array(idx=each)
            # get data segment
            time = data_segment[:, 0]
            sen1 = data_segment[:, 1]
            sen2 = data_segment[:, 2]

            # apply filter to data
            ft_s1, ft_s2 = self.butterworth_filter(each)

            for each_id, each_sensor in enumerate([sen1, ft_s1, sen2, ft_s2]):
                sampF = float(self.header['Sampling Frequency'])  # Hz
                dt = 1 / sampF
                n = len(time)
                fhat = np.fft.fft(each_sensor, n)
                PSD = fhat * np.conj(fhat) / n
                freq = (1 / (dt * n)) * np.arange(n)
                L = np.arange(1, np.floor(n / 2), dtype='int')
                axs[each_id].plot(freq[L], PSD[L], color='b')
                # axs[each_id].set_ylabel(f'Sensor {each_id}')
                plt.xlim(freq[L[0]], freq[L[-1]])
                plt.xscale('log')

            axs[0].set_title(f'PSD external sensor and internal sensor with filtered data Data ID {each}')
            axs[3].set_xlabel('Frequency (Hz)')
            if save:
                title = f'PSD Filtered Data ID {each}'
                plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500, bbox_inches='tight')
            for each_ax in axs:
                each_ax.clear()

    def scatter_plot_filter_data(self, idx, save=False):
        if not isinstance(idx, list):
            print("Input a list, even list of one element")

        fig, ax = plt.subplots(1, 1, sharex='all')

        for each in idx:
            # calculate filtered data
            ft_s1, ft_s2 = self.butterworth_filter(each)
            # discard the first few data points and last data point
            ft_s1[0:300] = np.nan
            ft_s1[-1] = np.nan
            ft_s2[0:300] = np.nan
            ft_s2[-1] = np.nan
            # plot filter data
            ax.plot(ft_s2, ft_s1, '.b', markersize=2)

            ax.set_title(f'Scatter plot data Data ID {each}')
            ax.set_xlabel('Sensor 2')
            ax.set_ylabel('Sensor 1')
            if save:
                title = f'Scatter plot Filtered Data ID {each}'
                plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500, bbox_inches='tight')
            ax.clear()

    @staticmethod
    def _calculate_lin_fit(x=None, y=None, showPlot=False):
        """helper function to calculate linear fit equation
        return scipy fit parameters
        scipy_fit_params.slope for slope
        scipy_fit_params.intercept for intercept"""
        if y is None or x is None:
            assert Exception('Need x and y data arrays')
        if len(y) != len(x):
            assert Exception(f'y and x arrays must be the same length, not {len(x)} and {len(y)}')

        scipy_fit_params = stats.linregress(x, y)
        if showPlot:
            fig, ax = plt.subplots(1, 1)
            ax.plot(x, y, '.b',markersize=2)
            y_fit = scipy_fit_params.slope*x + scipy_fit_params.intercept
            ax.plot(x, y_fit, '-r', markersize=0)
            plt.show()
        return scipy_fit_params

    @staticmethod
    def _calculate_poly_fit(x=None, y=None, showPlot=False):
        """helper function to calculate second order fit equation
        return scipy fit parameters
        scipy_fit_params.slope for slope
        scipy_fit_params.intercept for intercept"""
        if y is None or x is None:
            assert Exception('Need x and y data arrays')
        if len(y) != len(x):
            assert Exception(f'y and x arrays must be the same length, not {len(x)} and {len(y)}')

        np_fit_param = np.polyfit(x, y, deg=2, full=True)
        if showPlot:
            fig, ax = plt.subplots(1, 1)
            ax.plot(x, y, '.b', markersize=2)
            y_fit = np_fit_param[0][0]*x**2 + np_fit_param[0][1]*x + np_fit_param[0][2]
            ax.plot(x, y_fit, '-r', markersize=0)
            plt.show()
        return np_fit_param

    def clean_up_filtered_then_lin_fit(self, idx):
        """
        clean up a filtered data set then calculate fit
        :param idx: single index of the data set
        :return:
        """
        # this clean up parameter is hard coded unfortunately
        # index 0 to 300 data is removed
        ft_s1, ft_s2 = self.butterworth_filter(idx)
        ft_s1 = np.delete(ft_s1, np.arange(0, 299, 1))
        ft_s1 = np.delete(ft_s1, [-1])
        ft_s2 = np.delete(ft_s2, np.arange(0, 299, 1))
        ft_s2 = np.delete(ft_s2, [-1])
        fit_param = self._calculate_lin_fit(ft_s2, ft_s1, showPlot=True)
        return fit_param

    def clean_up_filtered_then_poly_fit(self, idx):
        """
        clean up a filtered data set then calculate 2nd order fit
        :param idx: single index of the data set
        :return:
        """
        # this clean up parameter is hard coded unfortunately
        # index 0 to 300 data is removed
        ft_s1, ft_s2 = self.butterworth_filter(idx)
        ft_s1 = np.delete(ft_s1, np.arange(0, 299, 1))
        ft_s1 = np.delete(ft_s1, [-1])
        ft_s2 = np.delete(ft_s2, np.arange(0, 299, 1))
        ft_s2 = np.delete(ft_s2, [-1])
        poly_fit_param = self._calculate_poly_fit(ft_s2, ft_s1, showPlot=True)
        return poly_fit_param

    def clean_up_multi_filter_then_poly_fit(self):
        ft9_s1, ft9_s2 = self.butterworth_filter(5)
        ft10_s1, ft10_s2 = self.butterworth_filter(6)
        # clean up filtered data
        ft9_s1 = np.delete(ft9_s1, np.arange(0, 299, 1))
        ft9_s1 = np.delete(ft9_s1, [-1])
        ft9_s2 = np.delete(ft9_s2, np.arange(0, 299, 1))
        ft9_s2 = np.delete(ft9_s2, [-1])

        ft10_s1 = np.delete(ft10_s1, np.arange(0, 299, 1))
        ft10_s1 = np.delete(ft10_s1, [-1])
        ft10_s2 = np.delete(ft10_s2, np.arange(0, 299, 1))
        ft10_s2 = np.delete(ft10_s2, [-1])

        # combine data index 9 and 10
        ft_s1 = np.concatenate([ft9_s1, ft10_s1])
        ft_s2 = np.concatenate([ft9_s2, ft10_s2])

        poly_fit_param = self._calculate_poly_fit(ft_s2, ft_s1, showPlot=True)
        return poly_fit_param


RunAll = True
if RunAll and __name__ == "__main__":
    path = "D:\\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\PythonCode\IR_data4.txt"
    filtering = DataFiltering(filepath=path)
    idx_list = [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12]
    # filtering.plot_psd(idx_list, save=True)

    # filtering.plot_butterworth_filter(idx_list, save=False)
    # filtering.plot_psd_filtered_data(idx_list, save=False)
    # filtering.scatter_plot_filter_data(idx_list, save=False)

    fit_param = filtering.clean_up_multi_filter_then_poly_fit()
    print(f'Poly fit parameters: {fit_param}')
