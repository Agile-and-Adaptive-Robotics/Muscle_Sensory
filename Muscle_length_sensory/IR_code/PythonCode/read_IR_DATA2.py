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
        return self.get_data_segment(idx)

    def _read_header_data(self, index):
        """Read header data and store it in an array"""
        pass


RunAll = True
if RunAll and __name__ == "__main__":
    # define path
    path = "D:\\Github\Muscle-Sensory\Muscle_length_sensory\IR_code\PythonCode\IR_DATA2.TXT"
    IR_data = Data(path)
    print(f"Type: {type(IR_data.raw_data)}")
    print(f"Number of lines: {len(IR_data.raw_data)}")
    print(IR_data[3])
