/*ex8*/
:- dynamic somatorio/2

somatorio(0,0).
somatorio(N,S):- Aux is N - 1, somatorio(Aux,S1), S is S1 + N, assert(somatorio(N,S)),!.

/*
?- somatorio(3,X).
X = 6
?- somatorio(5,X).
X = 15

?- somatorio(2,X).
X = 3
?- listing.
res_somatorio(2,3).

X = 6
?- listing.
res_somatorio(2,3).
res_somatorio(3,6).
*/