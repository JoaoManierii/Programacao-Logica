% Banco de dados

:- multifile user:file_search_path/2.


user:file_search_path(dir_base, 'E:/Prolog/').


user:file_search_path(projeto, dir_base(trabalho4)).


user:file_search_path(config, projeto(config)).



user:file_search_path(frontend, projeto(frontend)).



user:file_search_path(dir_css, frontend(css)).
user:file_search_path(dir_js,  frontend(js)).
user:file_search_path(dir_img, frontend(img)).
% user:file_search_path(dir_webfonts, frontend(webfonts)).



user:file_search_path(gabarito, frontend(gabaritos)).



user:file_search_path(backend, projeto(backend)).



user:file_search_path(bd, backend(bd)).
user:file_search_path(bd_tabs, bd(tabelas)).


user:file_search_path(api,  backend(api)).
user:file_search_path(api1, api(v1)).


% Middle-end
user:file_search_path(middle_end, projeto(middle_end)).

% Coloque aqui todas as tabelas do banco.

tabela(chave).
tabela(convidado).
tabela(dependente).
tabela(reservas_cancelada).
tabela(ambiente).
tabela(imagens_ambiente).
tabela(categoria_ambiente).

 
% Não mexa daqui em diante

:-initialization(carrega_tabelas).


carrega_tabelas():-
    findall(Tab, tabela(Tab), Tabs),
    maplist(carrega_tab,Tabs).

carrega_tab(Tabela):-
    use_module(bd(Tabela),[]),
    atomic_list_concat(['tbl_', Tabela, '.pl'], ArqTab),
    expand_file_search_path(bd_tabs(ArqTab), CaminhoTab),
    Tabela:carrega_tab(CaminhoTab).