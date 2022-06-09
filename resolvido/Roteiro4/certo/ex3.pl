/*Ex 3*/
sem_repeticao([], []).
sem_repeticao([A|As], Bs) :-
    sem_repeticao(As, Bs),
    member(A, Bs).
sem_repeticao([A|As], [A|Bs]) :-
    sem_repeticao(As, Bs).

/*
?- sem_repeticao([a,b,c,b], [a,c,b]).
true
*/