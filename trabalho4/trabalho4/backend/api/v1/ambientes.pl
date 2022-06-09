/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/ambiente', []).

/*
   GET api/v1/ambientes/
   Retorna uma lista com todos os ambientes.
*/

ambientes(get, '', _Pedido):- !,
    envia_tabela_ambientes.

/*
   GET api/v1/ambientes/Id
   Retorna o `ambientes` com Id 1 ou erro 404 caso o `ambientes` não
   seja encontrado.
*/
ambientes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_ambientes(Id).

/*
   POST api/v1/ambientes
   Adiciona um novo ambientes. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
ambientes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_ambientes(Dados).

/*
  PUT api/v1/ambientes/Id
  Atualiza o ambientes com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
ambientes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_ambientes(Dados, Id).

/*
   DELETE api/v1/ambientes/Id
   Apaga o ambientes com o Id informado
*/
ambientes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    ambiente:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

ambientes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_ambientes( _{ 
            id_ambiente:Id_ambiente,
            id_categoria_amb: Id_categoria,
            amb_discricao_ambiente:Driscicao_ambiente,
            amb_hora_inicio:Hora_inicio,
            amb_hora_termino:Hora_termino,
            amb_tempo_reserva:Tempo_de_reserva,
            amb_qtd_convidados: Ambiente_quantidade_convidados}):-
    % Validar URL antes de inserir
    ambiente:insere(Id,Id_ambiente,Id_categoria,Driscicao_ambiente,Hora_inicio,Hora_termino,Tempo_de_reserva,Ambiente_quantidade_convidados)
    -> envia_ambientes(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_ambientes( _{
            id_ambiente:Id_ambiente,
            id_categoria_amb: Id_categoria,
            amb_discricao_ambiente:Driscicao_ambiente,
            amb_hora_inicio:Hora_inicio,
            amb_hora_termino:Hora_termino,
            amb_tempo_reserva:Tempo_de_reserva,
            amb_qtd_convidados: Ambiente_quantidade_convidados }, Id):-
       ambiente:atualiza(Id,Id_ambiente,Id_categoria,Driscicao_ambiente,Hora_inicio,Hora_termino,Tempo_de_reserva,Ambiente_quantidade_convidados)
    -> envia_ambientes(Id)
    ;  throw(http_reply(not_found(Id))).


envia_ambientes(Id):-
       ambiente:ambiente(Id,Id_ambiente,Id_categoria,Driscicao_ambiente,Hora_inicio,Hora_termino,Tempo_de_reserva,Ambiente_quantidade_convidados)
    -> reply_json_dict( _{id: Id,
            id_ambiente:Id_ambiente,
            id_categoria_amb: Id_categoria,
            amb_discricao_ambiente:Driscicao_ambiente,
            amb_hora_inicio:Hora_inicio,
            amb_hora_termino:Hora_termino,
            amb_tempo_reserva:Tempo_de_reserva,
            amb_qtd_convidados: Ambiente_quantidade_convidados} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_ambientes:-
    findall( _{id: Id,
            id_ambiente:Id_ambiente,
            id_categoria_amb: Id_categoria,
            amb_discricao_ambiente:Driscicao_ambiente,
            amb_hora_inicio:Hora_inicio,
            amb_hora_termino:Hora_termino,
            amb_tempo_reserva:Tempo_de_reserva,
            amb_qtd_convidados: Ambiente_quantidade_convidados},
             ambiente:ambiente(Id,Id_ambiente,Id_categoria,Driscicao_ambiente,Hora_inicio,Hora_termino,Tempo_de_reserva,Ambiente_quantidade_convidados),
             Tuplas ),
    reply_json_dict(Tuplas).