/*ex32*/
triplas([],[]).
triplas([X],[Y]).
triplas([X,Y|Z], [M|N]):- Y is 3*M.
                          triplas([Y|Z],N).
/*
?- triplas(Triplas).
Triplas = [3, 5, 9] ;
Triplas = [3, 1, 6] ;
false
*/
