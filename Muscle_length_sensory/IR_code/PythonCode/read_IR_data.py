import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt
from scipy import stats


class DataHandler(object):
    """
    this code parses the data from IR_DATA2.TXT and plot the data
    Provide the absolute path to IR_DATA2.TXT
    This class reads the txt file and index the data set. Each index corresponds to a data set
    General variable explanation:
        a data segment is referring to a segment of data from Start_data to End_data
        idx is referring to the index of each data segment
        start idx is the start index of a data segment of the raw_data array
    """

    def __init__(self, path2file):
        # self._path = Path(path2file)
        self._path = path2file
        self._init_paths()
        self._parse_data()
        self._find_start()
        self._initialize_keys()
        self._index_data_set()  # initialize data_index
        self.data_size = len(self.data_index)

    def _initialize_keys(self):
        """initialize header keys so it can be updated"""
        self.header = {}
        header_keys = self._header_keys()
        for each_key in header_keys:
            self.header[each_key] = ""

    def _init_paths(self):
        self._parent = self._path.parent
        self.wd = self._parent/self._path.stem
        if self.wd.is_dir() is False:
            self.wd.mkdir()

    def _parse_data(self):
        """Parse the data file"""
        f = open(self._path, "r")
        self.raw_data = f.readlines()
        f.close()

    def _find_start(self):
        """Return index of the start of data collection"""
        start_text = '=====Start_data=====\n'  # stupid need this new line character
        self.start_idx = ()
        for idx, each in enumerate(self.raw_data):
            if each == start_text:
                self.start_idx += tuple([idx, ])

    def _find_end(self, start_idx):
        """use the start index to parse and look for the end of segment"""
        end_text = "=====End_data=====\n"
        end_idx = None
        line = None
        while line != end_text:
            line = self.raw_data[start_idx]
            end_idx = start_idx
            start_idx += 1
        return end_idx

    def _index_data_set(self):
        """Indexing the data sets
        Map the index of each data segment to start_idx
        """
        self.data_index = range(0, len(self.start_idx))

    def get_data_segment(self, idx):
        """
        This method returns the data segment using input index including header
        """
        start_idx = self.start_idx[idx]
        end_idx = self._find_end(start_idx)
        return self.raw_data[start_idx:end_idx]

    def __getitem__(self, idx):
        # TODO: getitem should return the 2D numpy array
        return self.get_data_segment(idx)

    def read_header_data(self, index):
        """Read header data and store it in a dict
        The input index is to indicate which data segment"""
        # read the first 5 lines to obtain header data
        data = self.get_data_segment(index)
        header_data = data[1:5]
        header_keys = self._header_keys()
        for each_line in header_data:
            # parse each line and compare it with predefined header keys to get information
            for each_key in header_keys:
                # fine starting index of sub string
                start_idx = each_line.find(each_key)
                if start_idx == -1:
                    continue  # move to the next if cannot find key
                # get end index of sub string
                end_idx = start_idx + len(each_key)
                # get comma index
                comma_idx = each_line.find(',')
                endline_idx = each_line.find('\n')
                if comma_idx > end_idx:
                    key_content = each_line[end_idx:comma_idx]
                    self._update_header_data(each_key, self._get_text_only(key_content))
                else:
                    key_content = each_line[end_idx:endline_idx]
                    self._update_header_data(each_key, self._get_text_only(key_content))

        # adjust some keys to not use units
        self.header['Sampling Frequency'] = self.header['Sampling Frequency (Hz)']
        self.header['Collection period'] = self.header['Collection period (s)']

    def _update_header_data(self, key, content):
        """Update header data with appropriate key"""
        header_keys = self._header_keys()
        assert (key in header_keys), "key is not in predefined key set"
        self.header[key] = content

    @staticmethod
    def _header_keys():
        """Return the keys that the header should look for"""
        keys = ('Date', 'Time', 'Notes', 'Collection period (s)', 'Sampling Frequency (Hz)')
        return keys

    @staticmethod
    def _get_text_only(text):
        """Strip colon and spaces in header text"""
        assert isinstance(text, str), "To strip colon and spaces, need type string"
        return text[2:len(text)]

    def _str2array(self, idx):
        """Convert a data segment string to a data array"""
        txt_data = self.get_data_segment(idx)
        txt_data = txt_data[5:len(txt_data)]
        # pre-slot a 3xn array
        data = np.zeros(shape=(len(txt_data), 3))
        for idx, each in enumerate(txt_data):
            each_as_lst = each.split(',')
            each_as_float = [float(x) for x in each_as_lst]
            for n in range(3):
                data[idx, n] = each_as_float[n]
        return data

    def report(self, idx, norm=False, show=False):
        """Make plots of the specified index and output a simple report"""
        self.plot_series(idx, norm, save=True)
        self.plot_scatter(idx, save=True)
        self.plot_residual(idx, save=True)
        if show:
            plt.show()

    def full_report(self, norm=False):
        for i in range(self.data_size):
            self.report(idx=i, norm=norm, show=False)
            plt.close()

    def plot_series(self, idx, norm=False, save=False):
        """Plot the data series"""
        self.read_header_data(idx)
        sampF = float(self.header['Sampling Frequency'])
        data = self._str2array(idx)
        time = data[:, 0]*1/sampF
        time = time[24:-1]
        fig = plt.figure()
        ax = fig.add_subplot(111)
        print('Remember! Skipping the first 24 data points for time series!')
        sen1 = data[:, 1][24:-1]  # should be Internal sensor
        sen2 = data[:, 2][24:-1]  # should be External sensor
        if norm:
            title = f'Normalized dual sensor comparison'
            sen1 = self.normalize_data(sen1)
            sen2 = self.normalize_data(sen2)
            ax.set(title=title)
        else:
            title = f'Dual sensor comparison'
            ax.set(title=title)
        ax.plot(time, sen1)
        ax.plot(time, sen2)
        ax.set(ylabel='Distance',
               xlabel='Time(s)')
        ax.legend(['Internal', 'External'])
        # self._basic_stats(sen1, sen2)
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)
        plt.close(fig)

    def plot_residual(self, idx, save=False):
        """Plot the residual of the internal and external sensor
        Also produce some stats to understand goodness of calibration"""
        title = f'Residual. Data ID {idx}'
        self.read_header_data(idx)
        data = self._str2array(idx)

        # prep data
        sampF = float(self.header['Sampling Frequency'])
        time_arr = data[:, 0]*1/sampF
        time_arr = time_arr[12:-1]

        print('Remember! Skipping the first 12 data points for residual!')
        sen1 = data[:, 2][12:-1]
        sen2 = data[:, 1][12:-1]
        residual = sen1-sen2

        # print out some basic stats for the residual data
        self._calc_and_print_simple_stats(f"Data ID {idx}", residual)
        rmse = self._rmse(sen1, sen2)
        print(f'RMSE: {rmse}')

        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.plot(time_arr, residual, '.b', linewidth=0, markersize=1)
        ax.set(title=title,
               ylabel='Residual (mm)',
               xlabel='Time (s)')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)

    def plot_scatter(self, idx, save=False):
        """Plot the scattered data"""
        title = f'Scatter plot external and internal sensors'
        data = self._str2array(idx)
        fig = plt.figure()
        ax = fig.add_subplot(111)
        sen1 = data[:, 2][12:-1]
        sen2 = data[:, 1][12:-1]
        print('Remember! Skipping the first 12 data points for scatter plot!')
        ax.plot(sen1, sen2, '.b', linewidth=0, markersize=2)
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)

    @staticmethod
    def normalize_data(data):
        """Normalize an input data set"""
        # remove average
        avg = np.mean(data)
        data = data - avg
        # remove spread
        spread = max(data)-min(data)
        data = data/spread
        return data

    @staticmethod
    def _basic_stats(sen1, sen2):
        """Return basic stats of the sensors"""
        print(f'Sensor 1 mean: {np.mean(sen1)}')
        print(f'Sensor 1 std dev: {np.std(sen1)}')
        print(f'Sensor 2 mean: {np.mean(sen2)}')
        print(f'Sensor 2 std dev: {np.std(sen2)}')

    @staticmethod
    def _rmse(set1, set2):
        """calculate the root mean square of set1 and set2"""
        if len(set1) != len(set2):
            raise Exception('To calculate rmse, set1 and set2 has to be the same length!')
        diff = set1-set2
        sum_diff_squared = np.sum(diff**2)
        return np.sqrt(sum_diff_squared/len(set1))

    @staticmethod
    def _calc_and_print_simple_stats(data_name, data):
        """Calculate and print basic stats for a data set"""
        print(f'\t-> Data set {data_name}')
        mean1 = np.mean(data)
        std1 = np.std(data)
        three_sigma = 3*np.std(data)
        max1 = np.max(data)
        min1 = np.min(data)
        range1 = max1 - min1
        print(f'Mean: {mean1}\tStd: {std1}\t3s: {three_sigma}\tRange: {range1}\n')

    def combine_data(self, indices):
        """input indices as a list of indices to aggregate data into one single pool"""
        data = np.empty((1, 3))
        for each_idx in indices:
            reduced_data = self._str2array(each_idx)[12:-1]
            data = np.vstack((data, reduced_data))
        # delete the first data entry of empty array
        data = np.delete(data, 0, 0)
        return data

    def plot_combine_data(self, indices, save=False):
        title = f'Combine data from indices {indices}'
        fig = plt.figure()
        ax = fig.add_subplot(111)
        # markers = ['o', '^', 's']
        for idx, each in enumerate(indices):
            data = self._str2array(each)
            sen2 = data[:, 1]
            sen1 = data[:, 2]
            ax.plot(sen1, sen2, marker='o', markersize=1, linewidth=0)
        # ax.set_aspect('equal')
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)

    def calculate_lin_fit_params_combined_data(self, indices):
        """calculate linear fit parameters of the combined data"""
        cdata = self.combine_data(indices=indices)
        scipy_fit_params = stats.linregress(cdata[:, 1], cdata[:, 2])
        # np_fit_params = np.polyfit(cdata[:, 0], cdata[:, 1], deg=1, full=True)
        print(f'R value for fit {scipy_fit_params.rvalue}')
        return scipy_fit_params

    def calculate_poly_fit_params_combined_data(self, indices):
        """calculate poly fit parameters of the combined data"""
        cdata = self.combine_data(indices=indices)
        # scipy_fit_params = stats.linregress(cdata[:, 2], cdata[:, 1])
        np_fit_params = np.polyfit(cdata[:, 2], cdata[:, 1], deg=2)
        # print(f'R value for poly fit {np_fit_params.rcond}')
        return np_fit_params

    def plot_cdata_add_poly_fit(self, indices):
        """plot the combined data """
        fit_params = self.calculate_poly_fit_params_combined_data(indices=indices)
        cdata = self.combine_data(indices=indices)
        title = 'Combined Data'
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.plot(cdata[:, 2], cdata[:, 1], linewidth=0, marker='o', markersize=2)
        fitted_data = fit_params[0]*cdata[:, 2]**2 + fit_params[1]*cdata[:, 2] + fit_params[2]
        ax.plot(cdata[:, 2], fitted_data, linewidth=0, marker='o', markersize=4)
        ax.set_aspect('equal')
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')

    def plot_cdata_add_fit(self, indices):
        """plot the combined data """
        fit_params = self.calculate_lin_fit_params_combined_data(indices=indices)
        cdata = self.combine_data(indices=indices)
        title = 'Linear fit data from all runs of a muscle'
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.plot(cdata[:, 1], cdata[:, 2], linewidth=0, marker='o', markersize=2)
        fitted_data = fit_params.slope*cdata[:, 1] + fit_params.intercept
        ax.plot(cdata[:, 1], fitted_data)
        ax.set_aspect('equal')
        ax.set(title=title,
               ylabel='External sensor',
               xlabel='Internal sensor')
        print(fit_params)

    def test_fit_to_data_set(self, indices, data_index, save=False):
        """use the fit params from calculate_lin_fit_params_combined_data to estimate how good the fit is
        when applied to a data set"""
        title = f'Compare_fitted_data_index_{data_index}'
        fit_params = self.calculate_lin_fit_params_combined_data(indices=indices)
        data = self._str2array(data_index)
        fitted_data = fit_params.slope*data[:, 2] + fit_params.intercept
        # plot fitted data to compare with external sensor
        fig = plt.figure()
        ax = fig.add_subplot(211)
        ax.plot(data[:, 0], data[:, 1], linewidth=1, marker='o', markersize=2)
        ax.plot(data[:, 0], fitted_data, linewidth=1, marker='o', markersize=2)
        ax.set(title=title,
               ylabel='Distance(mm)',
               xlabel='Time(s)')
        # plot residual and calculate accuracy and repeatability
        residual = data[:, 1] - fitted_data
        ax = fig.add_subplot(212)
        ax.plot(data[:, 0], residual, linewidth=1, marker='o', markersize=2)
        ax.set(title='Residual',
               ylabel='Distance(mm)',
               xlabel='Time(s)')
        print(f'Average error for fitted data index {data_index}: {np.mean(residual)} mm')
        print(f'Spread data index {data_index}: {np.std(residual)}mm')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)


RunAll = True
if RunAll and __name__ == "__main__":
    # define path
    file = 'IR_test250.txt'
    path = Path(__file__).parent / file
    IR_data = DataHandler(path)
    print(f"Type: {type(IR_data.raw_data)}")
    print(f"Number of lines: {len(IR_data.raw_data)}")
    print(f"Data size: {IR_data.data_size}")
    IR_data.full_report(norm=False)
    idx_list = [0, 1]
    IR_data.combine_data(indices=idx_list)
    # IR_data.plot_combine_data(indices=idx_list, save=True)
    IR_data.plot_cdata_add_fit(indices=idx_list)
    # IR_data.test_fit_to_data_set(indices=idx_list, data_index=1, save=True)
    plt.show()

makeReport = False
if makeReport and __name__ == "__main__":
    # path = "D:\\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\PythonCode\IR_data4.txt"
    file = 'IR_test23.txt'
    path = Path(__file__).parent / file
    IR_data = DataHandler(path)
    for each in IR_data.data_index:
        IR_data.report(each)
