function [ y ] = f( x )
%F defines the function f of the weak formulation
%   Defines the function f on the RHS of the weak formulation. Needed for
%   calculation of the linearform.
%
%   INPUT:
%   x       ...     point on which the evalution take place
%
%   OUTPUT:
%   y       ...     evaluted value on point x
%
%
    y = x.^5 .* exp(x);
end

