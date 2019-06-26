#!/usr/bin/python
import os
import sys
import numpy as np
import matplotlib.pyplot as plt


def DrawImu(file_imu):
    g = 9.80
    #TODO: convert time to date
    array_original = np.loadtxt(file_imu)
    # print array_original
    size_array = np.shape(array_original)
    rows = size_array[0]
    first_timestamp = array_original[0, 0]
    array_original[:, 0] = (array_original[:, 0] - first_timestamp) / 1e6
    array_original[:, 1:4] = array_original[:, 1:4] * g
    print array_original[:, 0]
    plt.figure("IMU Raw Data")

    plt.subplot(211)
    plt.plot(
        array_original[:, 0],
        array_original[:, 1],
        marker=".",
        color="r",
        label="Acc-X")
    plt.plot(
        array_original[:, 0],
        array_original[:, 2],
        marker=".",
        color="g",
        label="Acc-Y")
    plt.plot(
        array_original[:, 0],
        array_original[:, 3],
        marker=".",
        color="b",
        label="Acc-Z")
    plt.xlabel("time (s)")
    plt.ylabel("Unit (m/s^2)")
    plt.grid(True)
    plt.legend(loc="upper right")
    plt.title("Accelerate reading")

    plt.subplot(212)
    plt.plot(
        array_original[:, 0],
        array_original[:, 4],
        marker=".",
        color="r",
        label="Gyro-X")
    plt.plot(
        array_original[:, 0],
        array_original[:, 5],
        marker=".",
        color="g",
        label="Gyro-Y")
    plt.plot(
        array_original[:, 0],
        array_original[:, 6],
        marker=".",
        color="b",
        label="Gyro-Z")
    plt.xlabel("time (s)")
    plt.ylabel("Unit (degree/s)")
    plt.grid(True)
    plt.legend(loc="upper right")
    plt.title("Gyroscope reading")

    plt.show()


def main():
    if len(sys.argv) < 2:
        print "usage: ./%s imu_*.txt" % sys.argv[0]
        return -1
    np.set_printoptions(precision=3)
    np.set_printoptions(suppress=True)
    # np.set_printoptions(threshold=np.nan)
    file_name = sys.argv[1]
    # mu, sigma = 2, 0.5
    # v = np.random.normal(mu, sigma, 1000)
    # plt.hist(v, bins=50)
    # plt.show()
    DrawImu(file_name)
    # try:
    #     # Put matplotlib.pyplot in interactive mode so that the plots are shown in a background thread.
    #     while(True):
    #         plt.show()

    # except KeyboardInterrupt:
    #     sys.exit(0)
    return 0


if __name__ == "__main__":
    main()