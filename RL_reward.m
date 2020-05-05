addpath("objects/");

%% isdoneone
isdone = Isdone;
isdone.wx_threshold = deg2rad(15);
isdone.wx_gain = 50;

isdone.wy_threshold = deg2rad(15);
isdone.wy_gain = 50;

isdone.wz_threshold = deg2rad(25);
isdone.wz_gain = 50;


isdone.fall_height = 22;
isdone.fall_gain = 100;

isdone.hip_contact_force_threshold = 30;
isdone.hip_contact_gain = 100;


isdone.err_int_threshold = 2.5;


%% rewardard
reward = Reward;

% distance
reward.x_gain = -0.005;
reward.y_gain = 10;
reward.z_gain = -0.0005;
reward.z_desire_val = robot.RR.y;


%speed
reward.vx_gain = -0.01;
reward.vy_gain = 15;
reward.vz_gain = -0.01;

% angle
reward.wx_gain = -7;
reward.wy_gain = -7;
reward.wz_gain = -7;

% leg
reward.hip_contact_threshold = 30;
reward.hip_contact_gain = -0.3;

reward.hip_angle = deg2rad(65);
reward.hip_angle_gain = -1;

reward.upper_joint_angle = deg2rad(75);
reward.upper_joint_angle_gain = -1;

reward.lower_joint_angle = deg2rad(87);
reward.lower_joint_angle_gain = -1;


%time
reward.time_gain = 45;
