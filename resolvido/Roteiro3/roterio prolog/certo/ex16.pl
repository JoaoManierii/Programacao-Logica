/*Ex16*/
multiEsc(_, [], []).
multiEsc(X, [A|As], [B|Bs]) :-
    B is A * C,
    multiEsc(C, As, Bs).


/*
?- multiEsc(3,[2,7,4],Resultado).
Resultado = [6,21,12]
*/