:- module(emprDept, []).

:- use_module(library(persistency)).

:- persistent 
    empresario(id:positive_integer,
        nome:atom,
        departamento:nonneg,
        salario:positive_integer),
    depto(departamento:nonneg,
        nomeDepto:atom,
        id_gerente:positive_integer).

:- initialization(db_attach('tbl_emprEdepto.pl', [])).

insereEmpresario(IdFunc, Nome, Dept, Sal) :-
    with_mutex(key, assert_empresario(IdFunc, Nome, Dept, Sal)).

removeEmpresario(IdFunc) :-
    with_mutex(key, retract_empresario(IdFunc, _Nome, _Dept, _Sal)).

insereDepto(Dept, NomeDept, IdGerente) :-
    emprDep:empresario(IdGerente, _Nome, Dept, _Sal),
    with_mutex(key, assert_depto(Dept, NomeDept, IdGerente)).

sincroniza :-
    db_sync(gc(always)).

/* 
findall((Empr, Sal), 
    (emprDept:empresario(IdFunc, Empr, Dept, Sal), 
    emprDept:empresario(IdGerente, _NomeGerente, Dept, SalG), 
    emprDept:depto(Dept, _NomeDept, IdGerente), 
    Sal > SalG), L).
 */