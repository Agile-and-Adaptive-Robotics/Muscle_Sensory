import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt
from scipy import stats


class Data(object):
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
        self._path = Path(path2file)
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

    def _read_header_data(self, index):
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
            temp = np.array([0, 0, 0])
            # parse through each line to find the 3 numbers
            comma1 = each.find(",")
            comma2 = each[comma1+1:len(each)].find(",")
            # the indexing is to skip various things like \n, spaces, and commas\
            temp[0] = float(each[0:comma1])
            temp[1] = float(each[comma1+2:comma2+comma1+1])
            temp[2] = float(each[comma1+comma2+3:len(each)-1])
            for n in range(3):
                data[idx, n] = temp[n]
        return data

    def report(self, idx, norm=False, show=False):
        """Make plots of the specified index and output a simple report"""
        self.plot_series(idx, norm, save=True)
        self.plot_scatter(idx, save=True)
        if show:
            plt.show()

    def full_report(self, norm=False):
        for i in range(self.data_size):
            self.report(idx=i, norm=norm, show=False)
            plt.close()

    def plot_series(self, idx, norm=False, save=False):
        """Plot the data series"""
        self._read_header_data(idx)
        sampF = float(self.header['Sampling Frequency'])
        data = self._str2array(idx)
        time = data[:, 0]*1/sampF
        fig = plt.figure()
        ax = fig.add_subplot(111)
        sen1 = data[:, 1]
        sen2 = data[:, 2]
        if norm:
            title = 'Normalized dual sensor comparison'
            sen1 = self.normalize_data(sen1)
            sen2 = self.normalize_data(sen2)
            ax.set(title=title)
        else:
            title = 'Dual sensor comparison'
            ax.set(title=title)
        ax.plot(time, sen1)
        ax.plot(time, sen2)
        ax.set(ylabel='Distance',
               xlabel='Time(s)')
        ax.legend(['External', 'Internal'])
        # self._basic_stats(sen1, sen2)
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}_{idx}.png', dpi=500)

    def plot_scatter(self, idx, save=False):
        """Plot the scattered data"""
        title = 'Scatter plot external and internal sensors'
        data = self._str2array(idx)
        fig = plt.figure()
        ax = fig.add_subplot(111)
        sen1 = data[:, 1]
        sen2 = data[:, 2]
        ax.plot(sen1, sen2, linewidth=0, marker='o')
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}_{idx}.png', dpi=500)

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

    def combine_data(self, indices):
        """input indices as a list of indices to aggregate data into one single pool"""
        data = np.empty((1, 3))
        for each_idx in indices:
            data = np.vstack((data, self._str2array(each_idx)))
        # delete the first data entry of empty array
        data = np.delete(data, 0, 0)
        return data

    def plot_combine_data(self, indices, save=False):
        title = f'Combine data from indices {indices}'
        fig = plt.figure()
        ax = fig.add_subplot(111)
        markers = ['o', '^', 's']
        for idx, each in enumerate(indices):
            data = self._str2array(each)
            sen2 = data[:, 1]
            sen1 = data[:, 2]
            ax.plot(sen1, sen2, linewidth=0, marker=markers[idx], markersize=2, )
        ax.set_aspect('equal')
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')
        if save:
            plt.savefig(f'{self.wd.as_posix()}\\{title}.png', dpi=500)

    def calculate_lin_fit_params_combined_data(self, indices):
        """calculate linear fit parameters of the combined data"""
        cdata = self.combine_data(indices=indices)
        scipy_fit_params = stats.linregress(cdata[:, 2], cdata[:, 1])
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
        title = 'Combined Data'
        fig = plt.figure()
        ax = fig.add_subplot(111)
        ax.plot(cdata[:, 2], cdata[:, 1], linewidth=0, marker='o', markersize=2)
        fitted_data = fit_params.slope*cdata[:, 2] + fit_params.intercept
        ax.plot(cdata[:, 2], fitted_data)
        ax.set_aspect('equal')
        ax.set(title=title,
               ylabel='Internal sensor',
               xlabel='External sensor')

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
    path = "D:\\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\PythonCode\dualsensor_teststand_data\IR_data2.txt"
    IR_data = Data(path)
    print(f"Type: {type(IR_data.raw_data)}")
    print(f"Number of lines: {len(IR_data.raw_data)}")
    print(f"Data size: {IR_data.data_size}")
    IR_data.full_report(norm=True)
    idx_list = [1, 2, 3]
    # IR_data.combine_data(indices=idx_list)
    # IR_data.plot_combine_data(indices=idx_list, save=True)
    IR_data.plot_cdata_add_poly_fit(indices=idx_list)
    IR_data.test_fit_to_data_set(indices=idx_list, data_index=1, save=True)
    plt.show()
