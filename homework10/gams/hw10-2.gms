$title Advertising

sets
  N /ad1*ad20/
;

alias(I,N) ;

parameters
  c(I) Cost
  alpha(I) Witches proportionality constant
  beta(I) Wizards proportionality constant
;

scalars K1, K2 ;

c(I) = normal(100,5) ;

alpha(I) = uniform(7,13) ;
beta(I) = 13-alpha(I) + 7 + 5$(uniform(0,1) < 0.3) ;

K1 = 5000;
K2 = 8000;

equations
  obj_eq,
  witches_eq,
  wizards_eq
;

positive variables x(I);
free variable cost ;

* Objective: Minimize the total cost
obj_eq.. cost =e= sum(I, c(I)*x(I));

* Constraint: Reach at least K1 witches
witches_eq.. sum(I, alpha(I)*sqrt(x(I))) =g= K1;

* Constraint: Reach at least K2 wizards
wizards_eq.. sum(I, beta(I)*sqrt(x(I))) =g= K2;

option nlp = knitro;
model w1 /all/;

solve w1 using nlp minimizing cost ;

* Display the solution for minutes of advertising per ad
display x.L;

* Calculate and display the total advertising time
parameter totalAdTime;
totalAdTime = sum(I, x.L(I));
display totalAdTime;
