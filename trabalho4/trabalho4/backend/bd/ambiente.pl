:- module(
       ambiente,
       [carrega_tab/1,
       insere/8,
       remove/1,
       atualiza/8]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   ambiente(
            id: positive_integer,
            id_ambiente:string,
            id_categoria_amb: string,
            amb_discricao_ambiente:string,
            amb_hora_inicio:string,
            amb_hora_termino:string,
            amb_tempo_reserva:string,
            amb_qtd_convidados:string
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c):-
    chave:pk(ambiente,Id),
    with_mutex(ambiente,
               assert_ambiente(Id,Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c)).

remove(Id):-
    with_mutex(ambiente,
               retract_ambiente(Id,_Idamb,_Id_cat_amb,_Amb_dsc,_Hora_i,_Hora_t,_Temp_r,_Qtd_c)).

atualiza(Id,Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c):-
    with_mutex(ambiente,
               (retract_ambiente(Id,_Idamb,_Id_cat_amb,_Amb_dsc,_Hora_i,_Hora_t,_Temp_r,_Qtd_c),
               assert_ambiente(Id,Idamb,Id_cat_amb,Amb_dsc,Hora_i,Hora_t,Temp_r,Qtd_c))).

