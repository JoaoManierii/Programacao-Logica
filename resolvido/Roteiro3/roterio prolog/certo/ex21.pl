/*Ex21*/
num_permutacoes(0, 1).
num_permutacoes(A, B) :-
    C is A - 1,
    C >= 0,
    num_permutacoes(C, Bs),
    A is Ns * B.