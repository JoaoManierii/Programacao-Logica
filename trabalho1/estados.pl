:- module(
       estados,
       [estados/3]
   ).

:- use_module(library(persistency)).

:- persistent
   estados(estados_id:positive_integer,
             est_uf:atom,
             est_estado: atom
   ).

:- initialization(db_attach('tbl_estados.pl', [])).

insere(Id_estad,Uf,Estado):-
    with_mutex(estados,
               assert_estados(Id_estad,Uf,Estado)).

remove(Id_estad,Uf,Estado):-
    with_mutex(estados,
               retract_estados(Id_estad,Uf,Estado)).

atualiza(Id_estad,Uf,Estado):-
    with_mutex(estados,
               (retractall_estados(Id_estad,Uf,Estado),
               assert_estados(Id_estad,Uf,Estado))).

sincroniza:-
    db_sync(gc(always)).
    