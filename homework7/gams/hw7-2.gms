set nodes / S, A, B, C, D, E, F, T /;
alias (nodes, i, j);

parameter capacity(nodes, nodes);
capacity(i, j) = 0;

* Set capacities based on the given graph
capacity('S', 'A') = 8;
capacity('S', 'B') = 7;
capacity('S', 'C') = 4;
capacity('A', 'B') = 2;
capacity('A', 'D') = 3;
capacity('A', 'E') = 9;
capacity('B', 'C') = 5;
capacity('B', 'E') = 6;
capacity('C', 'E') = 7;
capacity('C', 'F') = 2;
capacity('D', 'T') = 9;
capacity('E', 'D') = 3;
capacity('E', 'T') = 5;
capacity('E', 'F') = 4;
capacity('F', 'T') = 8;

positive variable flow(nodes, nodes);
variable maxFlow;

equation flow_balance, capacity_constraints, objective, source_balance, sink_balance;

* Flow balance constraints for all nodes except S and T
flow_balance(i)..
    sum(j$(capacity(i, j) > 0), flow(i, j)) - sum(j$(capacity(j, i) > 0), flow(j, i)) =g= 0;

* Flow balance constraint for source node
source_balance..
    sum(j$(capacity('S', j) > 0), flow('S', j)) =e= maxFlow;

* Flow balance constraint for sink node
sink_balance..
    sum(i$(capacity(i, 'T') > 0), flow(i, 'T')) =e= maxFlow;

* Capacity constraints for all arcs
capacity_constraints(i, j)..
    flow(i, j) =l= capacity(i, j);

* Objective: maximize the flow from S to T
objective..
    maxFlow =e= sum(j$(capacity('S', j) > 0), flow('S', j));

Model max_flow /all/;
Solve max_flow using lp maximizing maxFlow;

option solprint = on;
display flow.l, maxFlow.l;
