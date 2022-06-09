%a

nu(A, B) :-
    \+ A = B. 
%b

nu(A, B) :-
    A = B, !,
    fail.
nu(_,_). 

%c

nu(A, A) :- !,fail.
nu(_, _). 