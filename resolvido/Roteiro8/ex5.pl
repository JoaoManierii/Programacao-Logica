/*ex5*/
subconj([], []).
subconj(SubConj, [_|Conj]) :-
    var(SubConj),
    subconj(SubConj, Conj).

subconj([H|SubConj], [H|Conj]) :-
    var(SubConj),
    subconj(SubConj, Conj).

subconj(SubConj, Conj) :-
    nonvar(SubConj),
    sort(Conj, SortedConj),
    sort(SubConj, SortedSubConj),
    subconjSort(SortedConj, SortedSubConj),!.

subconjSort([], _).
subconjSort([_|SubConj], Conj) :-
    subconjSort(SubConj, Conj), !.
subconjSort([X|SubConj], [X|Conj]) :-
    subconjSort(SubConj, Conj), !.

/*
?- subconj([a,b],[a,b,c]).
true
?- subconj([c,b],[a,b,c])
true
?- subconj([],[a,b,c])
true
?- subconj(S,[a,b,c]).
*/