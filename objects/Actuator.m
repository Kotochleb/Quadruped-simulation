classdef Actuator
    properties
        % PID
        Kp            {mustBeNumeric}  % [no unit]
        Ki            {mustBeNumeric}  % [no unit]
        Kd            {mustBeNumeric}  % [no unit]
        N             {mustBeNumeric}  % [no unit]
        
        torque_lim           {mustBeNumeric}  % [Nm]
        speed_lim            {mustBeNumeric}  % [rad/s]
        motor_inertia        {mustBeNumeric}  % [kg/m^2]
        gear_ratio           {mustBeNumeric}  % [mm]
        torque_to_current
    end
end