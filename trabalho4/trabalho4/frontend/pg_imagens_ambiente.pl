:- module(
       pg_imagens_ambiente,
       [
         lista/1,
         cadastro/1,
         editar/2
       ]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- use_module('E:/Prolog/trabalho4/backend/bd/imagens_ambiente', []).



lista(_):-
    reply_html_page(
        boot5rest,
        [ title('imagens_ambiente')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
              	\html_requires(css('custom.css')),
                \html_requires(js('trabalho4.js')),
                \tabela_de_imagens_ambiente,
                \retorna_home
              ])
              ]).

tabela_de_imagens_ambiente -->
    html(div(class('container-fluid py-3'),
             [ \cabeca_da_tabela('Imagens_ambiente', 'imagens_ambiente/cadastro'),
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
                    th([scope(col)], 'ID Imagem'),
                    th([scope(col)], 'Id Ambiente'),
                    th([scope(col)], 'Imagem e ambiente')
                  ]))).



corpo_tabela -->
    {
        findall( tr([th(scope(row), Id), td(Id_imagem), td(Id_ambiente), td(Ima_end_imagem), td(Acoes)]),
                 linha(Id,Id_imagem,Id_ambiente,Ima_end_imagem,Acoes),
                 Linhas )
    },
    html(Linhas).


linha(Id,Id_imagem,Id_ambiente,Ima_end_imagem,Acoes):-
    imagens_ambiente:imagens_ambiente(Id,Id_imagem,Id_ambiente,Ima_end_imagem),
    acoes(Id,Acoes).
  
acoes(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/imagens_ambiente/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/imagens_ambientes/~w' - Id),
                  onClick("apagar( event, '/dadosimagens_ambiente' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ]. 

/* Página de cadastro de imagens_ambiente */
cadastro(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Imagens_ambiente')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Imagens Ambientes '),
                \form_imagens_ambiente
              ]) ]).

form_imagens_ambiente -->
    html(form([ id('imagens_ambiente-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/imagens_ambientes/') ],
              [ \metodo_de_envio('POST'),
                \campo(id, 'ID imagens ambiente', text),
                \campo(id_imagem, 'ID Imagem', text),
                \campo(id_ambiente, 'ID Ambiente', text),
                \campo( ima_end_imagem, 'Imagem', text),
                \enviar_ou_cancelar('/dadosimagens_ambiente')
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



/* Página para edição (alteração) de um imagens_ambiente  */

editar(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( imagens_ambiente:imagens_ambiente(Id,Id_imagem,Id_ambiente,Ima_end_imagem)
    ->
    reply_html_page(
        boot5rest,
        [ title('imagens_ambiente')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Meus imagens_ambiente'),
                \form_imagens_ambiente(Id,Id_imagem,Id_ambiente,Ima_end_imagem)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_imagens_ambiente(Id,Id_imagem,Id_ambiente,Ima_end_imagem) -->
    html(form([ id('imagens_ambiente-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/imagens_ambientes/~w' - Id) ],
              [ \metodo_de_envio('POST'),
                \campo(id, 'ID imagens ambiente', text,Id),
                \campo(id_imagem, 'Id Imagem', text,Id_imagem),
                \campo(id_ambiente, 'Id Ambiente', text,Id_ambiente),
                \campo(ima_end_imagem, 'Imagem', text,Ima_end_imagem),
                \enviar_ou_cancelar('/dadosimagens_ambiente')
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

lixeira-->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-tIdsh'),
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