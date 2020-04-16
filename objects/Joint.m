classdef Joint
    properties
      
        % PID
        Kp            {mustBeNumeric}  % [no unit]
        Ki            {mustBeNumeric}  % [no unit]
        Kd            {mustBeNumeric}  % [no unit]
        N             {mustBeNumeric}  % [no unit]
        
        % Internal Mechanics
        base_angle    {mustBeNumeric}  % [deg]
        stiffness     {mustBeNumeric}  % [Nm/deg]
        damping       {mustBeNumeric}  % [Nm/(deg/s)]
        
        % Limits
        torque_lim    {mustBeNumeric}  % [Nm]
        speed_lim     {mustBeNumeric}  % [rpm]
        
        % Upper Limits
        bound_up_lim  {mustBeNumeric}  % [deg]
        stiff_up_lim  {mustBeNumeric}  % [Nm/deg]
        damp_up_lim   {mustBeNumeric}  % [Nm/(deg/s)]
        
        % Lower Limits
        bound_lo_lim  {mustBeNumeric}  % [deg]
        stiff_lo_lim  {mustBeNumeric}  % [Nm/deg]
        dump_lo_lim   {mustBeNumeric}  % [Nm/(deg/s)]
        
    end
end