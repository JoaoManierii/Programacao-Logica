/*ex4*/
mult_hora([],0).
mult_hora([H|T],S):-mult_hora(T,G),S is H+G.
/*
?- mult_hora(3, 1 h 25, Resultado).
Resultado = 4 h 15
*/