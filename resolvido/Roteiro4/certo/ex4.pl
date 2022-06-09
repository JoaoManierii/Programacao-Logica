/*Ex 4*/
segmento(A, A2) :-
    append(A, _, A2).
segmento(A, [_|Bs]) :-
    segmento(A, Bs).

/*
?- segmento([a,b,c],[1,c,a,b,c,3]).
true
?- segmento([a,b],[c,a,c,b]).
false
*/