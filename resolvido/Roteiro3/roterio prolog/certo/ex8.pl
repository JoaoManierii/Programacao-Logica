/*Ex8*/
superconjunto(_,[]).
superconjunto(A,[B|Bs]) :-
    member(A, B),
    superconjunto(A, Bs).

/*
?- superconjunto([4,1,9,8,3], [3,1]).
true

?- superconjunto([b,d,e,f], [a,b]).
false

?- superconjunto([a,f,b,e], [a,b,e,f]).
true
*/