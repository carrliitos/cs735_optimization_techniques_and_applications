$title Homework 3 part 2 Cornby Problem
option limrow = 0, limcol = 0;

* SET AND DEFINITIONS
set I /Jan, Feb, Mar, Apr/;
set J /corn, cash/;

parameters
initial(J) "initial values" / "corn" 50, "cash" 1000/
b(I) "buy per month" / "Jan" 300, "Feb" 350, "Mar" 400, "Apr" 500/
s(I) "sell per month" / "Jan" 250, "Feb" 400, "Mar" 350, "Apr" 550/;

scalar
capacity "in tons" /100/;

* VARIABLE AND EQUATION DECLARATIONS
free variable
obj "objective";

positive variables
y(I) "tons of corn bought",
z(I) "tons of corn sold",
start(I) "cash at start of month i",
cash(I) "cash after buying",
startInv(I) "stock at start of month i",
inv(I) "stock after buying";


equations 
objective "objective",
cons1(I) "start cash per month",
cons2(I) "start inventory relationship",
cons3(I) "cash relationship",
cons4(I) "inventory after buying";

* EQUATION (MODEL) DEFINITION

* objective
objective..
obj =e= start('Apr') + s('Apr') * inv('Apr');

* cons1(I) "start cash per month"
cons1(I)$(ord(I)>1)..
start(I) =e= cash(I-1) + s(I-1) * z(I-1);

* cons2(I) "start inventory relationship"
cons2(I)$(ord(I)>1)..
startInv(I) =e= inv(I-1) - z(I-1);

* cons3(I) "cash relationship"
cons3(I)..
cash(I) =e= start(I) - b(I) * y(I);

* cons4(I) "inventory after buying"
cons4(I)..
inv(I) =e= startInv(I) + y(I);

* VARIBLE BOUNDS
start.fx('Jan') = initial('cash');
startInv.fx('Jan') = initial('corn');
inv.up(I) = capacity;

model prob2 /all/;

solve prob2 using lp maximizing obj;

parameter objval;
objval = obj.l;

display objval, y.l, z.l, start.l, cash.l, startInv.l, inv.l;
