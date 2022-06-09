/*ex7*/

/*
?- assert(q(a,b)), assertz(q(1,2)), asserta(q(foo,blug)).
true.

?- retract(q(1,2)), assertz( (p(X) :- h(X)) ).
true.

?- retract(q(_,_)),fail.
false.
*/
