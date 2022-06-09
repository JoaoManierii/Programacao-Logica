
aprecia(vicente,X) :- bigKahunaBurger(X), !, fail.
aprecia(vicente,X):- hamburguer(X).
hamburguer(X) :- bigMac(X).
hamburguer(X) :- bigKahunaBurger(X).
hamburguer(X) :- whopper(X).
bigMac(a). 
bigKahunaBurger(b).
bigMac(c).
whopper(d).
 

 aprecia(vicente,X) :- 
    hamburguer(X), 
    not(bigKahunaBurger(X)).
hamburguer(X) :- bigMac(X).
hamburguer(X) :- bigKahunaBurger(X).
hamburguer(X) :- whopper(X).
bigMac(a). 
bigKahunaBurger(b).
bigMac(c).
whopper(d). 


aprecia(vicente,X) :- 
    hamburguer(X), 
    \+ bigKahunaBurger(X).

hamburguer(X) :- bigMac(X).
hamburguer(X) :- bigKahunaBurger(X).
hamburguer(X) :- whopper(X).
bigMac(a). 
bigKahunaBurger(b).
bigMac(c).
whopper(d).