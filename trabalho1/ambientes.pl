:- module(
       ambientes,
       [ambientes/7]
   ).

:- use_module(library(persistency)).

:- persistent
   ambientes(
            id_ambientes:positive_integer,
            id_categoria_amb: atom,
            amb_discricao_ambiente:atom,
            amb_hora_inicio:integer,
            amb_hora_termino:integer,
            amb_tempo_reserva:integer,
            amb_qtd_convidados:integer
   ).

:- initialization(db_attach('tbl_ambientes.pl', [])).

insere(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c):-
    with_mutex(ambientes,
               assert_ambientes(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c)).

remove(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c):-
    with_mutex(ambientes,
               retract_ambientes(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c)).

atualiza(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c):-
    with_mutex(ambientes,
               (retractall_ambientes(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c),
               assert_ambientes(Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c))).

sincroniza:-
    db_sync(gc(always)).