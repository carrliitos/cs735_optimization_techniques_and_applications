$title HW5-1   CS 635   Athula Gunawardena  MIP exercises

$Offupper
option limrow=0, limcol=0;

scalar M /80/;
sets
     opt     /1*6/ ,
     limits /min,max, exp/;

table data(opt, limits)
       min      max    exp
1      03       27     .13
2      02       12     .09
3      09       35     .17
4      05       15     .10
5      12       46     .22
6      04       18     .12
;

binary variable select(opt);
positive variables inv(opt);
variable return;

equations
    obj         'Objective function'
    budget      'Total budget constraint'
    minInvest   'Minimum investment constraint'
    maxInvest   'Maximum investment constraint'
    opt5Limit   'Option 5 investment constraint'
    opt3Min6_1  'Option 3 constraint ensuring minimum investment'
    opt3Min6_2  'Option 3 constraint ensuring minimum investment in Option 6';

obj..          return =e= sum(opt, data(opt,'exp')*inv(opt));

budget..       sum(opt, inv(opt)) =l= M;

minInvest(opt).. inv(opt) =g= data(opt,'min')*select(opt);

maxInvest(opt).. inv(opt) =l= data(opt,'max')*select(opt);

opt5Limit..    inv('5') =l= inv('2') + inv('4') + inv('6');

* Ensure that if Option 3 is selected, investment in Option 6 is at least the minimum investment
opt3Min6_1..   inv('6') =g= data('6','min')*select('3');

* Ensure that investment in Option 3 is within its limits
opt3Min6_2..   inv('3') =g= data('3','min')*select('3');

model hw5_3 /all/;
solve hw5_3 using mip maximizing return;

display return.l, select.l, inv.l;
