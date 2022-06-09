/*Ex 13*/

dec_para_bin([A], C) :- 
    C is mod(A, 2).

/*
?- dec_para_bin(123, Bin).
Bin = [1, 1, 1, 1, 0, 1, 1]
*/