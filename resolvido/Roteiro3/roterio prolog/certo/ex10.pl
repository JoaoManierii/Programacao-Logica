/*Ex10*/
inverte([], A, A).
inverte([B|Bs], A, C) :-
    inverte(Bs, [B|A],C). 
inverte(D, A) :-
    inverte(D, [], A). 
palindromo(D, D).
palindromo(D) :-
    inverte(D, D).


/*
?- palindromo([r,o,d,a,d,o,r]).
true
?- palindromo([a,d,r,o,g,a,d,a,g,o,r,d,a]).
true
?- palindromo([e,s,s,e,n,a,o]).
false
?- palindromo([s,o,c,o,r,r,a,m,e,s,u,b,i,n,o,o,n,i,b,u,s,e,m,m,a,r,r,o,c,o,s]).
True
?- palindromo([a,n,o,t,a,r,a,m,a,d,a,t,a,d,a,m,a,r,a,t,o,n,a])
True.
?- palindromo([a,d,r,o,g,a,d,a,g,o,r,d,a]).
True
?- palindromo([a,m,a,l,a,n,a,d,a,n,a,l,a,m,a]).
True
?- palindromo([a,t,o,r,r,e,d,a,d,e,r,r,o,t,a]).
True
*/
