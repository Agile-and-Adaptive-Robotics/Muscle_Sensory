import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#define directory
path1 = "rawData3.txt"
path2 = "rawData4.txt"
path3 = "rawData5.txt"
path4 = "rawData6.txt"

#read using Panda, data was collected with 2 tabs, probably should change it in the future
raw1_pd = pd.read_csv(path1, delimiter="\t", header=None)
raw2_pd = pd.read_csv(path2, delimiter="\t", header=None)
raw3_pd = pd.read_csv(path3, delimiter="\t", header=None)
raw4_pd = pd.read_csv(path4, delimiter="\t", header=None)

#convert to Numpy array
raw1 = raw1_pd.to_numpy()
raw2 = raw2_pd.to_numpy()
raw3 = raw3_pd.to_numpy()
raw4 = raw4_pd.to_numpy()

diff1 = raw1[:, 1] - raw1[:, 0]
diff2 = raw2[:, 1] - raw2[:, 0]
diff3 = raw3[:, 1] - raw3[:, 0]
diff4 = raw4[:, 1] - raw4[:, 0]

#create indexing array knowing that period is 10ms
indx1 = np.linspace(0, 10E-3*len(raw1), len(raw1))
indx2 = np.linspace(0, 10E-3*len(raw2), len(raw2))
indx3 = np.linspace(0, 10E-3*len(raw3), len(raw3))
indx4 = np.linspace(0, 10E-3*len(raw4), len(raw4))

#calculate the polynomial fit to the data.
#(Source: https://www.kite.com/python/answers/how-to-plot-a-polynomial-fit-from-an-array-of-points-using-numpy-and-matplotlib-in-python)
coeff1 = np.polyfit(raw1[:, 0], raw1[:, 1], 3)
poly1 = np.poly1d(coeff1)
new_x = np.linspace(np.min(raw1[:, 0]), np.max(raw1[:, 0]))
new_y = poly1(new_x)

#--plotting--

#figure 1: raw data 1
#top plot, plot the time series
fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(12, 7))
fig.subplots_adjust(hspace= 0)
axes[0].plot(indx1, raw1[:, 0], linewidth= 0.2, marker= ".")
axes[0].plot(indx1, raw1[:, 1], linewidth= 0.2, marker= ".")
axes[0].set_ylabel("Distance(mm)")
axes[0].set_title("IR sensor Internal vs. External R1")

#bottom plot, plot the difference between the external sensor and the internal sensor
axes[1].plot(indx1, diff1, linewidth= 0.2, marker= ".")
axes[1].plot([0, indx1[len(indx1)-1]], [0, 0], linewidth= 1.5, color= "black") #plot a horizontal line
axes[1].set_xlabel("Time(s)")
axes[1].set_ylabel("Delta(mm)")

#figure 2: raw data 2
#top plot, plot the time series
fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(12, 7))
fig.subplots_adjust(hspace= 0)
axes[0].plot(indx2, raw2[:, 0], linewidth= 0.2, marker= ".")
axes[0].plot(indx2, raw2[:, 1], linewidth= 0.2, marker= ".")
axes[0].set_ylabel("Distance(mm)")
axes[0].set_title("IR sensor Internal vs. External R2")

#bottom plot, plot the difference between the external sensor and the internal sensor
axes[1].plot(indx2, diff2, linewidth= 0.2, marker= ".")
axes[1].plot([0, indx2[len(indx2)-1]], [0, 0], linewidth= 1.5, color= "black") #plot a horizontal line
axes[1].set_xlabel("Time(s)")
axes[1].set_ylabel("Delta(mm)")

#figure 3: scatter plot of internal vs. external sensor
fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(7, 7))
#top plot: raw data 1
axes.scatter(raw1[:, 0], raw1[:, 1], marker= ".", label= "raw1")
axes.scatter(raw2[:, 0], raw2[:, 1], marker= ".", label= "raw2")
axes.scatter(raw3[:, 0], raw3[:, 1], marker= ".", label= "raw3")
axes.scatter(raw4[:, 0], raw4[:, 1], marker= ".", label= "raw4")
axes.plot([20, 130], [20, 130], color= "black", linewidth= 1, ls= "--") #plot plot y=x function
axes.axis("equal")
axes.legend(loc= "best")
axes.set_xlabel("Internal")
axes.set_ylabel("External")
axes.grid(True)

#figure 4: compare fit functions
fig, axes = plt.subplots(nrows=3, ncols=1)
#top plot: raw data 1
axes[0].scatter(raw1[:, 0], raw1[:, 1], marker= ".", label= "raw1")
axes[0].plot(new_x, new_y, color= "black", linewidth= 2) #plot the poly fit line
# axes[0].axis("equal")
#middle plot: raw data 2
axes[1].scatter(raw2[:, 0], raw2[:, 1], marker= ".", label= "raw2")
axes[1].plot(new_x, new_y, color= "black", linewidth= 2) #plot the poly fit line
# axes[1].axis("equal")
#bottom plot: raw data 3
axes[2].scatter(raw3[:, 0], raw3[:, 1], marker= ".", label= "raw3")
axes[2].plot(new_x, new_y, color= "black", linewidth= 2) #plot the poly fit line
# axes[2].axis("equal")


plt.show()




