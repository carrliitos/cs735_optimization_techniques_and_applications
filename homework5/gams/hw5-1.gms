$title Primal and Dual LP Problem

Sets
    i /1*3/
    j /1*3/;

Parameters
    c(i) "Objective function coefficients for primal"
       /1 3, 2 2, 3 -33/
    a(j,i) "Constraint coefficients matrix for primal"
       /1.1 1, 1.2 -4, 1.3 1
        2.1 9, 2.2 0, 2.3 6
        3.1 5, 3.2 9, 3.3 0/
    b(j) "Right hand side for primal"
       /1 15, 2 12, 3 3/;

* Define the primal variables
Variables
    x(i) "Primal variables"
    z "Objective function value for primal";

* Define the primal equations
Equations
    obj "Primal objective function"
    con(j) "Primal constraints";

* Primal objective function
obj.. 
    z =e= sum(i, c(i)*x(i));

* Primal constraints
con(j)..
    sum(i, a(j,i)*x(i)) =l= b(j);

* Non-negativity constraints
x.lo(i) = 0;

* Solve the primal problem
Model primal /all/;
Solve primal using lp minimizing z;

Display x.l, z.l;

* Dual problem data
Parameters
    d(j) "Objective function coefficients for dual"
       /1 15, 2 12, 3 3/
    a_dual(j,i) "Constraint coefficients matrix for dual"
       /1.1 1, 1.2 9, 1.3 5
        2.1 -4, 2.2 0, 2.3 9
        3.1 1, 3.2 6, 3.3 0/
    b_dual(i) "Right hand side for dual"
       /1 3, 2 2, 3 -33/;

* Define the dual variables
Variables
    y(j) "Dual variables"
    w "Objective function value for dual";

* Define the dual equations
Equations
    obj_dual "Dual objective function"
    con_dual(i) "Dual constraints";

* Dual objective function
obj_dual.. 
    w =e= sum(j, d(j)*y(j));

* Dual constraints
con_dual(i)..
    sum(j, a_dual(j,i)*y(j)) =g= b_dual(i);

* Non-negativity constraints
y.lo(j) = 0;

* Solve the dual problem
Model dual /all/;
Solve dual using lp maximizing w;

Display y.l, w.l;
