% Configuracao do servidor


% Carrega o servidor e as rotas

:- load_files([ servidor,
                rotas
              ],
              [ silent(true),
                if(not_loaded) ]).

% Inicializa o servidor para ouvir a porta 8000
:- initialization( servidor(8000) ).


% Carrega o frontend

:- load_files([ gabarito(bootstrap5),  % gabarito usando Bootstrap 5
                gabarito(boot5rest),   % Bootstrap 5 com API REST
                frontend(entrada),
                frontend(menu_topo),
                frontend(icones)
              
                
              ],
              [ silent(true),
                if(not_loaded) ]).


% Carrega o backend

:- load_files([ api1(convidados), % API REST
                api1(dependentes),
                api1(reservas_canceladas),
                api1(ambientes),
                api1(categoria_ambientes),
                api1(imagens_ambientes)
              ],
              [ silent(true),
                if(not_loaded) ]).

