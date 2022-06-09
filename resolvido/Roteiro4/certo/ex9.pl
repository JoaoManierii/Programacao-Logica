/*Ex 9*/
remove(A,[A|B], B).
remove(A, [C|B], [C|B1]):-
    remove(A,B,B1).

permutacao([],[]).
permutacao(Es,[D|Fs]):-
    remove(D,Es,Ds),
    permutacao(Ds,Fs).


/*
a)
*/
disjunto([],[]).
disjunto([B|Bs], [A|As]) :-
    \+ member(B, [A|As]),
    \+ member(A, [B|Bs]),
    disjunto(As, As).

/*
?- disjunto([1,3,5],[2,4,6]).
true
?- disjunto([1,3,5],[2,4,5]).
false
*/

/*
b)
*/
uniao([],A,A).
uniao(A, [], A).
uniao([B|C],A,D):-
    member(B, A),
    uniao(C,A,D).

/*
?- uni~ao([1,3,5],[2,4,6],[1,3,2,4,6,5]).
true
?- uni~ao([1,3,5],[2,4,5],[1,3,2,4,6,5]).
false
*/

/*
c)
*/
intersecao([],_,[]).
intersecao([X|L],L1,[X|L2]) :- 
	member(X,L1),!,
	intersecao(L,L1,L2).
	
intersecao([_|L],L1,L2):-
	intersecao(L,L1,L2).

/*
?- intersecao([1,3,5],[2,4,6],[]).
true
?- intersecao([1,3,5],[2,4,5],[5]).
true
?- intersecao([1,3,5],[2,4,5],[5,6]).
false
*/
/*
d)
*/
diferenca([],_,[]).
diferenca([X|A],B,[X|D]) :- 
	not(member(X,B)), 
	diferenca(A,B,D).
	
diferenca([_|A],B,D) :- 
	diferenca(A,B,D).
    
/*
?- diferenca([1,3,5],[2,4,6],[1,3,5]).
true
?- diferenca([1,3,5],[2,4,5],[1,3]).
true
?- diferenca([1,3,5],[1,4,5],[4]).
false
*/

