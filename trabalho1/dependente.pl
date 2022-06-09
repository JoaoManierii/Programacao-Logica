:- module(
       dependente,
       [dependente/16]
   ).

:- use_module(library(persistency)).

:- persistent
   dependente(
            id_usuario:positive_integer,
            id_dependente: positive_integer,
            dep_nome:atom,
            dep_email:atom,
            dep_datanasc:atom,
            dep_sexo:char,
            dep_cpf:integer,
            dep_endereco:atom,
            dep_cep:integer,
            dep_bairro:atom,
            dep_cidade:atom,
            id_estado:integer,
            dep_telefone:integer,
            dep_login:atom,
            dep_senha:atom,
            dep_primeiroacesso:integer
   ).

:- initialization(db_attach('tbl_dependente.pl', [])).


insere(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso):-
    with_mutex(dependente,
               assert_dependente(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso)).

remove(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso):-
    with_mutex(dependente,
               retract_dependente(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso)).

atualiza(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso):-
    with_mutex(dependente,
               (retractall_dependente(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso),
                assert_dependente(IdUser,IdDep,Nome,Email,DataNasc,Sexo,Cpf,End,Cep,Bairro,Cidade,Estado,Tel,Login,Senha,PrimeiroAcesso))).

sincroniza :-
    db_sync(gc(always)).