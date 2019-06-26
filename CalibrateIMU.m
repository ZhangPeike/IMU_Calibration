function [] = CalibrateIMU(file_imu, file_res)
    close all
%     clear
    % Change g to be local
    g = 9.8015;
    imu_data = importdata(file_imu);
    imu_data(:, 1) = (imu_data(:, 1) - imu_data(1, 1));
    imu_data(:, 5:7) = imu_data(:, 5:7) * pi / 180;
    imu_data(:, 2:4) = g * imu_data(:, 2:4);
    imu_data(:, 1) = imu_data(:, 1) / 1e6;
    figure
    hold on
    grid on
    plot(imu_data(:, 1), imu_data(:, 5), 'r')
    plot(imu_data(:, 1), imu_data(:, 6), 'g')
    plot(imu_data(:, 1), imu_data(:, 7), 'b')
    [Ta, Ka, Ba, Tg, Kg, Bg, fix_point] = ImuCalibration(imu_data);
    skew_a = Ta * Ka;
    skew_g = Tg * Kg;
    dims = size(fix_point);
    n = dims(1);
    norm_res = zeros(1, n);
    norm_res_ori = zeros(1, n);

    for i = 1:n
        acc = fix_point(i, 1:3);
        acc_ori = fix_point(i, 1:3);
        accT = acc';
        cal_accT = skew_a * (accT + Ba);
        norm_res(i) = norm(cal_accT);
        norm_res_ori(i) = norm(acc_ori');
    end

    figure
    hold on
    grid on
    plot(norm_res, 'bx')
    plot(norm_res_ori, 'r+')
    title('check result')

    % Ba = Ba / g;
    fid = fopen(file_res, 'w');
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
end
