# Homework 3

## Problem 1

Use a set $J = {1, 2, 3}$ in your GAMS formulation of this problem:

$$
Minimize_{x1,x2,x3}-53x_{1}+33(x_{1}+3x_{3})
$$

subject to

$$
x_{j}+1 \leqslant x_{j+1},j=1,2 \\
\sum_{j \in J}x_{j} = 10 \\
x_{j} \geqslant 0,j=1,2,3
$$

Use the expression “positive variables” to get the lower bounds on x instead on setting
the lower bounds with “lo”. Note that if a variable x is defined over a set J, then x(J+1)
is the “j+1”st element of the set. Hint: Check fibonacci.gms.

```
Solution:
---- 36 VARIABLE obj.L = 382.333 objval
---- 36 VARIABLE x.L
1 2.333, 2 3.333, 3 4.333
```

## Problem 2

Alexis Cornby makes her living buying and selling corn. On January 1, she has 50 tons of corn and $1000 in cash. On the 
first day of each month (including January), she can buy corn at the following prices per ton: January, $300; February, 
$350; March, $400; April, $500. On the last day of each month, she can sell corn at the following prices per ton: 
January, $250; February, $400 ; March, $350 ; April, $550. Alexis stores her corn in a warehouse that can hold at most 
100 tons of corn. She must be able to pay cash for all corn at the time of purchase. Formulate an LP model to determine 
how Alexis can maximize her cash on hand at the end of April and solve using GAMS. You may use the given gams template, 
hw3-2template.gms. Some constraints involve variables from both current and previous months (Check set notation in 
fibonacci.gms).

```
Solution:
---- 68 MODEL prob4.ObjVal = 29333.333
```

## Problem 3

From past data, the production manager of the Mighty Steel Corporation knows that
by varying his production rate, he incurs additional costs. He estimates that his cost of
increasing production is $0.50 per unit increased from one month to the next. Similarly,
the cost of decreasing production is $0.25 per unit decreased from one month to the next.
A smooth production rate is obviously desirable. Sales forecasts for the next six months
are (in thousands):

```
July        4    October     12
August      8    November     6
September   20   December     4
```

June’s production schedule already has been set at 4000 units, and the July 1 inventory
level is projected to be 2000 units. Storage is available for at most 10,000 units at any one
time, so end of month inventories must not exceed this. Ignoring inventory costs, formulate
a linear program to minimize the cost of changing production rates while meeting all sales
demands.You may use the given gams template, hw3-3template.gms.
