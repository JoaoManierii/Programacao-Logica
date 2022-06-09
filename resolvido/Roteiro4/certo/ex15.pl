/*Ex 15*/
fatquad(0, 1):- !.
fatquad(N, F):- N1 is N - 1,
fatquad(N1, F1),
F is F1 * N/F1 * N.
/*
?- fatquad(5,F).
F = 30240
*/
