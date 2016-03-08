function [ x ] = transformToPhysicalElement( x_ref, x_1, x_2 )
%TRANSFORMTOPHYSICALELEMENT transform coordinates from reference element 
% to physical element.
%   This function defines the transformation for the 1 dimensional case.
%   In detail it transforms the interval of reference element into the
%   interval (x_1, x_2) of the physical element.
%
%   INPUT:
%   x_ref   ...     reference interval value
%   x_1     ...     left interval boundary
%   x_2     ...     right interval boundary
%
%   OUTPUT:
%   x       ...     transformed value in the pysical interval
%
x = x_1 + x_ref * (x_2 - x_1);
end