/*Ex9*/
duplicada(A, A1) :-
    append(A1, A1, A).    
duplicada(B, [_|C]):-
    duplicada(B, C).
duplicada(D) :-
    duplicada(D, D).