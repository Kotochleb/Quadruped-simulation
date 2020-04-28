classdef Reward
   properties
    
        x_gain          {mustBeNumeric}  
        y_gain          {mustBeNumeric}  
        z_gain          {mustBeNumeric}  
        z_desire_val    {mustBeNumeric}  
        xy_gain         {mustBeNumeric}  

        vx_gain         {mustBeNumeric}  
        vy_gain         {mustBeNumeric}  
        vz_gain         {mustBeNumeric}  

        wx_gain         {mustBeNumeric}  
        wy_gain         {mustBeNumeric}  
        wz_gain         {mustBeNumeric}  
        time
        time_gain       {mustBeNumeric}  
   end
end
