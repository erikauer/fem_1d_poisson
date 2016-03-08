% 1d FEM Implementation of the Laplace Equation with homogeneous dirichlet
% boundary contition.
%
% Laplace u = f in Intervall (x1, x2)
% u(x) = 0 fuer x on Boundary
%

% USER INPUT:
% Define Interval (x1,x2)
x1 = -2;
x2 = 2;

% Define the step size h for the FEM Method. In this example we choose a
% equidistant mesh. These means that we splitt the interval defined before
% into elements with the same size h.
h = 1./32;

% Calculate out of the interval and the step size h the number of elements
numberOfElements = abs(x2-x1) / h;

nodes = createNodesForElements(numberOfElements, x1, h);

% Start calculation for the local integrals of the RHS for each element
rhs_local = zeros(numberOfElements, 2);
% for each element
for i = 1 : numberOfElements
    % for each shape function on the reference element
    for j = 1 : 2
        
        % If conditions are there to fulfill the boundary conditions. We 
        % set the last and the first shape function to zero.
        if(i == 1 && j == 1)
            rhs_local(i,j) = 0;
        elseif(i == numberOfElements && j == 2)
            rhs_local(i,j) = 0;
        else
            rhs_local(i,j) = rhs_local(i,j) + ...
                (nodes(i,2) - nodes(i,1)) * ...
                integral(@(x) ...
                f(transformToPhysicalElement(x,nodes(i,1),nodes(i,2))) .* ...
                getReferenceShapeValue(j, x) ...
                ,0,1);
        end
    end
end

% Defines a map for each element in rhs_local to a element in rhs_global
locToGlob = zeros(size(rhs_local,1), 2);
for i = 1 : size(rhs_local,1)
    locToGlob(i,1) = i;
    locToGlob(i,2) = i+1;
end

% Start calculatoin of the global integral of the RHS using the local
% integrals
rhs_global = zeros(numberOfElements+1 , 1);
% for each node
for i = 1 : numberOfElements+1
    % for each shape function
    for j = 1 : 2
        % for each element in locToGlob
        for k = 1 : size(locToGlob,1)
            if ( i == locToGlob(k,j))
                rhs_global(i) = rhs_global(i) + ...
                    rhs_local(k,j);
            end
        end
    end
end

% Start calculation of the local stiffness matrices.
stiff_local = zeros(numberOfElements, 4);
% for each element
for i = 1 : 1 : numberOfElements
    % If conditions are there to fulfill the boundary conditions. We 
    % set the last and the first shape function to zero.
    if(i==1)
        stiff_local(i,1) = 0;
        stiff_local(i,2) = 0;
        stiff_local(i,3) = 0;
        stiff_local(i,4) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(2, x) .* ...
            getReferenceShapeDerivationValue(2, x) ...
            ,0,1);
    elseif(i==numberOfElements)
        stiff_local(i,1) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(1, x) .* ...
            getReferenceShapeDerivationValue(1, x) ...
            ,0,1);
        stiff_local(i,2) = 0;
        stiff_local(i,3) = 0;
        stiff_local(i,4) = 0;
    else
        stiff_local(i,1) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(1, x) .* ...
            getReferenceShapeDerivationValue(1, x) ...
            ,0,1);
        stiff_local(i,2) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(1, x) .* ...
            getReferenceShapeDerivationValue(2, x) ...
            ,0,1);
        stiff_local(i,3) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(2, x) .* ...
            getReferenceShapeDerivationValue(1, x) ...
            ,0,1);
        stiff_local(i,4) = ...
            -(nodes(i,2) - nodes(i,1))^-1 * ...
            integral(@(x) ...
            getReferenceShapeDerivationValue(2, x) .* ...
            getReferenceShapeDerivationValue(2, x) ...
            ,0,1);
    end
end

% Assemble the global stiffness matrix using the local stiffness matrices
stiff_global = zeros(numberOfElements+1);
for i = 1 : 1 : numberOfElements
    stiff_global(i,i) = stiff_global(i,i) + stiff_local(i,1);
    stiff_global(i,i+1) = stiff_global(i,i+1) + stiff_local(i,2);
    stiff_global(i+1,i) = stiff_global(i+1,i) + stiff_local(i,3);
    stiff_global(i+1,i+1) = stiff_global(i+1,i+1) + stiff_local(i,4);
end

% Calculate solution out of linear system. In the calculation we remove 
% the singular parts of the stiffness matrix and the RHS produced by
% fulfill the boundary conditions.
solution_coefficients = stiff_global(2:end-1,2:end-1) \ rhs_global(2:end-1);

% Add the coefficents for the shape functions on the boundary again and
% plot the solution
solution = zeros(size(solution_coefficients,1)+2,1);
solution(2:size(solution_coefficients,1)+1) = solution_coefficients;
mesh = x1 : h : x2;
computed = plot(mesh, solution, 's');
set(computed, 'MarkerSize', 10);

