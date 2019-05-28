clc
clear
close all
% Change g to be local
g = 9.8015;
imu_data = importdata('imu.txt');
imu_data(:, 1) = (imu_data(:, 1) - imu_data(1, 1));
imu_data(:, 5:7) = imu_data(:, 5:7) * pi / 180;
imu_data(:, 2:4) = g * imu_data(:, 2:4);
imu_data(:, 1) = imu_data(:, 1) / 1e6;
[Ta, Ka, Ba, Tg, Kg, Bg] = ImuCalibration(imu_data);
skew_a = Ta * Ka;
skew_g = Tg * Kg;
Ba = Ba / g;
fid = fopen('IMU_calibration_result_3.txt', 'w');
fprintf(fid, 'Acc skew:\n');

for i = 1:3

    for j = 1:3
        fprintf(fid, '%.6f, ', skew_a(i, j));
    end

end

fprintf(fid, '\nGyro skew:\n');

for i = 1:3

    for j = 1:3
        fprintf(fid, '%.6f, ', skew_g(i, j));
    end

end

fprintf(fid, '\nAcc bias:\n');

for i = 1:3
    fprintf(fid, '%.6f, ', Ba(i));
end

fprintf(fid, '\nGyro bias:\n');

for i = 1:3
    fprintf(fid, '%.6f, ', Bg(i));
end

fclose(fid);
