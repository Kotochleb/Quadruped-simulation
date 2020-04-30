addpath("objects/");

%% isdoneone
isdone = Isdone;
isdone.wx_threshold = deg2rad(45);
isdone.wx_gain = 1;

isdone.wy_threshold = deg2rad(45);
isdone.wy_gain = 1;

isdone.wz_threshold = deg2rad(90);
isdone.wz_gain = 1;


isdone.fall_height = 10;
isdone.fall_gain = 100;

isdone.hip_contact_force_threshold = 30;
isdone.hip_contact_gain = 100;


isdone.err_int_threshold = 2.5;


%% rewardard
reward = Reward;
%distance
reward.x_gain = -0.1;
reward.y_gain = 10;
reward.z_gain = -0.1;
reward.z_desire_val = 30;
reward.xy_gain = 1;
%speed
reward.vx_gain = -0.1;
reward.vy_gain = 10;
reward.vz_gain = -1;
%angle
reward.wx_gain = -1;
reward.wy_gain = -1;
reward.wz_gain = -1;
%time
reward.time_gain = 3;
