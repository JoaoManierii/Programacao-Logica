:- module(
       convidado,
       [convidado/3]
   ).

:- use_module(library(persistency)).

:- persistent
   convidado(convidado_id:positive_integer,
             nome:atom,
             rg_cpf: positive_integer
   ).

:- initialization(db_attach('tbl_convidado.pl', [])).

insere(IdConv,Nome,RgCpf):-
    with_mutex(convidado,
               assert_convidado(IdConv,Nome,RgCpf)).

remove(IdConv,Nome,RgCpf):-
    with_mutex(convidado,
               retract_convidado(IdConv,Nome,RgCpf)).

atualiza(IdConv,Nome,RgCpf):-
    with_mutex(convidado,
               (retractall_convidado(IdConv,Nome,RgCpf),
               assert_convidado(IdConv,Nome,RgCpf))).

sincroniza:-
    db_sync(gc(always)).
    //
    :- module(
       convidado,
       [convidado/3]
   ).

:- use_module(library(persistency)).

:- persistent
   convidado(convidado_id:positive_integer,
             nome:atom,
             rg_cpf: positive_integer
   ).

:- initialization(db_attach('tbl_convidado.pl', [])).