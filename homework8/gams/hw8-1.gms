$title Problem 8-1 (MIP) Traveling Salesman
option limrow = 0, limcol = 0, solprint=off;
$ontext

Traveling salesman problem

Find the closed tour that visits all ten cities and has the minimum total length. Distances between pairs of cities are given in the table below:
        ATL     ORD     DEN     IAH     LAX     MIA     JFK     SFO     SEA     DCA
ATL     0       587     1212    701     1936    604     748     2139    2182    543
ORD     587     0       920     940     1745    1188    713     1858    1737    597
DEN     1212    920     0       879     831     1726    1631    949     1021    1494
IAH     701     940     879     0       1379    968     1420    1645    1891    1220
LAX     1936    1745    831     1379    0       2339    2451    347     959     2300
MIA     604     1188    1726    968     2339    0       1092    2594    2734    923
JFK     748     713     1631    1420    2451    1092    0       2571    2408    205
SFO     2139    1858    949     1645    347     2594    2571    0       678     2442
SEA     2182    1737    1021    1891    959     2734    2408    678     0       2329
DCA     543     597     1494    1220    2300    923     205     2442    2329    0

$offtext

sets i Cities / c1 'ALT', c2 'ORD', c3 'DEN', c4 'IAH', c5 'LAX',
                c6 'MIA', c7 'JFK', c8 'SFO', c9 'SEA', c10 'DCA' /
alias (i,j,k,l,m);

* distance between pairs of cities
table d(i,j)
        c1      c2      c3      c4      c5      c6      c7      c8      c9      c10
c1      0       587     1212    701     1936    604     748     2139    2182    543
c2      587     0       920     940     1745    1188    713     1858    1737    597
c3      1212    920     0       879     831     1726    1631    949     1021    1494
c4      701     940     879     0       1379    968     1420    1645    1891    1220
c5      1936    1745    831     1379    0       2339    2451    347     959     2300
c6      604     1188    1726    968     2339    0       1092    2594    2734    923
c7      748     713     1631    1420    2451    1092    0       2571    2408    205
c8      2139    1858    949     1645    347     2594    2571    0       678     2442
c9      2182    1737    1021    1891    959     2734    2408    678     0       2329
c10     543     597     1494    1220    2300    923     205     2442    2329    0
;

binary variables x(i,j);
free variable obj;

equations
objective "Objective function",
cons1(j) "One incoming path to each city j",
cons2(i) "One outgoing path from each city i",
cons2a(i) "No self-loops",
subtour_constraint "Subtour elimination constraint";

* Define the objective function
objective..
obj =e= sum((i,j), d(i,j)*x(i,j));

* Define constraints for exactly one incoming and outgoing path
cons1(j)..
sum(i, x(i,j)) =e= 1;

cons2(i)..
sum(j, x(i,j)) =e= 1;

* Ensure no self-loops
cons2a(i)..
x(i,i) =e= 0;

* Add subtour elimination constraints
subtour_constraint(i,j,k)..
x(i,j) + x(j,k) + x(k,i) =l= 2;

model prob2 /all/;
Option optcr=0.0;
solve prob2 using mip minimizing obj;

display obj.l, x.l;

parameter index, nextindex;
index=1;

file hw8_1results / hw8_1results.txt/;
*hw6results.ap =1;

put hw8_1results 'Solution 1'/;


put index:2:0;
loop(k,
  loop(i$(ord(i)=index),
    loop(j$ ( x.l(i,j)=1),
      nextindex = ord(j);
      ));

      put  "->"
      put nextindex:2:0 ;

      index = nextindex;
    );

    put /"Total distance =", obj.l;
