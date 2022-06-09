/*Ex11*/

digitos([],A,A).

digitos([B|C], Acum, D) :-
    Acum > B,
    digitos(C, B, D).

digitos([_|B], Acum, D) :-
    digitos(B, Acum, D).

digitos([B|C], E) :-
    digitos([B|C], B, E).


/*
?- digitos(451, Ds).
Ds = [4, 5, 1]

?- digitos(209, Ds).
Ds = [2, 0, 9]

*/