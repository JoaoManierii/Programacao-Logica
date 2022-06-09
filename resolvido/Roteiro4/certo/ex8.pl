/*Ex 8*/
r(V)-->romano(V1),r(V2),{V = V1+V2}.
r(0)-->[].
decimal_(X,V):-atom_chars(X,L),r(V,L,[]),!.
romano(1000)-->['M'].
romano(900)-->['C'],['M'].
romano(500)-->['D'].
romano(400)-->['C'],['D'].
romano(100)-->['C'].
romano(90)-->['X'],['C'].
romano(50)-->['L'].
romano(40)-->['X'],['L'].
romano(10)-->['X'].
romano(9)-->['I'],['X'].
romano(5)-->['V'].
romano(4)-->['I'],['V'].
romano(1)-->['I'].

/*
?- romano(21, R).
R = ['X', 'X', 'I']

?- romano(800, R).
R = ['D', 'C', 'C', 'C']

?- romano(2021, R).
R = ['M', 'M', 'X', 'X', 'I']

*/