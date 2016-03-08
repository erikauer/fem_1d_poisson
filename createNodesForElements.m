function [ nodes ] = createNodesForElements( numberOfElements, x_1, h)
%CREATENODESFORELEMENTS create nodes object for a 1-dim problem
%   The nodes object contains information about the coordinates of each
%   single element. You can access the coordinates by using the nodes
%   array. Just use following syntax:
%
%   return left node coordinates: nodes([elementIndex], 1)
%   return right node coordinates: nodes([elementIndex], 2)
%
%   INPUT:
%   numberOfElements    ...     specifies the number of elements you want
%                               to split the domain
%   x_1                 ...     point where to start the coordinate
%                               calculation and the node count (we generate
%                               a equidistant grid
%   h                   ...     grid step size
%   
%   OUTPUT:
%   nodes               ...     matrix contain each node coordinates for
%                               each specific element

% Create a matrix which saves for each element the index of the left and
% right node.
%
% You can access the nodes of an element by using following syntax:
%
% return left node index: getNodeIndexByElement([elementNumber], 1)
% return right node index: getNodeIndexByElement([elementNumber], 2)
getNodeIndexByElement = zeros(numberOfElements, 2);
for i = 1 : numberOfElements
    getNodeIndexByElement(i,1) = i;
    getNodeIndexByElement(i,2) = i+1;
end

% For calculation we also need to access the coordinates of a node.
% GetCoordinateNodeIndex saves for each node the corresponding coordinates.
%
% You can access a coordinate by using following syntax:
%
% return node coordinates: getCoordinateByNodeIndex([nodeIndex])
getCoordinateByNodeIndex = zeros(numberOfElements, 1);
getCoordinateByNodeIndex(1) = x_1;
for i = 2 : numberOfElements + 1
    getCoordinateByNodeIndex(i) = getCoordinateByNodeIndex(i-1) + h;
end

% The nodes array saves for each element the node coordinates.
%
% You can access a coordinate by using following syntax:
%
% return left node coordinates: nodes([elementIndex], 1)
% return right node coordinates: nodes([elementIndex], 2)
nodes = zeros(numberOfElements, 2);
for i = 1 : numberOfElements
    nodes(i,1) = getCoordinateByNodeIndex(getNodeIndexByElement(i,1));
    nodes(i,2) = getCoordinateByNodeIndex(getNodeIndexByElement(i,2));
end

end

