/*Ex24*/
remove(A,[A|B], B).
remove(A, [C|B], [C|B1]):-
    remove(A,B,C1).
arranjo(0, _, []).
arranjo(N, Ds, [E|Fs]):-
    remove(E,Ds,Es),
    F is N - 1,
    arranjo(F, Es, Fs).
/*
?- arranjo(2, [a,b,c,d], A).
A = [a, b] ;
A = [a, c] ;
A = [a, d] ;
A = [b, a] ;
A = [b, c] ;
A = [b, d] ;
A = [c, a] ;
A = [c, b] ;
A = [c, d] ;
A = [d, a] ;
A = [d, b] ;
A = [d, c] ;
false.
*/