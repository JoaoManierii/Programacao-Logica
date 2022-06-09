:- module(
       imagens_ambiente,
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
   imagens_ambiente(
            id: positive_integer,
            id_imagem:string,
            id_ambiente:string,
            ima_end_imagem:string 
   ).

:- initialization( at_halt(db_sync(gc(always))) ).

carrega_tab(ArqTabela):- 
        db_attach(ArqTabela,[]).

insere(Id,Id_img,Id_amb,Ima_end_img):-
    chave:pk(imagens_ambiente,Id),
    with_mutex(imagens_ambiente,
               assert_imagens_ambiente(Id,Id_img,Id_amb,Ima_end_img)).

remove(Id):-
    with_mutex(imagens_ambiente,
               retractall_imagens_ambiente(Id,_Id_img,_Id_amb,_Ima_end_img)).

atualiza(Id,Id_img,Id_amb,Ima_end_img):-
    with_mutex(imagens_ambiente,
               (retract_imagens_ambiente(Id,_Id_img,_Id_amb,_Ima_end_img),
               assert_imagens_ambiente(Id,Id_img,Id_amb,Ima_end_img))).

