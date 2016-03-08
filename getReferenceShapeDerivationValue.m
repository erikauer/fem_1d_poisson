function [ y ] = getReferenceShapeDerivationValue( index, x )
%GETREFERENCESHAPEVALUE return left or right reference shape function 
%derivationvalue at point x.
%   
%   INPUT:
%   index       ...     reference the left or the right shape function (1 =
%                       left shape function, 2 = right shape function)
%   x           ...     evaluate shape function derivatoin value at point x
%
%   OUTPUT:
%   y           ...     value of shape function derivation at point x

if index == 1
    x(1,1:size(x,2)) = -1;
    y = x;
else
    x(1,1:size(x,2)) = 1;
    y = x;
end

end