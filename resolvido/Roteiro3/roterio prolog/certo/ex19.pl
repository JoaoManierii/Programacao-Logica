/*Ex19*/
remove(A,[A|B], B).
remove(A, [C|B], [C|B1]):-
    remove(A,B,B1).

insere(A,[], [A]).
insere(A,[B|C], [A,B|C]).
insere(A, [B|C], [B|C1]):-
    insere(A,B,C1).

/*
?- insere(a,[b,c,d],L).
L = [a, b, c, d] ;
L = [b, a, c, d] ;
L = [b, c, a, d] ;
L = [b, c, d, a] ;
false.
*/