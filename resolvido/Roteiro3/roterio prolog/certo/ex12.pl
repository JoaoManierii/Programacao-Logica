/*Ex12*/

digitos_em_palavras(0, zero).
digitos_em_palavras(1, um).
digitos_em_palavras(2, dois ).
digitos_em_palavras(3, tres ).
digitos_em_palavras(4, quatro).
digitos_em_palavras(5, cinco ).
digitos_em_palavras(6, seis ).
digitos_em_palavras(7, sete ).
digitos_em_palavras(8, oito ).
digitos_em_palavras(9, nove).

digitos_em_palavras([],A,A).

digitos_em_palavras([B|C], Acum, D) :-
    Acum > B,
    digitos_em_palavras(C, B, D).

digitos_em_palavras([_|B], Acum, D) :-
    digitos_em_palavras(B, Acum, D).

digitos_em_palavras([B|C], E) :-
    digitos_em_palavras([B|C], B, E).


/*
?- digitos_em_palavras(451, Ps).
Ps = [quatro, cinco, um]
?- digitos_em_palavras(209, Ps).
Ps = [dois, zero, nove]
*/