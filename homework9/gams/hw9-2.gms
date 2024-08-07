$ontext
2. The General Eccentric Power and Lighting Company has a system
consisting of two dams and their associated reservoirs and power
plants on a river. The important flows of power and water are shown
in the following diagram:<p>
In the following table, all quantities measuring water are in units
of 1000 acre-feet (KAF's). Power is measured in megawatt hours
(MWH's). <p>
<pre>

                                          A               B           Units
Storage Capacity                        2000            1500            KAF
Minimum allowable level                 1200             800            KAF
Predicted inflow:
        March                            200              40            KAF
        April                            130              15            KAF
March 1 level                           1900             850            KAF
Water-Power Conversion                   400             200        MWH/KAF
Power Plant Capacity                  60,000          35,000       MWH/month
</pre>
Power can be sold at $5.00 per MWH for up to 50,000 MWH each month,
and excess power above that figure can be sold for $3.50 per MWH.
Assume flow rates in and out through the power plants are constant
within the month.
<p>
(a) Suppose there is a spillway by each reservoir that allows water to
spill out (at any level) and bypass the relevant power plant.
A consequence of these assumptions is that the maximum and minimum
water-level constraints need to be satisfied only at the end of the
month.
Formulate a linear program to maximize the amount of money General
Eccentric receives for the power it sells during the months of March
and April, given the constraints.
$offtext

set plant /a,b/;
set month /mar,apr/;
set ptype /normal,excess/;

parameter price(ptype) /
normal  5
excess  3.5
/;

table data(*,plant)
                        a       b
store-cap               2000    1500
min-lev                 1200    800
mar-lev                 1900    850
conv-rate               400     200
plant-cap               60000   35000 ;

table inflow(month,plant)
                a       b
mar             200     40
apr             130     15 ;

variables
        profit,
        resLev(month,plant) "level in reservoir at end of month",
        spill(month,plant) "amount of water spilt out of reservoir",
        water(month,plant) "amount of water sent to power plant",
        power(month,plant) "power generated per plant each month",
        genPower(month,ptype) "type of power generated each month";

positive variable
        power(month,plant) "power generated per plant each month",
        genPower(month,ptype) "type of power generated each month",
        spill(month,plant) "amount of water spilt out of reservoir",
        water(month,plant) "amount of water sent to power plant";

equations
        level_eq(month,plant),
        convert_eq(month,plant),
        split_eq(month),
        power_eq(month),
        objective_eq;

* Equation for reservoir levels
level_eq(month,plant)..
resLev(month,plant) =e=
        resLev(month-1,plant) + data("mar-lev",plant)$(ord(month) eq 1)
        + inflow(month,plant) - spill(month,plant)
        - water(month,plant);

* Equation for power conversion
convert_eq(month,plant)..
power(month,plant) =e= data("conv-rate",plant)*water(month,plant);

* Equation for power generation split
split_eq(month)..
genPower(month,"normal") + genPower(month,"excess") =e= sum(plant, power(month,plant));

* Equation for total power
power_eq(month)..
genPower(month,"normal") =l= 50000;

* Objective function
objective_eq..
profit =e= sum((month,ptype), price(ptype)*genPower(month,ptype));

* Bounds and constraints
resLev.lo(month,plant) = data("min-lev",plant);
resLev.up(month,plant) = data("store-cap",plant);
power.up(month,plant) = data("plant-cap",plant);
* No limit on spill
spill.up(month,plant) = 1e6;

model reservoir /all/;
solve reservoir using lp maximizing profit;

display profit.l, resLev.l, spill.l, water.l, power.l, genPower.l;
