classdef LegJoint
    properties
        % Bsic properties
        length        {mustBeNumeric}  % [mm]
        width         {mustBeNumeric}  % [mm]
        thickness     {mustBeNumeric}  % [mm]
        dimension                    % [mm]
        mass          {mustBeNumeric}  % [g]
        density       {mustBeNumeric}  % [kg/m^3]
        color                        % [no unit]
        
        % Contact Parameters
        sphere_rad    {mustBeNumeric}  % [m]
        stat_frict    {mustBeNumeric}  % [no unit]
        kine_frict    {mustBeNumeric}  % [no unit]
        
        joint = Joint
        
    end
end