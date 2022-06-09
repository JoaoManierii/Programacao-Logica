/*ex9*/
classe(Numero, positivo):- Numero > 0.
classe(0, zero).
classe(Numero, negativo):- Numero < 0.
/*
?- classes(0,zero).
Correct to: "classe(0,zero)"? yes
true .

?- classes(2,dois).
Correct to: "classe(2,dois)"? yes
false.

?- classes(5,-3).
Correct to: "classe(5,-3)"? yes
false.
*/