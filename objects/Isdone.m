classdef Isdone
   properties
        wx_threshold        {mustBeNumeric}  
        wx_gain             {mustBeNumeric}  
        wy_threshold        {mustBeNumeric}  
        wy_gain             {mustBeNumeric}  
        wz_threshold        {mustBeNumeric}  
        wz_gain             {mustBeNumeric}
        
        fall_height         {mustBeNumeric}  
        fall_gain           {mustBeNumeric}
        
        hip_max_angle       {mustBeNumeric}  
        hip_fall_height     {mustBeNumeric}  
        hip_angle_gain      {mustBeNumeric}
        
        err_int_threshold   {mustBeNumeric}  
    
   end
end
