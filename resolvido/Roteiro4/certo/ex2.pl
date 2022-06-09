/*Ex 2*/
soma_ate(1, 1) :- !.
soma_ate(N, Res) :- N1 is N - 1,
 soma_ate(N1, Res1),
 Res is Res1 + N.

 /*
 ?- soma_ate(5,S).
S = 15.
 */