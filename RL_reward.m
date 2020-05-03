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
isdone.hip_contact_gain = 1000;


isdone.err_int_threshold = 2.5;


%% rewardard
reward = Reward;
<<<<<<< HEAD

% distance
reward.x_gain = -1;
reward.y_gain = 30;
reward.z_desire_val = robot.RR.y;
reward.z_desire_val_reward = 25;

=======
%distance
reward.x_gain = -0.1;
reward.y_gain = 10;
reward.z_gain = -0.1;
reward.z_desire_val = 30;
reward.xy_gain = 1;
>>>>>>> 8b6369268ebfa46d3c8bfc2eb0e043a4ab65bdf8
%speed
reward.vx_gain = -0.1;
reward.vy_gain = 10;
reward.vz_gain = -1;

% angle
reward.wx_gain = -1;
reward.wy_gain = -1;
reward.wz_gain = -1;

% leg
reward.hip_contact_threshold = 30;
reward.hip_contact_gain = -100;

reward.hip_angle = deg2rad(80);
reward.hip_angle_gain = -0.5;

reward.upper_joint_angle = deg2rad(80);
reward.upper_joint_angle_gain = -0.5;

reward.lower_joint_angle = deg2rad(80);
reward.lower_joint_angle_gain = -0.5;


%time
reward.time_gain = 3;
