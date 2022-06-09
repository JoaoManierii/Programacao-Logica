/*Ex5*/
intercala2([],A,A).
intercala2(B,[],B).
intercala2([B|Bs],[A|As],[B,A|C]) :-
    intercala2(Bs, As, C).

/*
?- intercala2([a,b,c],[1,2,3],X).
X = [[a,1], [b,2], [c,3]]

?- intercala2([fu,ba,yip,yup],[glub,glab,glib,glob],Res).
Res = [[fu,glub], [ba,glab], [yip,glib], [yup,glob]]
*/