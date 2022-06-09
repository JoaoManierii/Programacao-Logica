/*Ex 14*/

bin_para_dec([A], C) :- 
    C is mod(A, 2).

/*
?- bin_para_dec([1, 1, 1, 1, 0, 1, 1], N).
N = 123

?- bin_para_dec([1, 1, 1, 0, 1, 0, 0, 0, 1, 1], N).
N = 931
*/