addpath("objects/");


defActuator = Actuator;
defActuator.torque_lim  = 1;        % [Nm]
defActuator.gear_ratio = 19;
defActuator.speed_lim   = 5000 * pi /30;       % [rad/s]
defActuator.motor_inertia   = 1300;       % [g/mm^2]

% PID
defActuator.Kp = 5;
defActuator.Ki = 0.01;
defActuator.Kd = 0.06;
defActuator.N  = 800;

defActuator.torque_to_current = [[0 0.22 0.24 0.27 0.3 0.33 0.36 0.4  0.43 0.46 0.5   0.54  0.56  0.6   0.64  0.67  0.71  0.8   0.89  1.06  1.2   1.35 1.5]
                                 [0 4.25 4.72 5.28 5.9 6.62 7.4  8.23 9.11 9.94 10.87 11.83 12.79 13.98 15.08 16.11 17.28 20.38 23.68 31.11 36.0  40.5 45.00]];

defJoint = Joint;

defJoint.actuator = defActuator;

% Internal Mechanics
defJoint.base_angle    = 0;         % [deg]
defJoint.stiffness     = 0.0001;    % [Nm/deg]
defJoint.damping       = 0.01;      % [Nm/(deg/s)]
    
        
% Upper Limits
defJoint.bound_up_lim  = 1;         % [deg]
defJoint.stiff_up_lim  = 1;         % [Nm/deg]
defJoint.damp_up_lim   = 1;         % [Nm/(deg/s)]
        
% Lower Limits
defJoint.bound_lo_lim  = 1;  % [deg]
defJoint.stiff_lo_lim  = 1;  % [Nm/deg]
defJoint.dump_lo_lim   = 1;  % [Nm/(deg/s)]

defLegJointBody = Body;

defLegJointBody.length      = 200;            % [mm]
defLegJointBody.width       = 50;             % [mm]
defLegJointBody.thickness   = 10;             % [mm]
defLegJointBody.dimension   = [defLegJointBody.thickness,
                               defLegJointBody.width,
                               defLegJointBody.length];


%defLegJoint.mass                         % [g]
defLegJointBody.density     = 3000;           % [kg/m^3]
defLegJointBody.color       = [1, 0.7, 0];

defLegJoint = LegJoint;

defLegJoint.body = defLegJointBody;

% Contact Parameters
defLegJoint.sphere_rad  = defLegJoint.body.width/2/1000;        % [m]
defLegJoint.stat_frict  = 0.7;            % [no unit]
defLegJoint.kine_frict  = 0.5;            % [no unit]

defLegJoint.joint = defJoint;

defHip = Hip;

% Bsic properties
defHip.gearboxRadius    = 25;   % [mm]
defHip.gearboxThickness = 50;   % [mm]
defHip.gearboxMass      = 2000;  % [g]
defHip.gearboxDensity   = 0;    % [mm]
defHip.gearboxCorrection = defHip.gearboxThickness/2;
        
defHip.legGbxOft        = [0 50 0];   % [mm]
defHip.kneeGbxOft       = [0 50 -60];   % [mm]
defHip.legOft           = [0 0 defHip.gearboxThickness/2+5];   % [mm]
defHip.GbxColor         = [0.8, 0.8, 0.8];   % [mm]
        
% Contact Parameters
defHip.sphere_rad        = defHip.gearboxRadius/1000;   % [m]
defHip.stat_frict        = 0.7;  % [no unit]
defHip.kine_frict        = 0.5;  % [no unit]
        
defHip.joint = defJoint;

robot = Robot;

robot.RR.hip = defHip;
robot.RR.upper_joint = defLegJoint;
robot.RR.lower_joint = defLegJoint;
robot.RR.hip.joint.base_angle = 90;
robot.RR.x = -90;
robot.RR.y = 300;


robot.RL = robot.RR;

robot.RL.hip.legGbxOft(2)  = -robot.RL.hip.legGbxOft(2);
robot.RL.hip.kneeGbxOft(2) = -robot.RL.hip.kneeGbxOft(2);
robot.RL.hip.legOft(3)     = -robot.RL.hip.legOft(3);
robot.RL.hip.joint.base_angle = 180 - robot.RL.hip.joint.base_angle;


robot.FR = robot.RR;
robot.FR.hip.gearboxCorrection = -robot.FR.hip.gearboxCorrection;
robot.FR.hip.kneeGbxOft(3) = -robot.FR.hip.kneeGbxOft(3);

robot.FL = robot.RL;
robot.FL.hip.gearboxCorrection = -robot.FL.hip.gearboxCorrection;
robot.FL.hip.kneeGbxOft(3) = -robot.FL.hip.kneeGbxOft(3);


robot.FR.x = -60;
robot.FL.x = -60;

[S,E] = invKine(robot.RR);
robot.RR.upper_joint.joint.base_angle = S;
robot.RR.lower_joint.joint.base_angle = E;

[S,E] = invKine(robot.RL);
robot.RL.upper_joint.joint.base_angle = S;
robot.RL.lower_joint.joint.base_angle = E;

[S,E] = invKine(robot.FR);
robot.FR.upper_joint.joint.base_angle = S;
robot.FR.lower_joint.joint.base_angle = E;

[S,E] = invKine(robot.FL);
robot.FL.upper_joint.joint.base_angle = S;
robot.FL.lower_joint.joint.base_angle = E;

robot.body.dimension = [250, 300, 50];

robot.b1.dimension = [48, 47, 138];
robot.b1.position = [30, 0, 0];
robot.b1.mass = 1;
robot.b1.color = [0.2, 0.2, 0.2];

robot.b2 = robot.b1;
robot.b2.position = [-30, 0, 0];

robot.enclosure.dimension = [60, 0, robot.body.dimension(2)];
robot.enclosure.position = [robot.body.dimension(1)/3, 0, 0];
robot.enclosure.opacity = 0.5;
robot.enclosure.color = [0.7 0.7 0.7];
robot.enclosure.mass = 3000;

robot.odrv_l.color = [0.2 0.7 0.2];
robot.odrv_l.dimension = [50, 60, 141];
robot.odrv_l.mass = 200;

robot.odrv_r = robot.odrv_l;

robot.odrv_l.position = [-90, 0, 0];
robot.odrv_r.position = [90, 0, 0];

plane = [5, 5, 0.03];

clear E;
clear S;
clear defActuator;
clear defJoint;
clear defHip;
clear defLegJointBody
clear defLegJoint;

function [S,E]=invKine(Leg)
Q = acos((Leg.x^2 + Leg.y^2 + Leg.upper_joint.body.length^2 - Leg.lower_joint.body.length^2) / ...
   (2 * Leg.upper_joint.body.length * sqrt(Leg.x^2 + Leg.y^2)));
S = atan2(Leg.y,-Leg.x) - Q - pi/2;

E = acos((Leg.x^2 + Leg.y^2 - Leg.upper_joint.body.length^2 - Leg.lower_joint.body.length^2) / ...
    (2 * Leg.upper_joint.body.length * Leg.lower_joint.body.length));

end
