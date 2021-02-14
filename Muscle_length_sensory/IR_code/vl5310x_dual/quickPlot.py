import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#define directory
path1 = "rawData1.txt"
path2 = "rawData2.txt"

#read using Panda, data was collected with 2 tabs, probably should change it in the future
raw1_pd = pd.read_csv(path1, delimiter="\t\t", header=None)
raw2_pd = pd.read_csv(path2, delimiter="\t\t", header=None)

#convert to Numpy array
raw1 = raw1_pd.to_numpy()
raw2 = raw2_pd.to_numpy()

diff1 = raw1[:, 1] - raw1[:, 0]
diff2 = raw2[:, 1] - raw2[:, 0]

#create indexing array knowing that period is 10ms
indx1 = np.linspace(0, 10E-3*len(raw1), len(raw1))
indx2 = np.linspace(0, 10E-3*len(raw2), len(raw2))

#--plotting--

#figure 1: raw data 1
#top plot, plot the time series
fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(12, 5))
fig.subplots_adjust(hspace= 0)
axes[0].plot(indx1, raw1[:, 0], linewidth= 0.2, marker= ".")
axes[0].plot(indx1, raw1[:, 1], linewidth= 0.2, marker= ".")
axes[0].set_ylabel("Distance(mm)")
axes[0].set_title("IR sensor Internal vs. External R1")

#bottom plot, plot the difference between the external sensor and the internal sensor
axes[1].plot(indx1, diff1, linewidth= 0.2, marker= ".")
axes[1].plot([0, indx1[len(indx1)-1]], [0, 0], linewidth= 1.5, color= "black")
axes[1].set_xlabel("Time(s)")
axes[1].set_ylabel("Delta(mm)")


#figure 2: raw data 2
#top plot, plot the time series
fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(12, 5))
fig.subplots_adjust(hspace= 0)
axes[0].plot(indx2, raw2[:, 0], linewidth= 0.2, marker= ".")
axes[0].plot(indx2, raw2[:, 1], linewidth= 0.2, marker= ".")
axes[0].set_ylabel("Distance(mm)")
axes[0].set_title("IR sensor Internal vs. External R2")

#bottom plot, plot the difference between the external sensor and the internal sensor
axes[1].plot(indx2, diff2, linewidth= 0.2, marker= ".")
axes[1].plot([0, indx2[len(indx2)-1]], [0, 0], linewidth= 1.5, color= "black")
axes[1].set_xlabel("Time(s)")
axes[1].set_ylabel("Delta(mm)")

plt.show()




