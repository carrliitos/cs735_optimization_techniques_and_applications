option limrow = 0, limcol = 0;

* Set and Definitions
set I /P, S, W, H/;
set J /1, 2, 3, 4/;

* Parameters
parameters
yield(J, I) "Expected annual yield (m^3/ka)"
/ 1.P 17, 1.S 14, 1.W 10, 1.H 9,
  2.P 15, 2.S 16, 2.W 12, 2.H 11,
  3.P 13, 3.S 12, 3.W 14, 3.H 8,
  4.P 10, 4.S 11, 4.W 8, 4.H 6 /;

parameters
price(I) "Expected annual revenue (money units per ka)"
/ P 16, S 12, W 20, H 18 /;

parameters
area(J) "Area available in ka"
/ 1 1500, 2 1700, 3 900, 4 600 /;

scalar
minYieldP "Minimum required yield for Pine" / 22.5 /;
scalar
minYieldS "Minimum required yield for Spruce" / 9 /;
scalar
minYieldW "Minimum required yield for Walnut" / 4.8 /;
scalar
minYieldH "Minimum required yield for Hardwood" / 3.5 /;

* Variables
positive variables
x(J, I) "Area devoted to each species at each site";

variable
obj "Total profit";

* Equations
equations
objective "Objective function to maximize profit",
consYieldP "Minimum yield constraint for Pine",
consYieldS "Minimum yield constraint for Spruce",
consYieldW "Minimum yield constraint for Walnut",
consYieldH "Minimum yield constraint for Hardwood",
consArea(J) "Area constraint for each site";

* Objective Function
objective..
obj =e= sum(J, sum(I, price(I) * yield(J,I) * x(J,I)));

* Constraints
consYieldP..
sum(J, yield(J, 'P') * x(J, 'P')) =g= minYieldP;

consYieldS..
sum(J, yield(J, 'S') * x(J, 'S')) =g= minYieldS;

consYieldW..
sum(J, yield(J, 'W') * x(J, 'W')) =g= minYieldW;

consYieldH..
sum(J, yield(J, 'H') * x(J, 'H')) =g= minYieldH;

consArea(J)..
sum(I, x(J, I)) =l= area(J);

* Model Definition
model prob3 /all/;

* Solve Statement
solve prob3 using lp maximizing obj;

* Display Solution
parameter objval;
objval = obj.l;

display x.l, objval;
