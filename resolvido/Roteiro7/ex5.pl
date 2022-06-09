/*ex5*/
:-hora(875,xfx, horas).
:-hora(875,xfx, minutos).
soma_hora([],0).
soma_hora([H|T],S):-soma_hora(T,G),S is H+G.