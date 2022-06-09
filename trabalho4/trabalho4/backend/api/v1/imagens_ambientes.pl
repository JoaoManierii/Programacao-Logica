/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/imagens_ambiente', []).

/*
   GET api/v1/imagens_ambiente/
   Retorna uma lista com todos os imagens_ambiente.
*/

imagens_ambientes(get, '', _Pedido):- !,
    envia_tabela_imagens_ambientes.

/*
   GET api/v1/imagens_ambiente/Id
   Retorna o `imagens_ambiente` com Id 1 ou erro 404 caso o `imagens_ambiente` não
   seja encontrado.
*/
imagens_ambientes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_imagens_ambientes(Id).

/*
   POST api/v1/imagens_ambiente
   Adiciona um novo imagens_ambiente. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
imagens_ambientes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_imagens_ambientes(Dados).

/*
  PUT api/v1/imagens_ambiente/Id
  Atualiza o imagens_ambiente com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
imagens_ambientes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_imagens_ambientes(Dados, Id).

/*
   DELETE api/v1/imagens_ambiente/Id
   Apaga o imagens_ambiente com o Id informado
*/
imagens_ambientes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    imagens_ambiente:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

imagens_ambientes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_imagens_ambientes( _{
            id_imagem: Id_imagem,
            id_ambiente:Id_ambiente,
            ima_end_imagem:Ima_end_img }):-
    % Validar URL antes de inserir
    imagens_ambiente:insere(Id, Id_imagem,Id_ambiente,Ima_end_img)
    -> envia_imagens_ambientes(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_imagens_ambientes( _{
            id_imagem: Id_imagem,
            id_ambiente:Id_ambiente,
            ima_end_imagem:Ima_end_img}, Id):-
       imagens_ambiente:atualiza(Id, Id_imagem,Id_ambiente,Ima_end_img)
    -> envia_imagens_ambientes(Id)
    ;  throw(http_reply(not_found(Id))).


envia_imagens_ambientes(Id):-
       imagens_ambiente:imagens_ambiente(Id, Id_imagem,Id_ambiente,Ima_end_img)
    -> reply_json_dict( _{id: Id,
            id_imagem: Id_imagem,
            id_ambiente:Id_ambiente,
            ima_end_imagem:Ima_end_img} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_imagens_ambientes:-
    findall( _{id: Id,
            id_imagem: Id_imagem,
            id_ambiente:Id_ambiente,
            ima_end_imagem:Ima_end_img},
            imagens_ambiente:imagens_ambiente(Id, Id_imagem,Id_ambiente,Ima_end_img),
            Tuplas ),
    reply_json_dict(Tuplas).