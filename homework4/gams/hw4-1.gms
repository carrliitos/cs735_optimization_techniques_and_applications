$title Branch and Bound Algorithm for IP Problem

option limrow = 0, limcol = 0;

*VARIABLE AND EQUATION DECLARATIONS
free variable obj "objval";

positive variables
    x1,
    x2;

equations
    objective "Minimize the objective",
    cons1,
    cons2;

objective..
    obj =e= x1 - 2*x2;

cons1..
    2*x1 + x2 =l= 5;

cons2..
    -4*x1 + 4*x2 =l= 5;

model LP1 /objective, cons1, cons2/;

* Initial LP relaxation
solve LP1 using lp minimizing obj;
display obj.l, x1.l, x2.l;

* Branching on x1
equation branch1;
branch1..
    x1 =l= floor(x1.l);

model LP2 /objective, cons1, cons2, branch1/;
solve LP2 using lp minimizing obj;
display obj.l, x1.l, x2.l;

equation branch2;
branch2..
    x1 =g= ceil(x1.l);

model LP3 /objective, cons1, cons2, branch2/;
solve LP3 using lp minimizing obj;
display obj.l, x1.l, x2.l;

* Branching on x2 from LP2
equation branch3;
branch3..
    x2 =l= floor(x2.l);

model LP4 /objective, cons1, cons2, branch1, branch3/;
solve LP4 using lp minimizing obj;
display obj.l, x1.l, x2.l;

equation branch4;
branch4..
    x2 =g= ceil(x2.l);

model LP5 /objective, cons1, cons2, branch1, branch4/;
solve LP5 using lp minimizing obj;
display obj.l, x1.l, x2.l;

* Branching on x2 from LP3
equation branch5;
branch5..
    x2 =l= floor(x2.l);

model LP6 /objective, cons1, cons2, branch2, branch5/;
solve LP6 using lp minimizing obj;
display obj.l, x1.l, x2.l;

equation branch6;
branch6..
    x2 =g= ceil(x2.l);

model LP7 /objective, cons1, cons2, branch2, branch6/;
solve LP7 using lp minimizing obj;
display obj.l, x1.l, x2.l;

* Final MIP Model
integer variables
    y1,
    y2;

free variable obj_int "objval";

equations
    objective_int "Minimize the objective",
    IPcons1,
    IPcons2;

objective_int..
    obj_int =e= y1 - 2*y2;

IPcons1..
    2*y1 + y2 =l= 5;

IPcons2..
    -4*y1 + 4*y2 =l= 5;

model IP /objective_int, IPcons1, IPcons2/;

solve IP using mip minimizing obj_int;

display obj_int.l, y1.l, y2.l;
