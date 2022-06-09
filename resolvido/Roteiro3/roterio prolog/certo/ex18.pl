/*Ex18*/
remove(A,[A|B], B).
remove(A, [C|B], [C|B1]):-
    remove(A,B,B1).

/*
?- remove(a,[a,b,a,c,a],L).
L = [b, a, c, a] ;
L = [a, b, c, a] ;
L = [a, b, a, c] ;
false.
*/