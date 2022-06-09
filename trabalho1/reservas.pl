- module(
       reservas,
       [reservas/10]
   ).

:- use_module(library(persistency)).

:- persistent
   reservas(
            id_reserva: integer,
			id_ambiente:integer,
			data_reserva:atom,
			hora_reserva:atom,
			id_usuario: positive_integer,
            res_descricao: atom,
			res_datetime: atomic,
			res_user_inclusao:atom,
			res_data_alteracao:atomic,
			res_user_alteracao:atom
   ).

:- initialization(db_attach('tbl_reservas.pl', [])).

insere(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte):-
    with_mutex(reservas,
               assert_reservas(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte)).

remove(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte):-
    with_mutex(reservas,
               retract_reservas(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte)).

atualiza(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte):-
    with_mutex(reservas,
               (retractall_reservas(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte),
               assert_reservas(IdRes,IdAmb,DataRes,HoraRes,Idusu,ResDesc,ResDate,ResUderincl,ResDataalte,ResUserAlte))).

sincroniza:-
    db_sync(gc(always)).