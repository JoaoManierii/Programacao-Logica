/*ex2*/
pais(alemanha, europa, 83, [franca, belgica, holanda, suica]).
pais(australia, oceania, 25, []).
pais(belgica, europa, 11, [franca, holanda, alemanha]).
pais(espanha, europa, 47, [portugal, franca]).
pais(franca, europa, 67, [espanha, suica, belgica, alemanha,italia]).
pais(holanda, europa, 17, [belgica, alemanha]).
pais(indonesia, oceania, 268, []).
pais(italia, europa, 60, [franca, suica]).
pais(madagascar, africa, 26, []).
pais(portugal, europa, 10, [espanha]).
pais(suica, europa, 8, [franca, alemanha, italia]).


isolado_grande(Pais, Continente):- 
pais(Pais, Continente, Pop, Fron), 
Pop > 15, 
length(Fron, A), 
A < 3.

isolados_grandes(Result):- 
findall(Continente, (isolado_grande(Pais1, Continente), isolado_grande(Pais2, Continante) , Pais1 \= Pais2), Lista), 
sort(Lista, Result).

/*
?- isolados_grandes(Lista).
Lista = [europa, oceania].
*/
