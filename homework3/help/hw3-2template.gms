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


equations objective "objective"
cons1(I) "start cash per month"
cons2(I) "start inventory relationship"
cons3(I) "cash relationship"
cons4(I) "inventory after buying"
 ;


* EQUATION (MODEL) DEFINITION

* objective
*obj= Cash on April 1+  cash from selling the whole inventory at the end of April. Use inv variable.

*cons1(I) "start cash per month"
* start cash= previous month cash after buying + the previous month sales
*Specify the domain, not valid for i=1. Check the fibonacci example.

*cons1(I)$(ord(I)>1)..
*start(I) =e= cash(I-1) + s(I-1) * z(I-1);



*cons2(I) "start inventory relationship"
* start inventory = inventory of the previous month - tons of corns sold  in the previous month
*Make sure to validate the domain as  in cons1.

*cons3(I) "cash relationship"
*Cash after buying= start cash-  the cash used for buying.



*cons4(I) "inventory after buying"
*inventory after buying= start inventory  + tons bought



* VARIBLE BOUNDS
start.fx('Jan')= initial('cash');
startInv.fx('Jan') = initial('corn');
inv.up(I) = capacity;


model prob2 /all/;

solve prob2 using lp maximizing obj;

parameter objval;
objval = obj.l;

display prob2.objval;
