/*Ex7*/
subconjunto([],_).
subconjunto([A|As],B) :-
    member(A, B),
    subconjunto(As, B).

/*
?- subconjunto([3,1], [4,1,9,8,3]).
true

?- subconjunto([a,b], [b, d, e, f]).
false
*/