/*ex3*/ 

soma_hora([],0).
soma_hora([H|T],S):-soma_hora(T,G),S is H+G.

/*
?- soma_hora(2 h 30, 1 h 50, Resultado).
Resultado = 4 h 20
*/