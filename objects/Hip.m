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
        sphereRad   {mustBeNumeric}         % [m]
        statFrict   {mustBeNumeric}         % [no unit]
        kineFrict   {mustBeNumeric}         % [no unit]
        
        joint = Joint
        
    end
end