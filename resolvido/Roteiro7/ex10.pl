/*ex10*/
separa(_,[],[]).
separa(M,[H|T],[H|U1],U2):- H =< M.
separa(M,T,U1,U2).
separa(M,[H|T],U1,[H|U2]):- H > M.
separa(M,T,U1,U2).
/*
?- separa([3,4,-5,-1,0,4,-9],P,N).
P = [3,4,0,4]
N = [-5,-1,-9]...
*/