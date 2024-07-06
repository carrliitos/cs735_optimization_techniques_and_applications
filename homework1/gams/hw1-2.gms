* Problem 2: Minimize 3x1 + 2x2 - 33x3
* subject to
* x1 - 4x2 + x3 <= 15
* 9x1 + 6x3 = 12
* 5x1 + 9x2 >= 3
* x1, x2, x3 >= 0

option limrow=0, limcol=0;

* Sets and parameters
positive variables x1, x2, x3;
variables obj;

* Equations
equations objdef, ineq1, eq2, ineq3;

* Define objective function
objdef.. obj =e= 3*x1 + 2*x2 - 33*x3;

* Define constraints
ineq1.. x1 - 4*x2 + x3 =l= 15;
eq2.. 9*x1 + 6*x3 =e= 12;
ineq3.. 5*x1 + 9*x2 =g= 3;

* Model definition
model problem2 /all/;

* Solve the model
solve problem2 minimizing obj using lp;

* Retrieve and display results
parameter x1val, x2val, x3val, objval;
objval = obj.l;
x1val = x1.l;
x2val = x2.l;
x3val = x3.l;
display objval, x1val, x2val, x3val;
