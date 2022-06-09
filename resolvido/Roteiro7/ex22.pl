/*ex22*/
unificavel([], _, []).
unificavel([A|B], Termo, [A|C]) :- 
    \+(\+ (A = Termo)),
    unificavel(B, Termo, C).

unificavel([A|B], Termo, C) :-
    \+ A = Termo, 
    unificavel(B, Termo, C).

/*
?- unificavel([X,b,t(Y)],t(a),Lista).
Lista = [X,t(Y)].
*/