* Problem 1: Maximize 45x1 + 15x3
* subject to
* 4x1 - 2x2 + 9x3 = 22
* -2x1 + 5x2 - x3 <= 1
* x1 - x2 <= 5
* x1, x2, x3 >= 0

option limrow=0, limcol=0;

* Sets and parameters
positive variables x1, x2, x3;
variables obj;

* Equations
equations objdef, eq1, ineq2, ineq3;

* Define objective function
objdef.. obj =e= 45*x1 + 15*x3;

* Define constraints
eq1.. 4*x1 - 2*x2 + 9*x3 =e= 22;
ineq2.. -2*x1 + 5*x2 - x3 =l= 1;
ineq3.. x1 - x2 =l= 5;

* Model definition
model problem1 /all/;

* Solve the model
solve problem1 maximizing obj using lp;

* Retrieve and display results
parameter x1val, x2val, x3val, objval;
objval = obj.l;
x1val = x1.l;
x2val = x2.l;
x3val = x3.l;
display objval, x1val, x2val, x3val;
