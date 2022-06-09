/*ex12*/
f(X) :- !,X=p.
f(X) :- !,X=q.
f(X) :- X = r.
/*
?- f(p).
true.

?- f(q).
false.

?- f(r).
false.

?- f(X).
X = p.
*/