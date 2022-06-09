/*ex20*/
aprecia(vicente,X):- 
     bigKahunaBurguer(X), !, fail.
aprecia(vicente,X):- hamburguer(X).

hamburguer(X):- bigMac(X).
hamburguer(X):- bigKahunaBurguer(X).
hamburguer(X):- whopper(X).

bigMac(a).
bigMac(c).
bigKahunaBurguer(b).
whopper(d).