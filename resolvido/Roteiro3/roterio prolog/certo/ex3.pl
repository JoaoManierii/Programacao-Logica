/*Ex 3*/

tresVezes([A, B], C) :- 
    C is A + A + A + B + B + B.

/*
?- tresVezes([a, 4, bonde],X).
X = [a,a,a,4,4,4,bonde,bonde,bonde].

?- tresVezes([1, 2, 1, 1],X).
X = [1,1,1, 2,2,2, 1,1,1, 1,1,1].
*/