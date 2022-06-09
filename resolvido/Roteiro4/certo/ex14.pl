/*Ex 14*/
fatdup(N, S) :- 
	N > 0,
	N2 is N - 2,
	fatdup(N2, F),
	S is N * F. 
/*
?- fatdup(5,F).
F = 15
*/