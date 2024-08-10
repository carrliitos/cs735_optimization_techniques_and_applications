* Problem 1-1: Absolute Difference
Sets
    i /1*7/
    j /1*4/;

Parameters
    a(i,j) /
    1.1 8, 1.2 -2, 1.3 4, 1.4 -9,
    2.1 1, 2.2 6, 2.3 -1, 2.4 -5,
    3.1 1, 3.2 -1, 3.3 1, 3.4 0,
    4.1 1, 4.2 2, 4.3 -7, 4.4 4,
    5.3 1, 5.4 -1,
    6.1 1, 6.3 1, 6.4 -1,
    7.1 5, 7.2 2, 7.3 -7, 7.4 4/;

Parameters
    b(i) /
    1 17,
    2 -16,
    3 7,
    4 -15,
    5 6,
    6 0,
    7 12/;

Variables
    x(j) 'decision variables for Problem 1-1'
    e_pos(i) 'positive error variables for Problem 1-1'
    e_neg(i) 'negative error variables for Problem 1-1'
    z 'objective function for Problem 1-1';

Positive Variables x, e_pos, e_neg;

Equations
    obj 'objective function for Problem 1-1'
    constr_pos(i) 'positive constraints for Problem 1-1'
    constr_neg(i) 'negative constraints for Problem 1-1';

* Objective function: Minimize the sum of positive and negative error variables
obj.. z =e= sum(i, e_pos(i) + e_neg(i));

* Constraints: Absolute value condition reformulated
constr_pos(i).. sum(j, a(i,j)*x(j)) - b(i) =l= e_pos(i);
constr_neg(i).. sum(j, a(i,j)*x(j)) - b(i) =g= -e_neg(i);

Model abs_diff /all/;
Solve abs_diff using lp minimizing z;

Display x.l, e_pos.l, e_neg.l, z.l;

* Problem 1-2: Absolute Value Minimization (Hypothetical Example)
Sets
    k /1*5/;

Parameters
    c(k) /
    1 5,
    2 -8,
    3 3,
    4 2,
    5 -4/;

Variables
    y(k) 'decision variables for Problem 1-2'
    e2_pos(k) 'positive error variables for Problem 1-2'
    e2_neg(k) 'negative error variables for Problem 1-2'
    z2 'objective function for Problem 1-2';

Positive Variables y, e2_pos, e2_neg;

Equations
    obj2 'objective function for Problem 1-2'
    constr2_pos(k) 'positive constraints for Problem 1-2'
    constr2_neg(k) 'negative constraints for Problem 1-2';

* Objective function: Minimize the sum of positive and negative error variables
obj2.. z2 =e= sum(k, e2_pos(k) + e2_neg(k));

* Constraints: Absolute value condition reformulated
constr2_pos(k).. y(k) - c(k) =l= e2_pos(k);
constr2_neg(k).. y(k) - c(k) =g= -e2_neg(k);

Model abs_value_min /all/;
Solve abs_value_min using lp minimizing z2;

Display y.l, e2_pos.l, e2_neg.l, z2.l;
