*This program generates the first ten Fibonacci numbers
*f(1)=1, f(2)=1
*f(n) = f(n-1)+ f(n-2) if n >= 3
$title Fibonacci up to 10
option limrow = 0, limcol = 0;

* SET AND DEFINITIONS
set J/1*10/;
*set J /1, 2, 3, 4, 5, 6, 7, 8, 9, 10/;

*VARIABLE AND EQUATION DECLARATIONS
free variable obj "objval";

positive variables
f(J);

equations
objective "objective",
cons1(J) "first constraint",
cons2    "base case",
cons3    "base case";

objective..
obj =e= 1;

cons1(J)$(ord(J) > 2)..
f(j) =e= f(j-1) + f(j-2);

cons2..
f('1') =e= 1;

cons3..
f('2') =e= 1;

*VARIABLE BOUNDS


model prob4 /all/;

solve prob4 using lp minimizing obj;

display f.l;

