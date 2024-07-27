* Define sets for locations
set locations / Well1, Well2, Mobile, Galveston, NY, LA /;
alias (locations, i, j);

* Define parameter for shipping costs (per 1000 barrels)
parameter cost(locations, locations);
cost(i, j) = 0;

* Set costs based on the given table
cost('Well1', 'Mobile') = 10;
cost('Well1', 'Galveston') = 13;
cost('Well1', 'NY') = 25;
cost('Well1', 'LA') = 28;
cost('Well2', 'Mobile') = 15;
cost('Well2', 'Galveston') = 12;
cost('Well2', 'NY') = 26;
cost('Well2', 'LA') = 25;
cost('Mobile', 'NY') = 16;
cost('Mobile', 'LA') = 17;
cost('Galveston', 'NY') = 14;
cost('Galveston', 'LA') = 16;

* Define the production capacities at the wells
parameter production(locations);
production('Well1') = 150000;
production('Well2') = 200000;

* Define the demand at each destination
parameter demand(locations);
demand('NY') = 140000;
demand('LA') = 160000;

* Define variables
positive variable x(locations, locations);
variable total_cost;

* Define equations
equations supply_constraints, demand_constraints, objective;

* Supply constraints for Wells 1 and 2
supply_constraints(i) ..
  sum(j$(j = 'Mobile' or j = 'Galveston' or j = 'NY' or j = 'LA'), x(i, j)) =l= production(i);

* Demand constraints for NY and LA
demand_constraints(j) ..
  sum(i$(i = 'Well1' or i = 'Well2'), x(i, j)) =g= demand(j);

* Objective function: minimize total cost
objective ..
  total_cost =e= sum((i, j)$cost(i, j) > 0, cost(i, j) * x(i, j));

* Define and solve the model
model transportation /supply_constraints, demand_constraints, objective/;
solve transportation using lp minimizing total_cost;

* Display results
option solprint=on;
display x.l, total_cost.l;
