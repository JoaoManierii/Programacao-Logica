/*ex7*/

/*
?- equivalente_disjuntivo( ~(p & q), ~p v ~q).
true
?- equivalente_disjuntivo( p & q, ~(~p v ~q) ).
true
?- equivalente_disjuntivo( p v q, p v q).
true
?- equivalente_disjuntivo( p => q, ~p v q).
true
?- equivalente_disjuntivo( p <=> q, ~(~p v ~q) v ~(p v q)).
true
?- equivalente_disjuntivo( p => q, ~(p & ~q) ).
false
*/