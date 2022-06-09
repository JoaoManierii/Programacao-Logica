:- module(
       pg_reservas_cancelada,
       [
        lista/1,
         cadastro/1,
         editar/2
       ]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).


:- use_module('E:/Prolog/trabalho4/backend/bd/reservas_cancelada', []).

lista(_):-
    reply_html_page(
        boot5rest,
        [ title('reservas_canceladas')],
        [ div(class(container),
              [ \html_requires(css('entrada.css')),
              	 \html_requires(css('custom.css')),
                \html_requires(js('trabalho4.js')),
                \tabela_de_reservas_canceladas,
                \retorna_home
              ]) ]).

tabela_de_reservas_canceladas -->
    html(div(class('container-fluid py-3'),
             [ \cabeca_da_tabela('reservas_canceladas', 'reservas_cancelada/cadastro'),
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
                    th([scope(col)], 'ID Reserva Cancelada'),
                    th([scope(col)], 'Data'),
                    th([scope(col)], 'Hora'),
                    th([scope(col)], 'ID ambiente'),
                    th([scope(col)], 'ID Usuario'),
                    th([scope(col)], 'Justificativa'),
                    th([scope(col)], 'DateTime'),
                    th([scope(col)], 'Exclusao Usuario')
                  ]))).



corpo_tabela -->
    {
        findall( tr([th(scope(row), Ra), td(Id), td(Data), td(Hora), td(IdAmb),td(IdUs),td(Just),td(DateTime),td(ExclUs), td(Acoes)]),
                 linha(Ra, Id, Data, Hora,IdAmb,IdUs,Just,DateTime,ExclUs, Acoes),
                 Linhas )
    },
    html(Linhas).

linha(Ra, Id, Data, Hora,IdAmb,IdUs,Just,DateTime,ExclUs, Acoes):-
    reservas_cancelada:reservas_cancelada(Ra, Id, Data, Hora, IdAmb, IdUs, Just, DateTime, ExclUs),
    acoes(Ra,Acoes). 
  
acoes(Ra, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/reservas_cancelada/editar/~w' - Ra),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/reservas_canceladas/~w' - Ra),
                  onClick("apagar( event, '/dadosreservas_cancelada' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ]. 


/* Página de cadastro de reservas_cancelada */
cadastro(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Reservas canceladas')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Minhas reservas canceladas'),
                \form_reservas_cancelada
              ]) ]).

form_reservas_cancelada -->
    html(form([ id('reservas_cancelada-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/reservas_canceladas/') ],
              [ \metodo_de_envio('POST'),
                \campo(id_res_cancel, 'ID reservas canceladas', text),
                \campo(reC_data, 'Data', text),
                \campo(reC_hora, 'Hora', text),
                \campo(reC_id_ambiente, 'ID Ambiente', text),
                \campo(reC_id_usuario, 'ID Usuario', text),
                \campo(reC_justificativa, 'Justificativa', text),
                \campo(reC_datetime, 'Datetime', text),
                \campo(reC_user_exclusao, 'Exclusão Usuario', text),
                \enviar_ou_cancelar('/dadosreservas_cancelada')
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



/* Página para edição (alteração) de um reservas_cancelada  */

editar(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( reservas_cancelada:reservas_cancelada(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)
    ->
    reply_html_page(
        boot5rest,
        [ title('reservas canceladas')],
        [ div(class(container),
              [ \html_requires(js('trabalho4.js')),
                h1('Minhas reservas_canceladas'),
                \form_reservas_cancelada(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).


form_reservas_cancelada(Id, IdRes,Data,Hora,IdAmb,IdUs,Just,DateTime,UsExcl) -->
    html(form([ id('reservas_cancelada-form'),
                onsubmit("redirecionaResposta( event, '/' )"),
                action('/api/v1/reservas_canceladas/~w' - Id) ],
              [ \metodo_de_envio('PUT'),
                \campo_nao_editavel(id, 'Id', text, Id),
                 \campo(id_res_cancel, 'ID reservas canceladas', text, IdRes),
                \campo(reC_data, 'Data', text, Data),
                \campo(reC_hora, 'Hora', text,Hora),
                \campo(reC_id_ambiente, 'ID Ambiente', text,IdAmb),
                \campo(reC_id_usuario, 'ID Usuario', text,IdUs),
                \campo(reC_justificativa, 'Justificativa', text, Just),
                \campo(reC_datetime, 'Datetime', text, DateTime),
                \campo(reC_user_exclusao, 'Exclusão Usuario', text,UsExcl),
                \enviar_ou_cancelar('/dadosreservas_cancelada')
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