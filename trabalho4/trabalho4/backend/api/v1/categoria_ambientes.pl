/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/categoria_ambiente',[]).

/*
   GET api/v1/categoria_ambiente/
   Retorna uma lista com todos os categoria_ambiente.
*/
categoria_ambientes(get, '', _Pedido):- !,
    envia_tabela_categoria_ambientes.

/*
   GET api/v1/categoria_ambiente/Id
   Retorna o `categoria_ambiente` com Id 1 ou erro 404 caso o `categoria_ambiente` não
   seja encontrado.
*/
categoria_ambientes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_categoria_ambientes(Id).

/*
   POST api/v1/categoria_ambiente
   Adiciona um novo categoria_ambiente. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
categoria_ambientes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_categoria_ambientes(Dados).

/*
  PUT api/v1/categoria_ambiente/Id
  Atualiza o categoria_ambiente com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
categoria_ambientes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_categoria_ambientes(Dados, Id).

/*
   DELETE api/v1/categoria_ambiente/Id
   Apaga o categoria_ambiente com o Id informado
*/
categoria_ambientes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    categoria_ambiente:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

categoria_ambientes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_categoria_ambientes( _{  
            id_categoria_ambiente:Id_categoria_amb,
            cat_desc_categoria_ambiente:Categoria_desc_categoria_ambiente,
            cat_end_imagem:Categoria_end_imagem }):-
    % Validar URL antes de inserir
    categoria_ambiente:insere(Id, Id_categoria_amb, Categoria_desc_categoria_ambiente,Categoria_end_imagem)
    -> envia_categoria_ambientes(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_categoria_ambientes( _{
            id_categoria_ambiente:Id_categoria_amb,
            cat_desc_categoria_ambiente:Categoria_desc_categoria_ambiente,
            cat_end_imagem:Categoria_end_imagem}, Id):-
       categoria_ambiente:atualiza(Id, Id_categoria_amb, Categoria_desc_categoria_ambiente,Categoria_end_imagem)
    -> envia_categoria_ambientes(Id)
    ;  throw(http_reply(not_found(Id))).


envia_categoria_ambientes(Id):-
       categoria_ambiente:categoria_ambiente(Id, Id_categoria_amb, Categoria_desc_categoria_ambiente,Categoria_end_imagem)
    -> reply_json_dict( _{id: Id,
            id_categoria_ambiente:Id_categoria_amb,
            cat_desc_categoria_ambiente:Categoria_desc_categoria_ambiente,
            cat_end_imagem:Categoria_end_imagem} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_categoria_ambientes:-
    findall( _{id: Id,
            id_categoria_ambiente:Id_categoria_amb,
            cat_desc_categoria_ambiente:Categoria_desc_categoria_ambiente,
            cat_end_imagem:Categoria_end_imagem},
             categoria_ambiente:categoria_ambiente(Id, Id_categoria_amb, Categoria_desc_categoria_ambiente,Categoria_end_imagem),
             Tuplas ),
    reply_json_dict(Tuplas).