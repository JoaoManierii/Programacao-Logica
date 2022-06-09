:- module(
       pg_dependente,
       [
        lista/1,
         cadastro/1,
         editar/2
       ]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- use_module('E:/Prolog/trabalho4/backend/bd/dependente', []).

lista(_):-
    reply_html_page(
        boot5rest,
        [ title('dependentes')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
              	 \html_requires(css('custom.css')),
                \html_requires(js('trabalho4.js')),
                \tabela_de_dependentes,
                \retorna_home
              ]) 
              ]).

tabela_de_dependentes -->
    html(div(class('container-fluid py-3'),
             [ \cabeca_da_tabela('Dependentes', 'dependente/cadastro'),
               \tabela
             ]
            )).


cabeca_da_tabela(Titulo,Link) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      'Novo'))
              ]) ).


tabela -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalho,
                     tbody(\corpo_tabela)
                   ]))).

cabecalho -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'ID Usuario'),
                    th([scope(col)], 'ID Dependente'),
                    th([scope(col)], 'Nome'),
                    th([scope(col)], 'Email'),
                    th([scope(col)], 'Data Nascimento'),
                    th([scope(col)], 'Sexo'),
                    th([scope(col)], 'CPF'),
                    th([scope(col)], 'Endereço'),
                    th([scope(col)], 'CEP'),
                    th([scope(col)], 'Bairro'),
                    th([scope(col)], 'Cidade'),
                    th([scope(col)], 'Estado'),
                    th([scope(col)], 'Telefone'),
                    th([scope(col)], 'Login'),
                    th([scope(col)], 'Senha'),
                    th([scope(col)], 'Primeiro Acesso')
                  ]))).



corpo_tabela -->
    {
        findall( tr([th(scope(row), Ra), td(IdUs), td(IdDep), td(Nome), td(Email),td(DataNasc),td(Sexo),td(Cpf),td(Endereco),td(Cep),td(Bairro),td(Cidade),
        td(Estado),td(Tel),td(Login),td(Senha),td(PrimeiroAcesso), td(Acoes)]),
                 linha(Ra, IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,Endereco,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso, Acoes),
                 Linhas )
    },
    html(Linhas).


linha(Ra, IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,Endereco,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso, Acoes):-
    dependente:dependente(Ra, IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,Endereco,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso),
    acoes(Ra,Acoes).
  
acoes(Ra, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/dependente/editar/~w' - Ra),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/dependentes/~w' - Ra),
                  onClick("apagar( event, '/dadosdependente' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ]. 


/* Página de cadastro de dependente */
cadastro(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Dependentes')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Meus dependentes'),
                \form_dependente
              ]) ]).

form_dependente -->
    html(form([ id('dependente-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/dependentes/') ],
              [ \metodo_de_envio('POST'),
                \campo(id_usuario, 'ID Usuario', text),
                \campo(id_dependente, 'ID Dependente', text),
                \campo(dep_nome, 'Nome', text),
                \campo(dep_email, 'Email', text),
                \campo(dep_datanasc, 'Data Nascimento', text),
                \campo(dep_sexo, 'Sexo', text),
                \campo(dep_cpf, 'Cpf', text),
                \campo(dep_endereco, 'Endereco', text),
                \campo(dep_cep, 'CEP', text),
                \campo(dep_bairro, 'Bairro', text),
                \campo(dep_cidade, 'Cidade', text),
                \campo(id_estado, 'Estado', text),
                \campo(dep_telefone, 'Telefone', text),
                \campo(dep_login, 'Login', text),
                \campo(dep_senha, 'Senha', text),
                \campo(dep_primeiroacesso, 'Primeiro Acesso', text),
                \enviar_ou_cancelar('/dadosdependente')
              ])).


enviar_ou_cancelar(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).



campo(Nome, Rotulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Rotulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).



/* Página para edição (alteração) de um dependente  */

editar(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( dependente:dependente(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso)
    ->
    reply_html_page(
        boot5rest,
        [ title('dependentes')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Meus dependentes'),
                \form_dependente(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_dependente(Id,IdUs, IdDep, Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,
    Estado,Tel,Login,Senha,PrimeiroAcesso) -->
    html(form([ id('dependente-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/dependentes/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                \campo(id_usuario, 'ID Usuario', text, IdUs),
                \campo(id_dependente, 'ID Dependente', text,IdDep),
                \campo(dep_nome, 'Nome', text,Nome),
                \campo(dep_email, 'Email', text,Email),
                \campo(dep_datanasc, 'Data Nascimento', text, DataNasc),
                \campo(dep_sexo, 'Sexo', text, Sexo),
                \campo(dep_cpf, 'Cpf', text,Cpf),
                \campo(dep_endereco, 'Endereco', text,End),
                \campo(dep_cep, 'CEP', text,Cep),
                \campo(dep_bairro, 'Bairro', text,Bairro),
                \campo(dep_cidade, 'Cidade', text,Cidade),
                \campo(id_estado, 'Estado', text,Estado),
                \campo(dep_telefone, 'Telefone', text,Tel),
                \campo(dep_login, 'Login', text,Login),
                \campo(dep_senha, 'Senha', text,Senha),
                \campo(dep_primeiroacesso, 'Primeiro Acesso', text,PrimeiroAcesso),
                \enviar_ou_cancelar('/dadosdependente')
              ])).


campo(Nome, Rotulo, Tipo, Valor) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label')], Rotulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome), value(Valor)])
             ] )).

campo_nao_editavel(Nome, Rotulo, Tipo, Valor) -->
    html(div(class('mb-3 w-25'),
             [ label([ for(Nome), class('form-label')], Rotulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome),
                       % name(Nome),%  não é para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

metodo_de_envio(Metodo) -->
    html(input([type(hidden), name('_metodo'), value(Metodo)])).

    
retorna_home --> 
	 html(div(class(row), a([ class(['btn', 'btn-primary']),href('/')],'Voltar para o início') )).



lapis -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-pencil'),
               viewBox('0 0 16 16')
             ],
             path(d(['M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0',
             ' 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5',
             ' 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4',
             ' 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761',
             ' 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5',
             ' 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z']),
                  []))).

lixeira -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-trash'),
               viewBox('0 0 16 16')
             ],
             [ path(d(['M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1',
                       ' .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5',
                       ' 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z']),
                    []),
               path(['fill-rule'(evenodd),
                     d(['M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0',
                        ' 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1',
                        ' 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4',
                        ' 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882',
                        ' 4H4.118zM2.5 3V2h11v1h-11z'])],
                    [])])).