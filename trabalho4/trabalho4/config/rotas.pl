% http_handler, http_reply_file
:- use_module(library(http/http_dispatch)).

% http:location
:- use_module(library(http/http_path)).

:- ensure_loaded('E:/Prolog/trabalho4/caminhos').

/***********************************
 *                                 *
 *      Rotas do Servidor Web      *
 *                                 *
 ***********************************/

:- multifile http:location/3.
:- dynamic   http:location/3.

%% http:location(Apelido, Rota, Opções)
%      Apelido é como será chamada uma Rota do servidor.
%      Os apelidos css, icons e js já estão definidos na
%      biblioteca http/http_server_files, os demais precisam
%      ser definidos.

% http:location(img, root(img), []).
http:location(api, root(api), []).
http:location(api1, api(v1), []).
http:location(webfonts, root(webfonts), []).

/**************************
 *                        *
 *      Tratadores        *
 *                        *
 **************************/

% Reconvidado estáticos
:- http_handler( css(.),
                 serve_files_in_directory(dir_css), [prefix]).
/* :- http_handler( img(.),
                 serve_files_in_directory(dir_img), [prefix]). */
:- http_handler( js(.),
                 serve_files_in_directory(dir_js),  [prefix]).
:- http_handler( webfonts(.),
                 serve_files_in_directory(dir_webfonts), [prefix]).
/* :- http_handler( '/favicon.ico',
                 http_reply_file(dir_img('favicon.ico', [])),
                 []). */


/* COLOCAR ROTAS DPS DO FRONTEND */
% Rotas do Frontend

%% A página inicial
:- http_handler( root(.), entrada,   []).



:-use_module(frontend(pg_convidado),[]).

/* Convidado */

%% A página de cadastro das instituições
:- http_handler( root(dadosconvidado), pg_convidado:lista, []).

:- http_handler( root(convidado/cadastro), pg_convidado:cadastro, []).

%% A página para edição de uma instituição existente
:- http_handler( root(convidado/editar/Id), pg_convidado:editar(Id), []).

/* ------------------------- */

:-use_module(frontend(pg_dependente),[]).

/* Dependente  */

%% A página de cadastro das instituições
:- http_handler( root(dadosdependente), pg_dependente:lista, []).

:- http_handler( root(dependente/cadastro), pg_dependente:cadastro, []).



%% A página para edição de uma instituição existente
:- http_handler( root(dependente/editar/Id), pg_dependente:editar(Id), []).

/* ------------------------- */

:-use_module(frontend(pg_reservas_cancelada),[]).

/*  Reservas Canceladas */

%% A página de listagem das instituições
:- http_handler( root(dadosreservas_cancelada), pg_reservas_cancelada:lista, []).

:- http_handler( root(reservas_cancelada/cadastro), pg_reservas_cancelada:cadastro, []).

%% A página para edição de uma instituição existente
:- http_handler( root(reservas_cancelada/editar/Id), pg_reservas_cancelada:editar(Id), []).

/* ---------------------------------- */
:-use_module(frontend(pg_ambiente),[]).

/* Ambiente */

%% A página de cadastro das instituições
:- http_handler( root(dadosambiente), pg_ambiente:lista, []).

:- http_handler( root(ambiente/cadastro), pg_ambiente:cadastro, []).

%% A página para edição de uma instituição existente
:- http_handler( root(ambiente/editar/Id), pg_ambiente:editar(Id), []).

/* ---------------------------------- */
:-use_module(frontend(pg_imagens_ambiente),[]).

/* Imagens Ambiente */

%% A página de cadastro das instituições
:- http_handler( root(dadosimagens_ambiente), pg_imagens_ambiente:lista, []).

:- http_handler( root(imagens_ambiente/cadastro), pg_imagens_ambiente:cadastro, []).

%% A página para edição de uma instituição existente
:- http_handler( root(imagens_ambiente/editar/Id), pg_imagens_ambiente:editar(Id), []).

/* ---------------------------------- */
:-use_module(frontend(pg_categoria_ambiente),[]).

/* Categoria Ambiente */

%% A página de cadastro das instituições
:- http_handler( root(dadoscategoria_ambiente), pg_categoria_ambiente:lista, []).

:- http_handler( root(categoria_ambiente/cadastro), pg_categoria_ambiente:cadastro, []).

%% A página para edição de uma instituição existente
:- http_handler( root(categoria_ambiente/editar/Id), pg_categoria_ambiente:editar(Id), []).

/* ---------------------------------------------------------------------- */
% Rotas da API
:- http_handler( api1(convidados/Id), convidados(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).

:- http_handler( api1(dependentes/Id), dependentes(Metodo, Id),
                [ method(Metodo),
                  methods([ get, post, put, delete ]) ]).

:- http_handler( api1(reservas_canceladas/Id), reservas_canceladas(Metodo, Id),
                [ method(Metodo),
                  methods([ get, post, put, delete ]) ]).

:- http_handler( api1(ambientes/Id), ambientes(Metodo, Id),
                [ method(Metodo),
                  methods([ get, post, put, delete ]) ]).

:- http_handler( api1(imagens_ambientes/Id), imagens_ambientes(Metodo, Id),
                [ method(Metodo),
                  methods([ get, post, put, delete ]) ]).

:- http_handler( api1(categoria_ambientes/Id), categoria_ambientes(Metodo, Id),
                [ method(Metodo),
                  methods([ get, post, put, delete ]) ]).





