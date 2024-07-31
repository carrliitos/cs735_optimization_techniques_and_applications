option limrow=0, limcol=0, solprint=off;

* Introduced upper bound on some arcs

set T /1*10/;
parameter d(T) / 1 50, 2 60, 3 80, 4 70, 5 50, 6 60, 7 90, 8 80, 9 50, 10 100 /;

scalar
p /4/
q /2/
alpha /2.00/
beta /0.75/
gamma /0.25/;

set Nodes /Shop, s1*s10, L1*L10, Storage/;
set inodes(Nodes) /s1*s10, L1*L10/;
set snodes(Nodes) /s1*s10/;
set Lnodes(Nodes) "laundry" /L1*L10/;

alias(Nodes, I, J);
alias(Lnodes, L);
alias(snodes, s);

set Arcs(Nodes, Nodes);

Arcs(L, L+1)$(ord(L) < 10) = yes;
Arcs(L, s)$(ord(s) = ord(L) + 2) = yes;
Arcs(L, s)$(ord(s) = ord(L) + 4) = yes;
Arcs('Shop', s) = yes;
Arcs(s, 'Storage') = yes;

display Arcs;

parameters
  c(Nodes, Nodes)
  u(Nodes, Nodes)
  b(Nodes);

* Set cost parameters
c('Shop', s) = alpha;
c(L, L+1) = 0;
c(L, s)$(ord(s) = ord(L) + 2) = beta;
c(L, s)$(ord(s) = ord(L) + 4) = gamma;

* Set capacity (upper bound) parameters
u('Shop', s) = +INF;
u(s, 'Storage') = +INF;
u(L, L+1) = +INF;
u(L, s)$(ord(s) = ord(L) + 2) = +INF;
u(L, s)$(ord(s) = ord(L) + 4) = +INF;

* Demand and supply nodes
b('Shop') = sum(T, d(T));
loop(T,
  b(s)$(ord(s) = ord(T)) = -d(T);
  b(L)$(ord(L) = ord(T)) = d(T);
);

positive variables x(I, J);
free variable obj;

equations
  obj_eq
  flow_balance(Nodes);

* Objective function
obj_eq.. obj =e= sum((I, J)$(Arcs(I, J)), c(I, J)*x(I, J));

* Flow balance constraints
flow_balance(Nodes).. sum(J$(Arcs(J, Nodes)), x(J, Nodes)) - sum(J$(Arcs(Nodes, J)), x(Nodes, J)) =e= b(Nodes);

x.up(I, J)$(Arcs(I, J)) = u(I, J);

model prob1 /all/;
solve prob1 using lp minimizing obj;

* Dual infeasibility calculation
parameter infeasibility(Nodes);
infeasibility(Nodes) = abs(flow_balance.m(Nodes));
display infeasibility;

* Diagnostics
display x.l, x.m, x.up, b;

parameter Cost, NumEqu, NumBought;
Cost = obj.l;
NumEqu = 1 + card(inodes);
NumBought = sum(s, x.l('Shop', s));
display Cost, NumEqu, NumBought;
