/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/reservas_cancelada', []).

/*
   GET api/v1/reservas_canceladas/
   Retorna uma lista com todos os reservas_canceladas.
*/
reservas_canceladas(get, '', _Pedido):- !,
    envia_tabela_reservas_canceladas.

/*
   GET api/v1/reservas_canceladas/Id
   Retorna o `reservas_cancelada` com Id 1 ou erro 404 caso o `reservas_cancelada` não
   seja encontrado.
*/
reservas_canceladas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_reservas_canceladas(Id).

/*
   POST api/v1/reservas_canceladas
   Adiciona um novo reservas_cancelada. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
reservas_canceladas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_reservas_canceladas(Dados).

/*
  PUT api/v1/reservas_canceladas/Id
  Atualiza o reservas_cancelada com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
reservas_canceladas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_reservas_canceladas(Dados, Id).

/*
   DELETE api/v1/reservas_canceladas/Id
   Apaga o reservas_cancelada com o Id informado
*/
reservas_canceladas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    reservas_cancelada:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

reservas_canceladas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_reservas_canceladas( _{ id_res_cancel: IdRes,
            reC_data: Data,
            reC_hora: Hora,
            reC_id_ambiente: IdAmb,
            reC_id_usuario: IdUs,
            reC_justificativa: Just,
            reC_datetime: DateTime,
            reC_user_exclusao: UsExcl}):-
    % Validar URL antes de inserir
    reservas_cancelada:insere(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)
    -> envia_reservas_canceladas(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_reservas_canceladas( _{ id_res_cancel: IdRes,
            reC_data: Data,
            reC_hora: Hora,
            reC_id_ambiente: IdAmb,
            reC_id_usuario: IdUs,
            reC_justificativa: Just,
            reC_datetime: DateTime,
            reC_user_exclusao: UsExcl}, Id):-
       reservas_cancelada:atualiza(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)
    -> envia_reservas_canceladas(Id)
    ;  throw(http_reply(not_found(Id))).


envia_reservas_canceladas(Id):-
       reservas_cancelada:reservas_cancelada(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)
    -> reply_json_dict( _{id:Id,id_res_cancel: IdRes,
            reC_data: Data,
            reC_hora: Hora,
            reC_id_ambiente: IdAmb,
            reC_id_usuario: IdUs,
            reC_justificativa: Just,
            reC_datetime: DateTime,
            reC_user_exclusao: UsExcl} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_reservas_canceladas:-
    findall( _{id:Id, id_res_cancel: IdRes,
            reC_data: Data,
            reC_hora: Hora,
            reC_id_ambiente: IdAmb,
            reC_id_usuario: IdUs,
            reC_justificativa: Just,
            reC_datetime: DateTime,
            reC_user_exclusao: UsExcl},
             reservas_cancelada:reservas_cancelada(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl),
             Tuplas ),
    reply_json_dict(Tuplas).