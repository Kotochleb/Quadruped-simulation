classdef Body
   properties
        % Bsic properties
        length        {mustBeNumeric}  % [mm]
        width         {mustBeNumeric}  % [mm]
        thickness     {mustBeNumeric}  % [mm]
        dimension                      % [mm]
        position                       % [mm]
        mass          {mustBeNumeric}  % [g]
        density       {mustBeNumeric}  % [kg/m^3]
        color                          % [no unit]
        opacity       {mustBeNumeric}  % [no unit]
    
   end
end
