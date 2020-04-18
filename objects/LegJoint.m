classdef LegJoint
    properties
        % Bsic properties
        body = Body

        % Contact Parameters
        sphere_rad    {mustBeNumeric}  % [m]
        stat_frict    {mustBeNumeric}  % [no unit]
        kine_frict    {mustBeNumeric}  % [no unit]
        
        joint = Joint
        
    end
end