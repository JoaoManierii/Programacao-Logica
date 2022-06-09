:- module(
       imagens_ambiente,
       [imagens_ambiente/3]
   ).

:- use_module(library(persistency)).

:- persistent
   imagens_ambiente(
            id_imagem:integer,
            id_ambiente:integer,
            ima_end_imagem:atom 
   ).

:- initialization(db_attach('tbl_categoria_ambiente.pl', [])).

insere(Id_img,Id_amb,Ima_end_img):-
    with_mutex(imagens_ambiente,
               assert_imagens_ambiente(Id_img,Id_amb,Ima_end_img)).

remove(Id_img,Id_amb,Ima_end_img):-
    with_mutex(imagens_ambiente,
               retract_imagens_ambiente(Id_img,Id_amb,Ima_end_img)).

atualiza(Id_img,Id_amb,Ima_end_img):-
    with_mutex(imagens_ambiente,
               (retractall_imagens_ambiente(Id_img,Id_amb,Ima_end_img),
               assert_imagens_ambiente(Id_img,Id_amb,Ima_end_img))).

sincroniza:-
    db_sync(gc(always)).
