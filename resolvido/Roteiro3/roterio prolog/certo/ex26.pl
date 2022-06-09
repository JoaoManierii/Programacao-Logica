/*Ex26*/
fatorial(0, 1).
fatorial(A, B) :-
    C is A - 1,
    C >= 0,
    fatorial(C, Bs),
     B is Bs * A.
narranjos(M,P,N) :-
    fatorial(M, ResM),
    C is M - P,
    fatorial(C, ResC),
    N is ResM/ResC.