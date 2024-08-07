option limrow=0, limcol=0, solprint=off;

$setglobal n 5
set i /1*%n%/;
alias (i,j);

integer variables click(i,j);
variables totclicks;
integer variables cancels(i,j);
equations turnoff(i,j), cost;

scalar initclicks "how many clicks to turn off from init state",
       period "how many clicks to get back to same state";

turnoff(i,j)..
  initclicks + period*cancels(i,j) =e=
  click(i,j) + click(i-1,j) + click(i+1,j) + click(i,j-1) + click(i,j+1);
cost..
  totclicks =e= sum((i,j), click(i,j));

model lightsout /all/;
lightsout.optcr = 0;
lightsout.optca = 0.999;
lightsout.reslim = 4000;
lightsout.iterlim = 1000000000;

parameter soln(*,*);

* Case (a): High state
period = 3;
cancels.up(i,j) = period;
click.up(i,j) = 1;
initclicks = 1;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
soln('high','totclicks') = totclicks.l;

* Case (b): Medium state
period = 2;
cancels.up(i,j) = period;
click.up(i,j) = 1;
initclicks = 1;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
soln('medium','totclicks') = totclicks.l;

* Case (c): Low state
period = 1;
cancels.up(i,j) = period;
click.up(i,j) = 1;
initclicks = 1;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
soln('low','totclicks') = totclicks.l;

* Simple case
period = 2;
cancels.up(i,j) = period;
click.up(i,j) = 1;
initclicks = 1;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
soln('simple','totclicks') = totclicks.l;

option soln:0:1:1; display soln;
