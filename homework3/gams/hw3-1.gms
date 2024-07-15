$title Optimization Problem with Set J = {1, 2, 3}
option limrow = 0, limcol = 0;

* SET AND DEFINITIONS
set J /1*3/;

*VARIABLE AND EQUATION DECLARATIONS
positive variables x(J);
free variable obj "Objective Function Value";

equations
objective "Objective Function",
cons1 "Constraint x1 + 1 <= x2",
cons2 "Constraint x2 + 1 <= x3",
cons3 "Sum Constraint";

objective..
obj =e= -53*x('1') + 33*(x('1') + 3*x('3'));

cons1..
x('1') + 1 =l= x('2');

cons2..
x('2') + 1 =l= x('3');

cons3..
sum(j, x(j)) =e= 10;

*MODEL DECLARATION AND SOLUTION
model prob /all/;

solve prob using lp minimizing obj;

*DISPLAY RESULTS
display obj.l, x.l;
