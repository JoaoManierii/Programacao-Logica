/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module('E:/Prolog/trabalho4/backend/bd/dependente', []).

/*
   GET api/v1/dependentes/
   Retorna uma lista com todos os dependentes.
*/
dependentes(get, '', _Pedido):- !,
    envia_tabela_dependentes.

/*
   GET api/v1/dependentes/Id
   Retorna o `dependente` com Id 1 ou erro 404 caso o `dependente` não
   seja encontrado.
*/
dependentes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_dependentes(Id).

/*
   POST api/v1/dependentes
   Adiciona um novo dependente. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
dependentes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_dependentes(Dados).

/*
  PUT api/v1/dependentes/Id
  Atualiza o dependente com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
dependentes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_dependentes(Dados, Id).

/*
   DELETE api/v1/dependentes/Id
   Apaga o dependente com o Id informado
*/
dependentes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    dependente:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de Metodo não
   permitido será retornada.
 */

dependentes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_dependentes( _{ id_usuario:IdUs,id_dependente:IdDep,
            dep_nome:Nome,
            dep_email:Email,
            dep_datanasc:DataNasc,
            dep_sexo:Sexo,
            dep_cpf:Cpf,
            dep_endereco:End,
            dep_cep:Cep,
            dep_bairro:Bairro,
            dep_cidade:Cidade,
            id_estado:Estado,
            dep_telefone:Tel,
            dep_login:Login,
            dep_senha:Senha,
            dep_primeiroacesso:PrimeiroAcesso }):-
    % Validar URL antes de inserir
    dependente:insere(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso)
    -> envia_dependentes(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_dependentes( _{ id_usuario:IdUs,id_dependente:IdDep,
            dep_nome:Nome,
            dep_email:Email,
            dep_datanasc:DataNasc,
            dep_sexo:Sexo,
            dep_cpf:Cpf,
            dep_endereco:End,
            dep_cep:Cep,
            dep_bairro:Bairro,
            dep_cidade:Cidade,
            id_estado:Estado,
            dep_telefone:Tel,
            dep_login:Login,
            dep_senha:Senha,
            dep_primeiroacesso:PrimeiroAcesso }, Id):-
       dependente:atualiza(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso)
    -> envia_dependentes(Id)
    ;  throw(http_reply(not_found(Id))).


envia_dependentes(Id):-
       dependente:dependente(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso)
    -> reply_json_dict( _{id:Id,id_usuario:IdUs,id_dependente:IdDep,
            dep_nome:Nome,
            dep_email:Email,
            dep_datanasc:DataNasc,
            dep_sexo:Sexo,
            dep_cpf:Cpf,
            dep_endereco:End,
            dep_cep:Cep,
            dep_bairro:Bairro,
            dep_cidade:Cidade,
            id_estado:Estado,
            dep_telefone:Tel,
            dep_login:Login,
            dep_senha:Senha,
            dep_primeiroacesso:PrimeiroAcesso} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_dependentes:-
    findall( _{id:Id, id_usuario:IdUs,id_dependente:IdDep,
            dep_nome:Nome,
            dep_email:Email,
            dep_datanasc:DataNasc,
            dep_sexo:Sexo,
            dep_cpf:Cpf,
            dep_endereco:End,
            dep_cep:Cep,
            dep_bairro:Bairro,
            dep_cidade:Cidade,
            id_estado:Estado,
            dep_telefone:Tel,
            dep_login:Login,
            dep_senha:Senha,
            dep_primeiroacesso:PrimeiroAcesso},
             dependente:dependente(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso),
             Tuplas ),
    reply_json_dict(Tuplas).