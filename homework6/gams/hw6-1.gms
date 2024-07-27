* Define the sets for nodes and arcs
set nodes /1, 2, 3, 4, 5, 6, 7, 8/;
alias (nodes, i, j);

* Define the arcs explicitly
set arcs / (1, 2), (2, 7), (7, 6), (2, 3), (3, 4), (4, 5), (5, 3), (8, 1), (8, 7), (8, 4) /;

* Define the cost parameter
parameter cost(nodes, nodes);
cost(i, j) = 0;

* Define costs for arcs
cost('1', '2') = 11;
cost('2', '1') = 11;
cost('2', '7') = 11;
cost('7', '2') = 11;
cost('7', '6') = 11;
cost('6', '7') = 11;
cost('2', '3') = 11;
cost('3', '2') = 11;
cost('3', '4') = 11;
cost('4', '3') = 11;
cost('4', '5') = 11;
cost('5', '4') = 11;
cost('5', '3') = 11;
cost('3', '5') = 11;
cost('8', '1') = 15;
cost('1', '8') = 15;
cost('8', '7') = 21;
cost('7', '8') = 21;
cost('8', '4') = 13.5;
cost('4', '8') = 13.5;

* Define the capacity for each arc
parameter capacity(nodes, nodes);
capacity(i, j) = +INF;

* Define the demand at each node and supply at the new source node '8'
parameter demand(nodes);
demand('1') = 100;
demand('4') = 60;
demand('7') = 80;
demand('2') = -35;
demand('5') = -50;
demand('6') = -60;
demand('8') = -100;

* Define variables
positive variable flow(nodes, nodes);
variable total_cost;

* Define equations
equations balance(nodes), objective;

* Balance equation for each node
balance(i) ..
  sum(j$(arcs(i, j)), flow(i, j)) - sum(j$(arcs(j, i)), flow(j, i)) =e= demand(i);

* Objective function: minimize total cost
objective ..
  total_cost =e= sum((i, j)$(arcs(i, j)), cost(i, j) * flow(i, j));

* Set bounds on flow variables
flow.up(i, j) = capacity(i, j);

* Define and solve the model
model min_cost_flow /balance, objective/;
solve min_cost_flow using lp minimizing total_cost;

* Display results
option solprint=off;
display flow.l, total_cost.l;
