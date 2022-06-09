/*Ex20*/
remove(A,[A|B], B).
remove(A, [C|B], [C|B1]):-
    remove(A,B,B1).
permutacao([],[]).
permutacao(As,[D|Es]):-
    remove(D,As,Ds),
    permutacao(Ds,Es).

/*
?- permutacao([a,m,o,r]).
[a,m,o,r].
[a,m,r,o].
[a,o,m,r].
[a,o,r,m].
[a,r,m,o].
[a,r,o,m].
[m,a,o,r].
[m,a,r,o].
[m,o,a,r].
[m,o,r,a].
[m,r,a,o].
[m,r,o,a].
[o,a,m,r].
[o,a,r,m].
[o,m,a,r].
[o,m,r,a].
[o,r,a,m].
[o,r,m,a].
[r,a,m,o].
[r,a,o,m].
[r,m,a,o].
[r,m,o,a].
[r,o,a,m].
[r,o,m,a].
?- permutacao([sergio,adriano,fabiola]).
*/