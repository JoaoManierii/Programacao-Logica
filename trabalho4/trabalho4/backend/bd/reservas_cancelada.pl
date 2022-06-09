:- module(
       reservas_cancelada,
       [
       carrega_tab/1,
       insere/9,
       remove/1,
       atualiza/9]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   reservas_cancelada(
            id: positive_integer,
            id_res_cancel: string,
            reC_data: string,
            reC_hora: string,
            reC_id_ambiente: string,
            reC_id_usuario: string,
            reC_justificativa: string,
            reC_datetime: string,
            reC_user_exclusao: string
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl):-
    chave:pk(reservas_cancelada,Id),
    with_mutex(reservas_cancelada,
               assert_reservas_cancelada(Id,IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)).

remove(Id):-
    with_mutex(reservas_cancelada,
               retractall_reservas_cancelada(Id,_Id,_Data,_Hora,_IdAmb,_IdUs,_Just,_DateTime,_UsExcl)).

atualiza(Id,IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl):-
    with_mutex(reservas_cancelada,
               (retract_reservas_cancelada(Id,_Id,_Data,_Hora,_IdAmb,_IdUs,_Just,_DateTime,_UsExcl),
                assert_reservas_cancelada(Id,IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl))).

