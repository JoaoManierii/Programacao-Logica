/*Ex 2*/

traducao(uno, um).
traducao(due, dois ).
traducao(tre, tres ).
traducao(quattro, quatro).
traducao(cinque, cinco ).
traducao(sei, seis ).
traducao(sette, sete ).
traducao(otto, oito ).
traducao(nove, nove).

traduz_lista(A,[A|_]).
traduz_lista(A,[_|B]):-
    traduz_lista(A,B).

/*
?- traduz_lista([uno, nove, due], Pt).
Pt = [um,nove,dois]


?- traduz_lista(It, [um, sete, seis, dois]).
It = [uno,sette,sei,due].

 */
