intercala1([],A,A).
intercala1(B,[],B).
intercala1([B|Bs],[A|As],[B,A|C]) :-
    intercala1(Bs, As, C).