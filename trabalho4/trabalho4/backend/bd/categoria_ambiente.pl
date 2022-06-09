:- module(
       categoria_ambiente,
       [carrega_tab/1,
       insere/4,
       remove/1,
       atualiza/4
       ]
   ).

:- use_module(library(persistency)).

:- use_module(chave, []).

:- persistent
   categoria_ambiente(
            id: positive_integer,
            id_cat_amb:string,
            cat_desc_cat_amb:string,
            cat_end_img:string 
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,Id_cat_amb,Cat_desc_cat_amb,Cat_end_img):-
    chave:pk(categoria_ambiente,Id),
    with_mutex(categoria_ambiente,
               assert_categoria_ambiente(Id,Id_cat_amb,Cat_desc_cat_amb,Cat_end_img)).

remove(Id):-
    with_mutex(categoria_ambiente,
               retractall_categoria_ambiente(Id,_Id_cat_amb,_Cat_desc_cat_amb,_Cat_end_img)).

atualiza(Id,Id_cat_amb,Cat_desc_cat_amb,Cat_end_img):-
    with_mutex(categoria_ambiente,
               (retract_categoria_ambiente(Id,_Id_cat_amb,_Cat_desc_cat_amb,_Cat_end_img),
               assert_categoria_ambiente(Id,Id_cat_amb,Cat_desc_cat_amb,Cat_end_img))).
