/*ex4*/

/*
?- subformula(~ q, (p => q) <=> (~ q => ~ p) ).
true
?- subformula(q, (p => q) <=> (~ q => ~ p) ).
true
?- subformula(~ q => ~ p, (p => q) <=> (~ q => ~ p) ).
true
?- subformula(r, (p => q) <=> (~ q => ~ p) ).
false
?- subformula(~ q => p, (p => q) <=> (~ q => ~ p) ).
false
*/