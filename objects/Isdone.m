classdef Isdone
   properties
        wx_threshold                {mustBeNumeric}  
        wx_gain                     {mustBeNumeric}  
        wy_threshold                {mustBeNumeric}  
        wy_gain                     {mustBeNumeric}  
        wz_threshold                {mustBeNumeric}  
        wz_gain                     {mustBeNumeric}
        
        fall_height                 {mustBeNumeric}  
        fall_gain                   {mustBeNumeric}
        
        hip_contact_force_threshold {mustBeNumeric}
        hip_contact_gain            {mustBeNumeric}

        
        err_int_threshold           {mustBeNumeric}  
    
   end
end
