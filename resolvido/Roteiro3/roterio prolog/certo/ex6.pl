/*Ex6*/
intercala3([],Y,Y).
intercala3(X,[],X).
intercala3([X|Xs],[Y|Ys],[junta(X,Y)|Z]) :-
    intercala3(Xs, Ys, Z).

/*
?- intercala3([a,b,c],[1,2,3],X).
X = [junta(a,1), junta(b,2), junta(c,3)]

?- intercala3([fu,ba,yip,yup],[glub,glab,glib,glob],Res).
Res = [junta(fu,glub), junta(ba,glab), junta(yip,glib),
junta(yup,glob)]
*/