/*ex4*/
idade(pedro, 8).
idade(ana, 5).
idade(paula, 8).
idade(ricardo,10).
idade(carla,5).
idade(amanda,12).
idade(sara,15).
/*
(a)
?- findall(X,(idade(X,Y),Y=5),L).
L = [ana, carla].

(b)
?- setof(Y,X^idade(X,Y),L).
L = [5, 8, 10, 12, 15].

(c)
?- setof(X,Y^idade(X,Y),L).
L = [amanda, ana, carla, paula, pedro, ricardo, sara].

(d)
?- findall(X,(idade(X,Y),Y>=8,Y=<12),L).
L = [pedro, paula, ricardo, amanda].
*/