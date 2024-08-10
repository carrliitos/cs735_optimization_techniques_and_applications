$title Einstein's Riddle
$offlisting
option limrow = 0;
option limcol = 0;
option solprint = off;

sets
    house /h1*h5/
    color /red,green,white,yellow,blue/
    nation /brit,swede,dane,norwegian,german/
    drink /tea,coffee,milk,beer,water/
    smoke /pallmall,dunhill,blends,bluemaster,prince/
    pet /dog,bird,cat,horse,fish/;

alias (house, house1);

binary variable
    who(house,color,nation,drink,smoke,pet);

variable z;

equations
    obj,
    one_color(house),
    one_nation(house),
    one_drink(house),
    one_smoke(house),
    one_pet(house),
    one_house_color(color),
    one_house_nation(nation),
    one_house_drink(drink),
    one_house_smoke(smoke),
    one_house_pet(pet),

    brit_red,
    dane_tea,
    green_left_white,
    green_coffee,
    norwegian_first,
    center_milk,
    pallmall_bird,
    yellow_dunhill,
    bluemaster_beer,
    german_prince,
    swede_dog;

obj.. z =e= 1;

* Each house has exactly one color, one nation, one drink, one smoke, and one pet.
one_color(house).. sum((color,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_nation(house).. sum((color,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_drink(house).. sum((color,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_smoke(house).. sum((color,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_pet(house).. sum((color,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;

* Each characteristic appears in exactly one house.
one_house_color(color).. sum((house,nation,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_house_nation(nation).. sum((house,color,drink,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_house_drink(drink).. sum((house,color,nation,smoke,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_house_smoke(smoke).. sum((house,color,nation,drink,pet), who(house,color,nation,drink,smoke,pet)) =e= 1;
one_house_pet(pet).. sum((house,color,nation,drink,smoke), who(house,color,nation,drink,smoke,pet)) =e= 1;

* Hints
brit_red..        sum((house,drink,smoke,pet), who(house,'red','brit',drink,smoke,pet)) =e= 1;
green_left_white.. sum((nation,drink,smoke,pet), who('h4','green',nation,drink,smoke,pet)) =e= sum((nation,drink,smoke,pet), who('h5','white',nation,drink,smoke,pet));
green_coffee..    sum((house,nation,smoke,pet), who(house,'green',nation,'coffee',smoke,pet)) =e= 1;
dane_tea..        sum((house,color,smoke,pet), who(house,color,'dane','tea',smoke,pet)) =e= 1;
center_milk..     sum((color,nation,smoke,pet), who('h3',color,nation,'milk',smoke,pet)) =e= 1;
norwegian_first.. sum((color,drink,smoke,pet), who('h1',color,'norwegian',drink,smoke,pet)) =e= 1;
pallmall_bird..   sum((house,color,nation,drink), who(house,color,nation,drink,'pallmall','bird')) =e= 1;
yellow_dunhill..  sum((house,nation,drink,pet), who(house,'yellow',nation,drink,'dunhill',pet)) =e= 1;
bluemaster_beer.. sum((house,color,nation,pet), who(house,color,nation,'beer','bluemaster',pet)) =e= 1;
german_prince..   sum((house,color,drink,pet), who(house,color,'german',drink,'prince',pet)) =e= 1;
swede_dog..       sum((house,color,drink,smoke), who(house,color,'swede',drink,smoke,'dog')) =e= 1;

option mip=cplex;
model einstein /all/;
solve einstein using mip maximizing z;

option who:0:0:1; display who.l;
