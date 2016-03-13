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

Before we start the implementation we need to do some math ;). We need to derive a weak formulation of the equation above.
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

Find ![solution](http://mathurl.com/zf5rrkt.png) that

![Weak Form](http://mathurl.com/z4chy3m.png)

for all ![Test function](http://mathurl.com/jqayfas.png).

###  Discretization and FEM

The idea of FEM is to replace the continuous space ![Space H](http://mathurl.com/gqnqmtv.png) with a finite dimensional 
linear space ![Space V](http://mathurl.com/2fanld2.png). So this leads to the discrete weak formulation:

Find ![solution finite](http://mathurl.com/z4me4ey.png) that

![Weak Form finite](http://mathurl.com/gus2pog.png)

for all ![Test function finite](http://mathurl.com/j7psnrc.png).

In fact, because ![Space V](http://mathurl.com/2fanld2.png) is a linear space, you can find a basis ![Basis V](http://mathurl.com/z6vfl6c.png).
This allows us to write each element in ![Space V](http://mathurl.com/2fanld2.png) as a linear combination. Using this we can write

![solution in basis](http://mathurl.com/j3veuvd.png)

and

![test function in basis](http://mathurl.com/j4oakn9.png)

with ![sum coefficents](http://mathurl.com/h8umoau.png). Inserting these both equations into the discrete weak formulation and using the linearity of a and F we get 
following result:

![fem derivation 1](http://mathurl.com/je55qkk.png)

Let us define ![fem derivation 2](http://mathurl.com/gv5263e.png) to write the equation above in vector form. We obtain

![fem derivation 3](http://mathurl.com/h5ojlym.png)

which is equal to the linear System

![fem derivation 4](http://mathurl.com/jutjpqp.png).

### FEM Calculation and numerical Implementation

As we saw in the previous section it is possible to reduce the problem to solve a linear system of equations. But there are some simplifications
you can do, to make your life easier. The first thing you can do in FEM calculations is to choose the basis ![Basis V](http://mathurl.com/z6vfl6c.png)
in a way that the most entries of the matrix of the linear system are zero. You can easily achieve this by taking functions with a reasonable small support. In the simplest case you can choose so called
hat functions.

Let us show a small example to make this important fact clear. We will consider our mathematical problem
above for the interval ![example interval](http://mathurl.com/hs6andc.png). On this interval we define the mesh ![example mesh](http://mathurl.com/h9q3jpa.png) with
![first mesh element](http://mathurl.com/hkpbsrd.png) and ![second mesh element](http://mathurl.com/hr9lpy9.png).
Each element is defined as ![example element](http://mathurl.com/gwj427t.png). The hat functions are piecewise linear functions with the property 
![hat function property](http://mathurl.com/gsbfoey.png). Now we have the enough notation to write the bilinear form as

![element wise calculation](http://mathurl.com/zvgevjc.png)

As you see above we can calculate the bilinear form by calculating the integrals for each single element. A lot of these integrals
are zero because of the small support of the hat functions. In the practical implementation it is very useful if you don't have to define
each single hat function. For this reason we define a reference element for the interval ![example interval](http://mathurl.com/hs6andc.png) and
transform the integrals into the reference element. First we consider the corresponding transformation. For any element we can define the transformation

![element transformation](http://mathurl.com/jkbzpgw.png)

that transform each value from the reference element into a value of the physical element. The first derivation of the transformation is

![element transformation derivation](http://mathurl.com/zk8p3q9.png).

Let be ![left hat function reference element](http://mathurl.com/h9eqkpu.png) the left hat function of the reference element and 
![right hat function reference element](http://mathurl.com/h4efa98.png) the right hat function of the reference element. The following sketch shows the reference
element together with its shape functions.


![reference element](./img/referenceElement_small.png)

With the transformation function we obtain the relation

![shape function relation](http://mathurl.com/ztwfekd.png)

and therefore

![shape function relation](http://mathurl.com/hw9s4kv.png)

for any element ![physical element](http://mathurl.com/j6hbh52.png).

Finally we can transform each integral of any physical element to the reference element. For the bilinear form we obtain

![integral transformation a](http://mathurl.com/h3xj9sy.png)

and analogue we obtain the integral for the RHS

![intergral transformation f](http://mathurl.com/jatdkjv.png)

This allows us to just implement the two shape functions for the reference element and just consider each integral on the reference element.
