/*ex21*/
nu([], _, []).
nu([A|B], Termo, [A|C]) :- 
    \+(\+ (A = Termo)),
    nu(B, Termo, C).

nu([A|B], Termo, C) :-
    \+ A = Termo, 
    nu(B, Termo, C).
/*
?- nu(foo,foo).
false
?- nu(foo,blob).
true
?- nu(foo,X).
false
*/