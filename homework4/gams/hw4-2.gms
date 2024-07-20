$title Sudoku
option limrow = 0, limcol = 0;

set b "9 blocks" /b1*b9/;
set row "rows within each block" /r1*r3/;
set col "columns within each block" /c1*c3/;
set n "number possibilities for each cell" /1*9/;

parameter givens(b,row,col) "initial sudoku values"/
b1.r1.c1 5
b1.r1.c2 3
b1.r2.c1 6
b1.r3.c2 9
b1.r3.c3 8

b2.r1.c2 7
b2.r2.c1 1
b2.r2.c2 9
b2.r2.c3 5

b3.r3.c2 6

b4.r1.c1 8
b4.r2.c1 4
b4.r3.c1 7

b5.r1.c2 6
b5.r2.c1 8
b5.r2.c3 3
b5.r3.c2 2

b6.r1.c3 3
b6.r2.c3 1
b6.r3.c3 6

b7.r1.c2 6

b8.r2.c1 4
b8.r2.c2 1
b8.r2.c3 9
b8.r3.c2 8

b9.r1.c1 2
b9.r1.c2 8
b9.r2.c3 5
b9.r3.c2 7
b9.r3.c3 9
/;

$ontext
+-------+-------+-------+
| 5 3 . | . 7 . | . . . |
| 6 . . | 1 9 5 | . . . |
| . 9 8 | . . . | . 6 . |
+-------+-------+-------+
| 8 . . | . 6 . | . . 3 |
| 4 . . | 8 . 3 | . . 1 |
| 7 . . | . 2 . | . . 6 |
+-------+-------+-------+
| . 6 . | . . . | 2 8 . |
| . . . | 4 1 9 | . . 5 |
| . . . | . 8 . | . 7 9 |
+-------+-------+-------+
$offtext

binary variable x(b,row,col,n) "x[b,row,col,n] = 1 means block b(row,col) = assigned number n";

free variable obj;

equations
objective "objective",
cons1(b,row,col,n) "assign initial values based on parameter givens to variable x",
cons2(b,n) "each number n in block b is assigned a unique cell",
cons3(b,row,col) "each cell (row,col) in block b is assigned a unique number",
cons4(row,n) "each cell in each row through b1,b2,b3 contains a unique number",
cons5(row,n) "each cell in each row through b4,b5,b6 contains a unique number",
cons6(row,n) "each cell in each row through b7,b8,b9 contains a unique number",
cons7(col,n) "each cell in each col through b1,b4,b7 contains a unique number",
cons8(col,n) "each cell in each col through b2,b5,b8 contains a unique number",
cons9(col,n) "each cell in each col through b3,b6,b9 contains a unique number";

objective..
obj =e= 1;

cons1(b,row,col,n)$(givens(b,row,col) > 0)..
x(b,row,col,n) =e= (ord(n) = givens(b,row,col));

cons2(b,n)..
sum((row,col), x(b,row,col,n)) =e= 1;

cons3(b,row,col)..
sum(n, x(b,row,col,n)) =e= 1;

cons4(row,n)..
sum((b,col)$(ord(b)=1 or ord(b)=2 or ord(b)=3), x(b,row,col,n))  =e= 1;

cons5(row,n)..
sum((b,col)$(ord(b)=4 or ord(b)=5 or ord(b)=6), x(b,row,col,n))  =e= 1;

cons6(row,n)..
sum((b,col)$(ord(b)=7 or ord(b)=8 or ord(b)=9), x(b,row,col,n))  =e= 1;

cons7(col,n)..
sum((b,row)$(ord(b)=1 or ord(b)=4 or ord(b)=7), x(b,row,col,n))  =e= 1;

cons8(col,n)..
sum((b,row)$(ord(b)=2 or ord(b)=5 or ord(b)=8), x(b,row,col,n))  =e= 1;

cons9(col,n)..
sum((b,row)$(ord(b)=3 or ord(b)=6 or ord(b)=9), x(b,row,col,n))  =e= 1;

model sudoku / all /;

* Solve Part a

solve sudoku us mip min obj;

display givens, x.l;

alias(n,i,j,k);
parameter y(i,j);

parameter c,d;

loop((b,row,col,n)$(x.l(b,row,col,n) = 1),
c= trunc((ord(b)-1)/3);
d = mod(ord(b)-1,3);
loop((i,j)$((ord(i)=3*c+ord(row)) and (ord(j)=3*d+ord(col))),
y(i,j) = ord(n);
)
);

file soln /solution1.txt/;
put soln;

loop(i,
   put$(mod(ord(i),3)=1) / " +-------+-------+-------+";
   put /;
   loop(j,
      put$(mod(ord(j),3)=1) " |";
      put  y(i,j):2:0 );
   put " |" )
put / " +-------+-------+-------+";
putclose soln;

* Update stuff for part (b)
givens(b,row,col) = 0;

parameter givens2(b,row,col) /
b1.r2.c1 2
b1.r2.c2 7
b1.r3.c2 8

b2.r1.c3 1
b2.r2.c2 9
b2.r3.c3 5

b3.r2.c1 5
b3.r3.c3 3

b4.r1.c3 8
b4.r2.c2 5
b4.r3.c2 1

b5.r1.c2 3
b5.r2.c1 1
b5.r2.c3 2
b5.r3.c2 5

b6.r1.c2 2
b6.r2.c2 9
b6.r3.c1 7

b7.r1.c1 5
b7.r2.c3 9

b8.r1.c1 6
b8.r2.c2 1
b8.r3.c1 2

b9.r1.c2 3
b9.r2.c2 6
b9.r2.c3 2
/;

$ontext
+-------+-------+-------+
| . . . | . . 1 | . . . |
| 2 7 . | . 9 . | 5 . . |
| . 8 . | . . 5 | . . 3 |
+-------+-------+-------+
| . . 8 | . 3 . | . 2 . |
| . 5 . | 1 . 2 | . 9 . |
| . 1 . | . 5 . | 7 . . |
+-------+-------+-------+
| 5 . . | 6 . . | . 3 . |
| . . 9 | . 1 . | . 6 2 |
| . . . | 2 . . | . . . |
+-------+-------+-------+
$offtext

* Solve Part b
givens(b,row,col) = givens2(b,row,col);

solve sudoku us mip min obj;

loop((b,row,col,n)$(x.l(b,row,col,n) = 1),
c= trunc((ord(b)-1)/3);
d = mod(ord(b)-1,3);
loop((i,j)$((ord(i)=3*c+ord(row)) and (ord(j)=3*d+ord(col))),
y(i,j) = ord(n);
)
);

file soln2 /solution2.txt/;

put soln2;

loop(i,
   PUT$(mod(ord(i),3)=1) / " +-------+-------+-------+";
   put /;
   loop(j,
      put$(mod(ord(j),3)=1) " |";
      put  y(i,j):2:0 );
   put " |" )
put / " +-------+-------+-------+";
putclose soln2;
