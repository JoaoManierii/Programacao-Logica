/*Ex 1*/
soma_acum([], [], _).

soma_acum([H|Hs], [NovaSoma|L], Soma) :-
    NovaSoma is H + Soma,
    soma_acum(Hs, L, NovaSoma).

soma_acum(L, L1) :-
    soma_acum(L, L1, 0).    

/*
?- soma_acum([1,2,3,4],K).

K = [1,3,6,10].
*/