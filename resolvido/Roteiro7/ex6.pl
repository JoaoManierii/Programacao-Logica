/*ex6*/
:-hora(875,xfx, horas).
:-hora(875,xfx, minutos).
mult_hora([],0).
mult_hora([H|T],S):-mult_hora(T,G),S is H+G.