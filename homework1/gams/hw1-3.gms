* Problem 3: Maximize 5(x1 + 2x2) - 11(x2 - x3)
* subject to
* 3x1 >= sum(j, x(j))
* 0 <= x(j) <= 3 for j = 1, ..., 3

option limrow=0, limcol=0;

* Sets and parameters
set J /1*3/;
positive variables x(J);
variables obj;

* Equations
equations objdef, ineq1;

* Define objective function
objdef.. obj =e= 5*(x('1') + 2*x('2')) - 11*(x('2') - x('3'));

* Define constraints
ineq1.. 3*x('1') =g= sum(J, x(J));

* Bounds
x.lo(J) = 0;
x.up(J) = 3;

* Model definition
model prob3 /all/;

* Solve the model
solve prob3 maximizing obj using lp;

* Retrieve and display results
parameter xval(*), xlo(*), xup(*), objval;
xval(J) = x.l(J);
xlo(J) = x.lo(J);
xup(J) = x.up(J);
objval = obj.l;

display objval, xval, xlo, xup;
