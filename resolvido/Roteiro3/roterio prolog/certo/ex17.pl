/*Ex17*/
prodEsc([],[], 0).
prodEsc([A|As], [B|Bs], Soma) :-
    prodEsc(As, Bs, SomaOutra),
    Soma is SomaOutra + (A * B).


/*
?- prodEsc([2,5,6],[3,4,1],Resultado).
Resultado = 32
*/