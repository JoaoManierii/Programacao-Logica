
          
/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded('E:/Prolog/trabalho4/frontend/gabaritos/boot5rest').


entrada(_):-
    reply_html_page(
        boot5rest,
        [ title('SISTEMA DE GESTAO PARA CLUBES RECREATIVOS E
ESPORTIVOS')],
        [ div(class(container),
              [ \html_requires(css('custom.css')),
                \html_requires(js('trabalho4.js')),
                \navegacao('menu-topo'),
                \propaganda
              ]) ]).
    
propaganda -->
    html(div([ class='container-fluid' ],
             div([ id='propaganda',
                   class='py-5 text-center block block-1'],
                 [
                   h1(class('py-5'), 'SISTEMA DE GESTAO PARA CLUBES RECREATIVOS'),
                   h2(class('py-5'), 'A facilidade para gerir o seu negócio'),
                   p(class(lead),
                     [ 'Bem vindo ao Sistema de Gestão']),
                   p(class(lead),
                     ['Você verá algumas das tabelas'
                     ]),
                   p(class(lead),
                     ['Aqui você poderá inserir os dados necessários para armazenar as informações no banco de dados do seu clube para uma gestão melhor.']),
                   p(class(lead), 'Qualquer duvida contate o suporte.')]))). 