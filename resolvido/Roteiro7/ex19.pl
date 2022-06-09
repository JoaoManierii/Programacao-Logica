/*ex19*/
max(X,Y,Y):- X=<Y.
max(X,Y,X):- X>Y.

maxx(X,Y,Y):- X =< Y, !.
maxx(X,Y,X):- X>Y.

maxxx(X,Y,Y):- X =< Y, !.
maxxx(X,_Y,X).


maxz(X,Y,Z):- X =< Y, !, Y = Z.
maxz(X,_Y,X).