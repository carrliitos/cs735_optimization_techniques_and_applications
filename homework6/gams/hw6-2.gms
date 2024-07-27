option limrow=10, limcol=100, solprint=off;

set nodes /S, A, B, C, D, E, F, T/;
alias (nodes, i, j);

parameter distance(nodes, nodes) / 
    S.A 8, 
    S.B 7, 
    S.C 4, 
    A.B 2, 
    A.D 3, 
    A.E 9, 
    B.E 6, 
    B.C 5, 
    C.E 7, 
    C.F 2, 
    D.T 9, 
    E.D 3, 
    E.T 5, 
    E.F 4, 
    F.T 8 /;

set arcs(nodes, nodes);
arc(i, j) = yes$(distance(i, j) > 0);

positive variable flow(i, j);
variable total_cost;

equations balance(nodes), objective;

balance(i) ..
    sum(j$arc(i, j), flow(i, j)) - sum(j$arc(j, i), flow(j, i)) =e= (i = 'S') - (i = 'T');

objective ..
    total_cost =e= sum((i, j)$arc(i, j), distance(i, j) * flow(i, j));

flow.up(i, j) = 1;

model shortest_path /balance, objective/;

solve shortest_path using lp minimizing total_cost;

option f:0:0:2;
display flow.l, total_cost.l;
