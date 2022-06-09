- module(
       reservas_has_convidados,
       [reservas_has_convidados/6]
   ).

:- use_module(library(persistency)).

:- persistent
   reservas_has_convidados(
         reservas_usuario_id_reserva: integer,			
			reservas_hora_reserva: atom,
			reservas_data_reserva: atom,
			reservas_ambientes_id_ambiente: positive_integer,
			reservas_id_reserva: integer,
			convidados_id_convidado: integer
   ).

:- initialization(db_attach('tbl_reservas_has_convidados.pl', [])).

insere(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv):-
    with_mutex(reservas_has_convidados,
               assert_reservas_has_convidados(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv)).

remove(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv):-
    with_mutex(reservas_has_convidados,
               retract_reservas_has_convidados(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv)).

atualiza(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv):-
    with_mutex(reservas_has_convidados,
               (retractall_reservas_has_convidados(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv),
               assert_reservas_has_convidados(ResUsuIdRes,ResHoraRes,ResDataRes,ResAmIdAm,ResIdRes,CovIdConv))).

sincroniza:-
    db_sync(gc(always)).