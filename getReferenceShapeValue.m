function [ y ] = getReferenceShapeValue(index, x)
%GETREFERENCESHAPEVALUE return left or right reference shape function value
%at point x.
%   
%   INPUT:
%   index       ...     reference the left or the right shape function (1 =
%                       left shape function, 2 = right shape function)
%   x           ...     evaluate shape function value at point x
%
%   OUTPUT:
%   y           ...     value of shape function at point x

if (index == 1)
    y = 1-x;
else
    y = x;
end

end