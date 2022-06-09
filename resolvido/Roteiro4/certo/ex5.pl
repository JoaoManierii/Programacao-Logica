/*Ex 5*/
separa_dup([], L, L).
separa_dup([X|L1], L2,
[X|L3]):-
separa_dup(L1, L2, L3).
/*
?- separa_dup([1,1,1,1,2,3,3,1,1,4,5,5,5,5], Dups).
Dups = [[1,1,1,1], [2], [3,3], [1,1], [4], [5,5,5,5]]
*/