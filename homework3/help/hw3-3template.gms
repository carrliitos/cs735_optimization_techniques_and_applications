$title  HW 3-3 COMPSCI 735

set month /jul,aug,sep,oct,nov,dec/;

parameter sales(month) /
jul     4
aug     8
sep     20
oct     12
nov     6
dec     2
/;

set type /incr,decr/;



parameter change(type) /
incr    0.5,
decr    0.25
/;

change(type) = change(type) * 1000;

scalar startInv /2/;
scalar startProd /4/;

positive variable
        invlev(month) "inventory level at end of month",
        incprod(month),
        decprod(month),
        prodlev(month);
variable cost;

equations
        obj,
        defInv(month),
        defProd(month);

obj..
cost =e= sum(month, change("incr")*incprod(month) + change("decr")*decprod(month));

defProd(month)..
prodlev(month) =e=
        prodlev(month-1) + startProd$(ord(month) eq 1)
        - decprod(month) + incprod(month);

*Write an inventory equation for the month i.e., similar to production
*defInv(month)..


invlev.up(month) = 10;

model steel /all/;
solve steel using lp minimizing cost;

display cost.l, invlev.l, incprod.l, decprod.l, prodlev.l;
