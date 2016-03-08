# fem_1d_poisson
Basic Matlab example of solving the 1 dimensional poisson equation with FEM (=Finite element method)

## Introduction
Tutorial to get a basic understanding about implementing FEM using MATLAB. In this example we want to solve the poisson
equation with homogeneous boundary values.

### Get sources
     git clone https://github.com/erikauer/fem_1d_poisson.git

### Run FEM Method in Matlab
Just go inside the project root directory and run the main.m script by enter

     main
 
in Matlab Command Window.

### Change User input
You can change some values as the Interval, the step size of the FEM and modify the RHS of the equation.

To modify the Interval or the step size just go in the top of main.m script to change the values x1, x2 to change
the left or right boundary of the interval. To change the step size just modify the value for h. Here is an short
example of an possible setup:

     x1 = -2;
     x2 = 2;
     h = 1./16;

Another possibility to play around with this FEM method is to change the RHS of the equation. The RHS is defined in the
f.m script. If you open it you can return some other function. Just take attention that the function has to work for 
arrays. So use operations like .* instead of *. Here is an short example:

     y = x.^3;

## Mathematical Context
To understand whats going on in this Matlab example we need do do some math. Here you get a short mathematical
introduction how to prepare the poission equation for FEM.

### Mathematical Problem
We want to solve following mathematical problem - 1 dimensional poisson equation with homogeneous dirichlet boundary condition:

![Poisson Equation](http://mathurl.com/jckmjwh.png)

![Poisson Equation Boundary](http://mathurl.com/jnfb5r9.png)

Before we start the implementation we need to do some math ;). We need to derive a weak formulation of the Equations above.
So lets start ...

### Weak formulation
In each case if you want to do FEM you have to derive the weak formulation. We choose our shape functions out of the 
Sobolev Space ![Test function](http://mathurl.com/jqayfas.png). Multiplying the shape function to the Poisson equation 
above and integrating over the interval lead us to
![Start Weak Form](http://mathurl.com/hmlp92d.png)
After integration by parts we get 
![Finish Weak Form](http://mathurl.com/z6wgk5c.png)
In the previous equation we used that the boundary integral is zero because of the choice of the shape function.

To summarize our result we get the weak form of the poisson equation with dirichlet boundary condition:

Find ![solution](http://mathurl.com/zf5rrkt.png)  that

![Weak Form](http://mathurl.com/z4chy3m.png)

for all ![Test function](http://mathurl.com/jqayfas.png).

###  Discretization and FEM