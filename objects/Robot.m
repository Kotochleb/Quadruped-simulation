classdef Robot
   properties
      RR = Leg;
      RL = Leg;
      FR = Leg;
      FL = Leg;
      hipZOffset            {mustBeNumeric}  % [mm]
      
      body      = Body;
      enclosure = Body;
      b1        = Body;
      b2        = Body;
      odrv_l    = Body;
      odrv_r    = Body;
   end
end
