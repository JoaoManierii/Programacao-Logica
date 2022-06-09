/*Ex 13*/
fatorial(0, 1):- !.
fatorial(N, F):- N1 is N - 1,
fatorial(N1, F1),
F is F1 * N.
/*
?- fat(5,F).
F = 120
*/