classdef Leg
   properties
      upper_joint = LegJoint
      lower_joint = LegJoint
      hip = Hip
      x                         {mustBeNumeric}  % [mm]
      y                         {mustBeNumeric}  % [mm]
   end
end
