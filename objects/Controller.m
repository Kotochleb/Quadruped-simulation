classdef Controller
    properties
        % PID
        Kp            {mustBeNumeric}  % [no unit]
        Ki            {mustBeNumeric}  % [no unit]
        Kd            {mustBeNumeric}  % [no unit]
        N             {mustBeNumeric}  % [no unit]
        
        torque_lim           {mustBeNumeric}  % [Nm]
        ring_to_sun          {mustBeNumeric}  % [mm]
        torque_to_current
    end
end