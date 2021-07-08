import numpy as np
# import pathlib as Path
import pandas as pd


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

    def __init__(self, path):
        self._path = path
        self._parse_data()
        self._find_start()
        self._initialize_keys()

    def _initialize_keys(self):
        """initialize header keys so it can be updated"""
        self.header = {}
        header_keys = self._header_keys()
        for each_key in header_keys:
            self.header[each_key] = ""

    def _parse_data(self):
        """Parse the data file"""
        f = open(self._path, "r")
        self.raw_data = f.readlines()

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
        assert isinstance(text, str), "To strip colon and spaces, need type text"
        return text[2:len(text)]

    def _str2array(self):
        """Convert a data segment string to a data array"""
        pass

    def plot_series(self, idx):
        """Plot the data series"""
        pass

    def basic_stats(self, idx):
        """Return basic stats of the sensors"""
        pass


RunAll = True
if RunAll and __name__ == "__main__":
    # define path
    path = "D:\\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\PythonCode\IR_DATA2.TXT"
    IR_data = Data(path)
    print(f"Type: {type(IR_data.raw_data)}")
    print(f"Number of lines: {len(IR_data.raw_data)}")
    print(IR_data[3])
    print(IR_data._read_header_data(4))
    print(IR_data.header)
