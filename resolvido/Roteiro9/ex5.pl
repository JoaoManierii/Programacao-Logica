/*ex5*/

/*
?- tautologia( p <=> ~ ~ p ).
true
?- tautologia( p v ~ p ).
true
?- tautologia( p => p v q ).
true
?- tautologia( (p => q) <=> (~ q => ~ p) ).
true
?- tautologia( p & ~ p ).
false
*/