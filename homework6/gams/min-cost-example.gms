$title Min-Cost Network Flow

option limrow=8, limcol=100, solprint=off;

set node /A*F/;
parameter supply(node) /A 50, B 0, C -40, D 40 , E 30, F -80/;
parameter cost(node,node) /
          A.B   2
          A.C   4
          B.C   1
          B.E   2
          B.D   4
          C.E   3
          D.B   1
          D.F   6
          E.D   3
          E.F   2
/;

alias (node,i,j,k);
abort$(smin((i,j), cost(i,j)) lt 0) "bad costs given";
abort$(sum(i, supply(i)) ne 0) "supply must equal demand";

* define a dynamic set that indicates the "legal" arcs
set arc(node,node);
arc(i,j) = yes$(cost(i,j) gt 0);


parameter capacity(node,node);
* assign capacities
capacity(arc) = +INF;


positive variable f(node,node);
variable totalcost;

equations balance(node), objective;

balance(i)..
  sum(k$arc(i,k), f(i,k)) - sum(j$arc(j,i), f(j,i))
  =e= supply(i);

objective..
  totalcost =e= sum((i,j)$arc(i,j), cost(i,j)*f(i,j));

* apply capacity constraints
f.up(arc) = capacity(arc);

model mcf /balance, objective/;

solve mcf using lp minimizing totalcost;

 option f:0:0:2; display f.l, totalcost.l;

$onecho > cplex.opt
lpmethod 3
netfind 1
preind 0
names no
$offecho
