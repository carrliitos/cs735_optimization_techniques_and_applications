$title Homework 2 part 2 Steelco Company
option limrow = 0, limcol = 0;

* SET AND DEFINITIONS
set I /C, Cu, Mn/;
set J /1, 2, 3, 4, 5, 6, 7/;

parameters
c(J) "Cost per ton" / "1" 200, "2" 250, "3" 150, "4" 220, "5" 240, "6" 200, "7" 165/
a(J) "Availability" / "1" 400, "2" 300, "3" 600, "4" 500, "5" 200, "6" 300, "7" 250/
min(I) "minimum grade"  / "C" 2, "Cu" 0.4, "Mn" 1.2/
max(I) "maximum grade"  / "C" 3, "Cu" 0.6, "Mn" 1.65/;

Table g(I,J) grades
         1       2       3       4       5       6       7
      C  2.5     3       0       0       0       0       0
      Cu 0       0       0.3     90      96      0.4     0.6
      Mn 1.3     0.8     0       0       4       1.2     0   ;

scalar
weightorder "in tons" /500/;

* VARIABLE AND EQUATION DECLARATIONS
free variable
obj "objective",
totalWeight;

positive variables
x(J) "Raw materials in tons";

equations 
objective "objective",
cons1 "total weight",
cons2(I) "min grade",
cons3(I) "max grade",
cons4(J) "max available";

* EQUATION (MODEL) DEFINITION
objective..
obj =e= sum(J, c(J) * x(J));

cons1..
totalWeight =e= sum(J, x(J));

cons2(I)..
(sum(J, g(I, J) * x(J) / 100)) =g= (min(I) / 100) * totalWeight;

cons3(I)..
(sum(J, g(I, J) * x(J) / 100)) =l= (max(I) / 100) * totalWeight;

cons4(J)..
x(J) =l= a(J);

* VARIBLE BOUNDS
totalWeight.lo = weightorder;

model prob2 /all/;

solve prob2 using lp minimizing obj;

parameter objval, pct(I);
objval = obj.l;
pct(I) = (sum(J, (g(I,J) / 100) * x.l(J)) / weightorder) * 100;
display objval, pct;
