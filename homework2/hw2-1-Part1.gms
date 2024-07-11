option limrow = 0, limcol = 0;

set L  /1*5/;

alias(L,nL);

Parameters
   x(L) x-coordinates
   / 1 36
     2 23
     3 23
     4 10
     5 5   /

   y(L) y-coordinates
   / 1 20
     2 30
     3 56
     4 15
     5 5  /

   d(L) projected demand
   / 1 7
     2 3
     3 2
     4 4
     5 2 /

   s(L) units currently assigned
   /  1 6
      2 2
      3 3
      4 3
      5 4 /;

Parameter dist(L,nL) distance;
dist(L,nL) = sqrt( (x(nL) - x(L))*(x(nL) - x(L)) + (y(nL) - y(L))*(y(nL) - y(L)));

Scalar c cost per kilometer /100/;

Variable 
  obj;

Positive Variable 
  z(L,nL);

Equations
   objective 
   balance(L);

objective.. sum((L,nL), dist(L,nL)*c*z(L,nL)) =e= obj;

balance(L) .. sum(nL, z(nL,L)) + s(L) =e= d(L) + sum(nL, z(L,nL)) ;


Model AirAmbulance /objective, balance/ ;
Solve AirAmbulance  using lp minimizing obj;
Display z.l;

