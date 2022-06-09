/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/convidado',[]).

/*
   GET api/v1/convidados/
   Retorna uma lista com todos os convidados.
*/ 

convidados(get, '', _Pedido):- !,
    envia_tabela_convidados.

/*
   GET api/v1/convidados/Id
   Retorna o `convidado` com Id 1 ou erro 404 caso o `convidado` não
   seja encontrado.
*/
convidados(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_convidados(Id).

/*
   POST api/v1/convidados
   Adiciona um novo convidado. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
convidados(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_convidados(Dados).

/*
  PUT api/v1/convidados/Id
  Atualiza o convidado com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
convidados(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_convidados(Dados, Id).

/*
   DELETE api/v1/convidados/Id
   Apaga o convidado com o Id informado
*/
convidados(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    convidado:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

convidados(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_convidados( _{ convidado_id:IdConv, nome:Nome, rg_cpf:RgCpf}):-
    % Validar URL antes de inserir
    convidado:insere(Id, IdConv, Nome,RgCpf)
    -> envia_convidados(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_convidados( _{ convidado_id:IdConv, nome:Nome, rg_cpf:RgCpf}, Id):-
       convidado:atualiza(Id, IdConv, Nome,RgCpf)
    -> envia_convidados(Id)
    ;  throw(http_reply(not_found(Id))).


envia_convidados(Id):-
       convidado:convidado(Id, IdConv, Nome,RgCpf)
    -> reply_json_dict( _{id:Id, convidado_id:IdConv, nome:Nome,rg_cpf:RgCpf} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_convidados :-
    findall( _{id:Id, convidado_id:IdConv, nome:Nome, rg_cpf:RgCpf},
             convidado:convidado(Id,IdConv, Nome,RgCpf),
             Tuplas ),
    reply_json_dict(Tuplas).