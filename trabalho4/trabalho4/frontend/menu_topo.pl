/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded('E:/Prolog/trabalho4/frontend/gabaritos/bootstrap5').
:- ensure_loaded('E:/Prolog/trabalho4/frontend/icones').


navegacao(Id) -->
    html(nav([ class='navbar navbar-expand-lg navbar-light bg-light fixed-top'],
             [ div(class('container-fluid'),
                   [
                     button([ class('navbar-toggler'),
                              type(button),
                              'data-bs-toggle'=collapse,
                              'data-bs-target'='#~w'-[Id],
                              'aria-controls'=Id,
                              'aria-expanded'=false,
                              'aria-label'='Toggle navigation'],
                            [span([class='navbar-toggler-icon'], [])]),
                     div([ class(['collapse', 'navbar-collapse']),
                           id=Id ],
                         [ ul([class='navbar-nav ms-auto mb-2 mb-lg-0'],
                              [ \nav_item('/', 'Início'),
                                \nav_item('/dadosconvidado', 'Convidado'),
                                \nav_item('/dadosdependente', 'Dependente'),
                                \nav_item('/dadosreservas_cancelada', 'Reservas Canceladas'),
                                \nav_item('/dadosambiente', 'Ambientes'),
                                \nav_item('/dadosimagens_ambiente', 'Imagens Ambientes'),
                                \nav_item('/dadoscategoria_ambiente', 'Categoria Ambiente')
                              ]) ])
                   ])
             ]) ).

nav_item(Link, Rotulo) -->
    html(li([ class='nav-item'],
            [ a([class='nav-link m-1 menu-item', href=Link], Rotulo) ])).
            
retorna_home --> 
	html(div(class(row), a([ class(['btn', 'btn-primary']),href('/')],'Voltar para o início') )).
	

             