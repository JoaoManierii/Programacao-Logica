/*Ex 6*/
replica([H], [R], P):- P is H * R, !.
replica([H|T], [R|S], P):- replica([H],[R],M), replica(T,S,U), P is M + U.
/*
?- replica([a, b, c], 4, R).
R = [a, a, a, a, b, b, b, b, c, c, c, c]
*/