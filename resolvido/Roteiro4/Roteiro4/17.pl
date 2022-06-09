
classe(Numero, positivo) :- Numero >= 0.
classe(Numero, negativo) :- Numero < 0.
divide([], [], []).
divide([A|As], [A|Bs], C) :-
    classe(A, positivo),
    divide(As, Bs, C).
divide([A|As], B, [A|Cs]) :-
    classe(A, negativo),
    divide(As, B, Cs). 

/*Com corte */

classe(Numero, positivo) :- Numero >= 0, !.
classe(Numero, negativo) :- Numero < 0.

divide([], [], []).

divide([A|As], [A|Bs], C) :-
    classe(A, positivo), !,
    divide(As, Bs, C).

divide([A|As], B, [A|Cs]) :-
    classe(A, negativo),
    divide(As, B, Cs).
