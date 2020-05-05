classdef  Reward
   properties
    
        x_gain                      {mustBeNumeric}  
        y_gain                      {mustBeNumeric}
        z_gain                      {mustBeNumeric} 
        z_desire_val_reward         {mustBeNumeric}  
        z_desire_val                {mustBeNumeric}  
        xy_gain                     {mustBeNumeric}  

        vx_gain                     {mustBeNumeric}  
        vy_gain                     {mustBeNumeric}  
        vz_gain                     {mustBeNumeric}  

        wx_gain                     {mustBeNumeric}  
        wy_gain                     {mustBeNumeric}  
        wz_gain                     {mustBeNumeric}  
        
        time_gain                   {mustBeNumeric}  
        
        hip_contact_threshold       {mustBeNumeric} 
        hip_contact_gain            {mustBeNumeric} 

        hip_angle                   {mustBeNumeric} 
        hip_angle_gain              {mustBeNumeric} 

        upper_joint_angle           {mustBeNumeric} 
        upper_joint_angle_gain      {mustBeNumeric} 

        lower_joint_angle           {mustBeNumeric}
        lower_joint_angle_gain      {mustBeNumeric} 
        
   end
end
