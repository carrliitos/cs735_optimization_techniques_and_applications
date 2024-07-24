Sets
    i /wine, beer, champagne, whiskey/
    j /molding, packaging, glass/;

Parameters
    mold(i)     / wine 4, beer 9, champagne 7, whiskey 10 /
    package(i)  / wine 1, beer 1, champagne 3, whiskey 40 /
    glass(i)    / wine 3, beer 4, champagne 2, whiskey 1 /
    price(i)    / wine 6, beer 10, champagne 9, whiskey 20 /;

Scalar
    maxMold     /600/
    maxPackage  /400/
    maxGlass    /500/;

Variables
    x(i)        'Number of each type of glass produced'
    revenue     'Total revenue';

Positive Variables x;

Equations
    obj         'Objective function'
    moldTime    'Molding time constraint'
    packageTime 'Packaging time constraint'
    glassUsed   'Glass used constraint';

obj..          revenue =e= sum(i, price(i) * x(i));
moldTime..     sum(i, mold(i) * x(i)) =l= maxMold;
packageTime..  sum(i, package(i) * x(i)) =l= maxPackage;
glassUsed..    sum(i, glass(i) * x(i)) =l= maxGlass;

Model maximizeRevenue /all/;
Solve maximizeRevenue using lp maximizing revenue;

Display x.l, revenue.l;
