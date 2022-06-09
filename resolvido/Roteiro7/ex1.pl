/*ex1*/
:-op(875,xfx, fato).
:-op(875,xfx, #).
:-op(825,fx, se).
:-op(850,xfx, entao).
:-op(800,xfy, ou).
:-op(775,xfy, e). 
:-op(750,fy, nao). 
:- op(300, xfx, [sao, e_um]).
:- op(300, fx, gosta_de).
:- op(200, xfy, e).
:- op(100, fy, famoso).
/*
?- X eh_um bruxo. 
res: Bem formado.
    -Operador principal: eh_um()
    -eh_um(_90, bruxo).
?- harry e ron e hermione sao amigos.
res: Bem formado.
    -Operador principal: sao()
    -sao(e(harry,e(ron,hermione)),amigos)
?- harry eh_um mago e gosta_de quadribol.
res: Mal formado.
?- dumbledore eh_um famoso famoso mago. 
res: Bem formado.
    -Operador principal: eh_um()
    -eh_um(dumbledore,famoso(famoso(mago)))
*/
