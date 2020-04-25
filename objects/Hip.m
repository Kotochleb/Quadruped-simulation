classdef Hip
    properties
        % Bsic properties
        gearboxRadius      {mustBeNumeric}  % [mm]
        gearboxThickness   {mustBeNumeric}  % [mm]
        gearboxMass        {mustBeNumeric}  % [mm]
        gearboxDensity     {mustBeNumeric}  % [mm]
        gearboxCorrection  {mustBeNumeric}  % [mm]
        
        legGbxOft                           % [mm]          
        kneeGbxOft                          % [mm]
        legOft                              % [mm]
        GbxColor                            % [mm]
        
        % Contact Parameters
        sphere_rad   {mustBeNumeric}         % [m]
        stat_frict   {mustBeNumeric}         % [no unit]
        kine_frict   {mustBeNumeric}         % [no unit]
        
        joint = Joint
        
    end
end