:- module(
       categoria_ambiente,
       [categoria_ambiente/3]
   ).

:- use_module(library(persistency)).

:- persistent
   categoria_ambiente(
            id_categoria_ambiente:integer,
            cat_desc_categoria_ambiente:atom,
            cat_end_imagem:atom 
   ).

:- initialization(db_attach('tbl_categoria_ambiente.pl', [])).

insere(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img):-
    with_mutex(categoria_ambiente,
               assert_categoria_ambiente(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img)).

remove(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img):-
    with_mutex(categoria_ambiente,
               retract_categoria_ambiente(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img)).

atualiza(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img):-
    with_mutex(categoria_ambiente,
               (retractall_categoria_ambiente(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img),
               assert_categoria_ambiente(Id_cat_amb,Cat_desc_cat_amb,Cat_end_img))).

sincroniza:-
    db_sync(gc(always)).