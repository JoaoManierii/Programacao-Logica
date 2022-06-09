:- module(
       convidado,
       [
       carrega_tab/1,
       insere/4,
       remove/1,
       atualiza/4
       ]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   convidado(id:positive_integer,
             convidado_id:string,
             nome:string,
             rg_cpf: string
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,IdConv,Nome,RgCpf):-
    chave:pk(convidado,Id),
    with_mutex(convidado,
               assert_convidado(Id,IdConv,Nome,RgCpf)).

remove(Id):-
    with_mutex(convidado,
               retractall_convidado(Id,_IdConv,_Nome,_RgCpf)).

atualiza(Id,IdConv,Nome,RgCpf):-
    with_mutex(convidado,
               (retract_convidado(Id,_IdConv,_Nome,_RgCpf),
               assert_convidado(Id,IdConv,Nome,RgCpf))).