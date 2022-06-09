/*Ex 7*/
ano_bissexto( Ano) :-
(( Ano mod 4 =:= 0, Ano mod 100 =\= 0) ; 
Ano mod 400 =:= 0), !.