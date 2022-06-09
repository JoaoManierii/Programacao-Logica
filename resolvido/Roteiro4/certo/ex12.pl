/*Ex 12*/

primos( N, ListaPrimos) :-
N > 1,
intervalo (2, N, Lista ),
Parada is int ( sqrt ( N)), 
crivo( Lista , Parada, ListaPrimos),!.
crivo ([ H| T], Parada,[ H| T]) :-
H > Parada,!.
crivo ([ H| T], Parada,[ H| R]) :-
remove_multiplos( H, T, NovoT),
crivo( NovoT, Parada, R)