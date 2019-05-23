function [Ta,Ka,Ba,Tg,Kg,Bg]=ImuCalibration(data)
% input data raw IMU data from mpu9250 
% data :time accelerometer  gyroscope   magnetometer 
%  cal_acc=Ta*Ka*(raw_acc+Ba)
%  cal_gyro=Tg*Kg*(raw_gyro+Bg)
%  cal_mag=Tm2a*(raw_mag+Bm)
%
% author  Zhang Xin

% for caldata.dat 30
[fix_point,rotation]=FindFixData(data,0.03);

[Ta,Ka,Ba]=AccCalibration(fix_point);

Bg=-mean(fix_point(:,4:6),1)';

n=size(rotation,1);

rotation{n+1}=Ta;
rotation{n+2}=Ka;
rotation{n+3}=Ba;
rotation{n+4}=Bg;

[Tg,Kg]=GyroCalibration(rotation);

%[Tm2a,Bm,Vm]=mag2acc_matrix(fix_point,Ta,Ka,Ba);

%[Tm2a,Bm,Vm,mag_strength]=Cal_mag4acc_frame(rotation,fix_point,Tg,Kg);

%See_Gesture( data,Ta,Ka,Ba,Tg,Kg,Bg,Tm2a,Bm,Vm);

end