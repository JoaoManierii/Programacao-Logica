/*ex6*/
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

conjpotencia(Conj,P) :- 
	findall(X,subconj(X,Conj),P).

/*
?- conjpotencia([a,b,c],P).
P = [[],[a],[b],[c],[a,b],[a,c],[b,c],[a,b,c]].
*/