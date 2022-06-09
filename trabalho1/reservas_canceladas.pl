:- module(
       reservas_canceladas,
       [reservas_canceladas/8]
   ).

:- use_module(library(persistency)).

:- persistent
   reservas_canceladas(
            id_res_cancel: integer,
            reC_data: atom,
            reC_hora: atom,
            reC_id_ambiente: integer,
            reC_id_usuario: integer,
            reC_justificativa: atom,
            reC_datetime: atom,
            reC_user_exclusao: atom
   ).

:- initialization(db_attach('tbl_reservas_canceladas.pl', [])).

insere(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl):-
    with_mutex(reservas_canceladas,
               assert_reservas_canceladas(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)).

remove(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl):-
    with_mutex(reservas_canceladas,
               retract_reservas_canceladas(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)).

remove(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl):-
    with_mutex(reservas_canceladas,
               (retractall_reservas_canceladas(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl),
                assert_reservas_canceladas(Id,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl))).

sincroniza :-
    db_sync(gc(always)).